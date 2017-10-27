/*
ECG shield for arduino
feel free to use it
MAREK CERMAK, 2016
*/


#include <SPI.h>
//#include "TFT_22_ILI9225.h"

/*SPI Command Definitions (p.35)*/
//System Commands
#define WAKEUP 0x02
#define STANDBY 0x04
#define RESET 0x06
#define START 0x08
#define STOP 0x0a
//Data Read Commands
#define RDATAC 0x10 //Read Data Continuous (p.36 datasheet)
#define SDATAC 0x11 //Stop Read Data Continuous (p.36-37 datasheet)
#define RDATA 0x12 //Read Data (p.37 datasheet)

//Channel configurations
#define CONFIG1 0x01 //Configuration Register 1 (p.40) 
#define CONFIG2 0x02 //Configuration Register 2 (p.41)
#define CH1SET 0x04 //Channel 1 Settings Address (p. 43)
#define CH2SET 0x05 //Channel 2 Settings Address (p. 44)
#define RLD_SENS 0x06 //Right Leg Settings Address (p.45)
#define RESP1 0x09 //Respiration Control Regsiter 1 Address (p.48)
#define RESP2 0x09 //Respiration Control Regsiter 2 Address (p.49)


#define TESTaa 0xaa
#define TEST55 0x55

/* Prototipos */
String hex_to_char(int); 
int read_byte(int reg_addr);
void send_command(uint8_t cmd);
void write_byte(int reg_addr, int val_hex);
void reset_communication(void);

// filtering IIR

  float koefA [3] ={1, -1.01, 0.73};
  float koefB [3] = {0.0104, 0.0209, 0.0104};
  float x,x1,x2,y,y1,y2 = 0;

  int dalsi = 0;
  byte a = 0;
  byte b = 0;
  byte c = 0;
  long neco[2] = {0, 0};
  long necoSum = 0;
  long offset = 0;
  unsigned long aaa=0;
  unsigned long bbb=0;
  unsigned long ccc=0;
  float necoNeco;
  int necoi_ch1;
  int necoi_ch2;
  long aux_ch =0;

  int rampa=0;

  int mean = 0;
  //int lastY = 0;
  //long pos = 0;
  //uint16_t maxX = 0;
  //uint16_t maxY = 0;


  const int PIN_START = 5;
  const int IPIN_DRDY = 2; //Interrupt pin Data Ready 
  const int PIN_CS = 6; 
  byte chSet;
  byte chSet2;
  const int DOUT = 12;
  const int DIN = 11;
  const int PIN_SCLK = 13;  
  const int PIN_RESET = 4;

  boolean flag = false;
  boolean debug_msg = false;

  boolean gActiveChan [2];
  int nChannels = 2;
  int gMaxChan=2;

// Variables para la trama
  const int max_muestras_trama = 100;
  const int largo_trama = 206; //2 //max_muestras_trama*2 + 6;
  int cont_trama = 5; //2
  
  byte buf_ch1[largo_trama];
  
  byte buf_ch2[largo_trama];
  
  int chksum_ch1=0;
  int chksum_ch2=0;

  char comando; //Comandos que le llegan del graficador

void setup(){

  Serial.begin(115200, SERIAL_8N1);
  Serial.flush();
  delayMicroseconds(100);
  
  // You have to set SPI communication according to datasheet  
  SPI.setDataMode(SPI_MODE1);
  SPI.setClockDivider(SPI_CLOCK_DIV16);
  SPI.setBitOrder(MSBFIRST);
  SPI.begin();

  pinMode(DOUT, OUTPUT);
  pinMode(PIN_SCLK, OUTPUT);
  pinMode(PIN_CS, OUTPUT);
  pinMode(PIN_START, OUTPUT);
  pinMode(PIN_RESET, OUTPUT);
  pinMode(IPIN_DRDY, INPUT);

  reset_communication();
  
  // Wait longer for TI chip to start
  delay(500);
  send_command(SDATAC);
  delay(10);
  if(debug_msg){
    chSet = read_byte(0x00);
    // see datasheet page 39
    Serial.print("-- ID CHIP is:" + String(chSet) + "--");
  }
  //datasheet page 40-44
  write_byte(CONFIG1, 0x01); //Operacion normal: 0x01 (250 SPS), 0x02 (500 SPS), 0x03 (1 kSPS) (p.40)
  write_byte(CONFIG2, 0xA0); //Operacion normal: 0xA0. Test signal 0xA3 (p.41)
  delay(1000);
  
  //this part is just to check if you send and read correct data
  if(debug_msg){
    Serial.println("Check Configs");
    chSet = read_byte(CONFIG1);
    Serial.println("CONFIG1: " + String(chSet) + "\t\t" + hex_to_char(chSet) );
    chSet = read_byte(CONFIG2);
    Serial.println("CONFIG2: " + String(chSet) + "\t\t" + hex_to_char(chSet) );
  }
  
  
  write_byte(CH1SET, 0x30); //Test signal: 0x05. Electrodos normales: 0x00 (amplif. x6), 0x60 (x12) (p.43)
  write_byte(CH2SET, 0x30); //Test signal: 0x05. Electrodos normales: 0x00 (amplif. x6), 0x60 (x12) (p.44)
  write_byte(RLD_SENS, 0x0f); 
  write_byte(RESP1, 0x02); //Para el ADS1292 0x02 (p. 48)
  write_byte(RESP2, 0x08); //(p.49)

  if(debug_msg){
  Serial.println("Check CHSET");
  chSet = read_byte(CH2SET);
  Serial.println("CONFIG1: " + String(chSet) + "\t\t" + hex_to_char(chSet) );
  chSet = read_byte(CH2SET);
  Serial.println("CONFIG2: " + String(chSet) + "\t\t" + hex_to_char(chSet) );
  }
  
  //while(Serial.read()!='1'); //Espera un "1" del graficador
  
  // Start communication, you can use RDATAC or RDATA according to datasheet
  
  //send_command(RDATAC);
  digitalWrite(PIN_START, LOW);
  //delay(150);
  //send_command(START);
  
}//Cierra setup



void loop(){
  if (Serial.available() > 0) {
    comando=Serial.read();
    if(comando=='1'){ //Botón "Start"
      send_command(RDATAC);
      delay(150);
      send_command(START);
    }else if(comando=='2'){ //Botón "Stop"
      send_command(SDATAC);
      delay(10);
      send_command(STOP);
      delay(150);
      //Manda la trama que se estaba armando
      //buf_ch1[3] = cont_trama-5 //Indica la cantidad de bytes de muestras por trama
      //buf_ch2[3] = cont_trama-5 //Indica la cantidad de bytes de muestras por trama
      //buf_ch1[cont_trama+1] = chksum_ch1;
      //buf_ch2[cont_trama+1] = chksum_ch2;
      
      //Serial.write(buf_ch1, cont_trama+1);
      //Serial.write(buf_ch2, cont_trama+1);

      //cont_trama=4;
      //chksum_ch1=0;
      //chksum_ch2=0;
    }else if(comando=='3'){ //Se cierra la ventana del graficador
      delay(150);
      reset_communication();
    }
  }

  if (digitalRead(IPIN_DRDY) == LOW && dalsi == 0) {
    dalsi = 1; 
    int numSerialBytes = 3 + (3 * nChannels); //8-bits header plus 24-bits per ACTIVE channel
    int i = 0;
    unsigned char serialBytes[numSerialBytes];
    
    // start see page 36 for details
    digitalWrite(PIN_CS, LOW);
    delayMicroseconds(1);
    
    // page 28-29 - 24bits of status bit
    serialBytes[i++] = SPI.transfer(0x00); // get 1st byte of header
    SPI.transfer(0x00); //skip 2nd byte of header
    SPI.transfer(0x00); //skip 3rd byte of header
    
    // page 28-29 - 24bits of data per channel (2 channels)
    for (int ch = 1; ch <= gMaxChan; ch++) {
    	
      a = SPI.transfer(0x00);
      b = SPI.transfer(0x00);
      c = SPI.transfer(0x00);
      
      //if(ch==1){
      // data conversion, data are in twos complement, page 28
      if (a>0x7F) { //Escala negativa (dato recibido menor a Vref)
        a=~a;
        b=~b;
        c=~c; 
        aaa=(unsigned int)a<<8;
        aaa=aaa<<8;
        bbb=(unsigned int)b<<8;
        ccc=(unsigned int)c;
        aux_ch=aaa|bbb|ccc;
        aux_ch=aux_ch+1;
        neco[ch-1]=-aux_ch;		
      }
      else {//Escala positiva (dato recibido mayor a Vref)
        aaa=(unsigned int)a<<8;
        aaa=aaa<<8;
        bbb=(unsigned int)b<<8;
        ccc=(unsigned int)c;
        neco[ch-1]=aaa|bbb|ccc;
      }
      /*}else{
      rampa++;
      neco[ch-1]=rampa;
      }*/
      //} //Cierra el if(ch==X)
    }//Cierra el for de los canales
    
    digitalWrite(PIN_CS, HIGH); 
    delayMicroseconds(1);
    
    /* simple IIR filtering, probably would be better use FIR and moving average if you want smooth signal
     y = koefA[0]*x + koefA[1]*x1 + koefA[2]*x2 - koefB[1]*y1 - koefB[2]*y2;
     necoNeco = int(y);
     x2 = x1;
     x1 = x;
     y2 = y1;
     y1 = y;
      */
      
    necoi_ch1=(int)(neco[0]/256);
    necoi_ch2=(int)(neco[1]/256);
    
    //Serial.write(rampa & 0x00ff);
    //Serial.write((rampa & 0xff00)>>8);
    
    //Serial.println(neco);
    
//    buf_ch1[0]=necoi_ch1 & 0x00ff;
//    buf_ch1[1]=(necoi_ch1 & 0xff00)>>8;
//
//    buf_ch2[0]=necoi_ch2 & 0x00ff;
//    buf_ch2[1]=(necoi_ch2 & 0xff00)>>8;
//
//    Serial.write(buf_ch1, sizeof(buf_ch1));
//    Serial.write(buf_ch2, sizeof(buf_ch2));
    /* Para el checksum*/
    if (cont_trama < (largo_trama-1)){

      buf_ch1[cont_trama]=necoi_ch1 & 0x00ff;
      buf_ch1[cont_trama+1]=(necoi_ch1 & 0xff00)>>8;

      buf_ch2[cont_trama]=necoi_ch2 & 0x00ff;
      buf_ch2[cont_trama+1]=(necoi_ch2 & 0xff00)>>8;

      chksum_ch1 = chksum_ch1 ^ buf_ch1[cont_trama] ^ buf_ch1[cont_trama+1];
      chksum_ch2 = chksum_ch2 ^ buf_ch2[cont_trama] ^ buf_ch2[cont_trama+1];

      cont_trama += 2;
    }else{
      buf_ch1[0]=0x00;
      buf_ch1[1]=0xFF;
      buf_ch1[2]=0x00;
      buf_ch1[3] = max_muestras_trama; //Indica la cantidad de bytes de muestras por trama
      buf_ch1[4] = 0x01; //Identifica el canal
      
      buf_ch2[0]=0x00;
      buf_ch2[1]=0xFF;
      buf_ch2[2]=0x00;
      buf_ch2[3] = max_muestras_trama*2; //Indica la cantidad de bytes de muestras por trama
      buf_ch2[4] = 0x02; //Identifica el canal

      buf_ch1[largo_trama-1] = chksum_ch1;
      buf_ch2[largo_trama-1] = chksum_ch2;
    
//      for(int i=0;i<largo_trama;i++){
//        Serial.print(buf_ch1[i], HEX);
//        Serial.print("\n");
//      } 
//      Serial.print("Fin trama1\n");
//      for(int i=0;i<largo_trama;i++){
//        Serial.print(buf_ch2[i], HEX);
//        Serial.print("\n");
//      } 
//      Serial.print("Fin trama2\n");
      
      Serial.write(buf_ch1, sizeof(buf_ch1));
      Serial.write(buf_ch2, sizeof(buf_ch2));

      cont_trama=5;
      chksum_ch1=0;
      chksum_ch2=0;
    }
    
    //Serial.println(neco);
  }
  
  if (digitalRead(IPIN_DRDY) == HIGH && dalsi == 1) {
    dalsi = 0;
  }

}//ciera el loop()


String hex_to_char(int hex_in) {
  int precision = 2;
  char tmp[16];
  char format[128];
  sprintf(format, "0x%%.%dX", precision);
  sprintf(tmp, format, hex_in);
  return(String(tmp));
}

// see datasheet 38
int read_byte(int reg_addr){
  int out = 0;
  digitalWrite(PIN_CS, LOW);
  SPI.transfer(0x20 | reg_addr);
  delayMicroseconds(5);
  SPI.transfer(0x00);
  delayMicroseconds(5);
  out = SPI.transfer(0x00);
  delayMicroseconds(1);
  digitalWrite(PIN_CS, HIGH);

  Serial.println( "sent:\t" + hex_to_char(reg_addr) );
  Serial.println( "recieved:\t" + hex_to_char(out) );

  return(out);
}

void send_command(uint8_t cmd) {
  digitalWrite(PIN_CS, LOW);
  delayMicroseconds(5); 
  SPI.transfer(cmd);
  delayMicroseconds(10);
  digitalWrite(PIN_CS, HIGH);
}

//see page 38
void write_byte(int reg_addr, int val_hex) {
  digitalWrite(PIN_CS, LOW);
  delayMicroseconds(5);
  SPI.transfer(0x40 | reg_addr);
  delayMicroseconds(5);
  SPI.transfer(0x00);
  delayMicroseconds(5);
  SPI.transfer(val_hex);
  delayMicroseconds(10);
  digitalWrite(PIN_CS, HIGH);

}


void reset_communication(void){
//Resetea la comunicación (datasheet p.30)
  digitalWrite(PIN_CS, HIGH);
  digitalWrite(PIN_RESET, HIGH);
  delay(1000);
  digitalWrite(PIN_RESET, LOW);
  delay(1000);
  digitalWrite(PIN_RESET, HIGH);
  delay(100);  
  digitalWrite(PIN_CS, LOW);
  delay(1000);
  digitalWrite(PIN_CS, HIGH);
}
