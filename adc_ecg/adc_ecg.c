#include "inc/hw_memmap.h"
#include "inc/hw_types.h"
#include "driverlib/debug.h"
#include "driverlib/sysctl.h"
#include "driverlib/adc.h"
#include "driverlib/gpio.h"
#include "utils/uartstdio.h"
#include "driverlib/uart.h"
#include "driverlib/pin_map.h"
#include "inc/hw_ints.h"
#include "driverlib/interrupt.h"
#include <stdbool.h>

int main(void)
{
	unsigned long ulADC0_Value[1];
	bool running;

	SysCtlClockSet(SYSCTL_SYSDIV_5|SYSCTL_USE_PLL|SYSCTL_XTAL_16MHZ|SYSCTL_OSC_MAIN);

    //
    // Enable GPIO port A which is used for UART0 pins.
    // TODO: change this to whichever GPIO port you are using.
    //
	SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);

    //
    // Configure the pin muxing for UART0 functions on port A0 and A1.
    // This step is not necessary if your part does not support pin muxing.
    // TODO: change this to select the port/pin you are using.
    //
    GPIOPinConfigure(GPIO_PA0_U0RX);
    GPIOPinConfigure(GPIO_PA1_U0TX);

    //
    // Select the alternate (UART) function for these pins.
    // TODO: change this to select the port/pin you are using.
    //
    GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 | GPIO_PIN_1);

    //
    // Initialize the UART for console I/O.
    //
    UARTStdioInit(0);
    running = false;
    //
    // Display the setup on the console.
    //
//    UARTprintf("ADC ->\n");
//    UARTprintf("  Type: Single Ended\n");
//    UARTprintf("  Samples: One\n");
//    UARTprintf("  Update Rate: 250ms\n");
//    UARTprintf("  Input Pin: AIN0/PE3\n\n");

	// >>>>>>>>>>>>> ADC CONFIGURATION <<<<<<<<<<<<<<<<<

	// Enable the clock to the ADC0 module
	SysCtlPeripheralEnable(SYSCTL_PERIPH_ADC0);


	// >>>>>>>>>>>>> GPI CONFIGURATION <<<<<<<<<<<<<<<<<

	// Configure the pin as analog input
	SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOE);

	GPIOPinTypeADC(GPIO_PORTE_BASE, GPIO_PIN_3);

	// Configure the ADC to sample at 500KSps
	SysCtlADCSpeedSet(SYSCTL_ADCSPEED_500KSPS);

	// Disable sample sequences 3
	ADCSequenceDisable(ADC0_BASE, 3);

	// Configure sample sequence 3: timer trigger, priority = 0
	ADCSequenceConfigure(ADC0_BASE, 3, ADC_TRIGGER_PROCESSOR, 0);

	// Configure sample sequence 3 steps 0
	ADCSequenceStepConfigure(ADC0_BASE, 3, 0, ADC_CTL_CH0 | ADC_CTL_IE | ADC_CTL_END);

	ADCSequenceEnable(ADC0_BASE, 3);

    ADCIntEnable(ADC0_BASE, 0);

    // Clear the interrupt status flag.  This is done to make sure the
    // interrupt flag is cleared before we sample.
    ADCIntClear(ADC0_BASE, 3);

    // Sample AIN0 forever.  Display the value on the console.
    while(1)
    {
        if (UARTCharsAvail(UART0_BASE)) {
            char temp;

            temp = UARTCharGetNonBlocking(UART0_BASE);

            if (temp == '1') running = true;
            else if (temp == '0') running = false;
        }
        if (running) {
        	// Trigger the ADC conversion.
        	ADCProcessorTrigger(ADC0_BASE, 3);

        	// Wait for conversion to be completed.
            while(!ADCIntStatus(ADC0_BASE, 3, false))
            {
            }

            // Clear the ADC interrupt flag.
            ADCIntClear(ADC0_BASE, 3);

            // Read ADC Value.
            ADCSequenceDataGet(ADC0_BASE, 3, ulADC0_Value);

            // Display the AIN0 (PE7) digital value on the console.
            unsigned short val = ulADC0_Value[0];

            UARTCharPut(UART0_BASE,(char)(val&0x00FF));
            UARTCharPut(UART0_BASE,(char)((val>>8)&0x00FF));
        }
        // This function provides a means of generating a constant length
        // delay.  The function delay (in cycles) = 3 * parameter.  Delay
        // 250ms arbitrarily.
        SysCtlDelay(SysCtlClockGet() / 3000);
    }
}
