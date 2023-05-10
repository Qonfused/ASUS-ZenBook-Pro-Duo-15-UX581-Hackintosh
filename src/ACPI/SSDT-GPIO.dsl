/*
 * Enables GPIO device and pinning for Trackpad and Primary/Secondary displays.
 * @see https://github.com/VoodooI2C/VoodooI2C/blob/master/Documentation/GPIO%20Pinning.md
 */
DefinitionBlock ("", "SSDT", 2, "UX581", "GPI0", 0x00000000)
{
    External (_SB_.PCI0.I2C1.ETPD, DeviceObj)
    External (GPHD, IntObj)
    External (USTP, IntObj)
    // config.plist ACPI > Patch renames
    External (_SB_.PCI0.I2C1.ETPD.XCRS, MethodObj)

    If (_OSI ("Darwin"))
    {
        // Enables _STA method in GPIO device
        GPHD = Zero
        // Enables correct SSCN and FMCN bus timings for each I2C controller.
        USTP = One
    }

    // GPIO - Trackpad
    Scope (_SB.PCI0.I2C1.ETPD)
    {
        Name (SBFG, ResourceTemplate ()
        {
            GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x0117
                }
        })
        
        Method (_CRS, 0, Serialized)
        {
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            If (_OSI ("Darwin"))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
            Else { Return (XCRS ()) }
        }
    }
}