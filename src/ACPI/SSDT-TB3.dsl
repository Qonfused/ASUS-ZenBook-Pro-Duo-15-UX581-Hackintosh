/*
 * Thunderbolt-3 Hotplug patch
 * @see https://www.tonymacx86.com/threads/in-progress-ssdt-for-thunderbolt-3-hotplug.248784/
 */
DefinitionBlock ("", "SSDT", 2, "UX582", "TBTTITAN", 0x00000000)
{
  External (_SB_.PCI0.RP21, DeviceObj)
  External (_SB_.PCI0.RP21.PXSX, DeviceObj)
  External (DTGP, MethodObj)

  If (_OSI ("Darwin"))
  {
    Scope (\_SB.PCI0.RP21)
    {
      Scope (PXSX) {
        Name (_STA, Zero)
      }

      Method (_RMV, 0, NotSerialized) { Return (Zero) }

      Device (UPSB)
      {
        Name (_ADR, Zero)
        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
        Field (A1E0, ByteAcc, NoLock, Preserve)
        {
            AVND,   32, 
            BMIE,   3, 
            Offset (0x18), 
            PRIB,   8, 
            SECB,   8, 
            SUBB,   8, 
            Offset (0x1E), 
                ,   13, 
            MABT,   1
        }

        Method (_PRW, 0, NotSerialized)
        {
          Return (Package (0x02) { 0x69, 0x03 })
        }

        Method (_BBN, 0, NotSerialized) {
          Return (SECB)
        }

        Method (_STA, 0, NotSerialized)
        {
          Return (0x0F)
        }

        Method (_RMV, 0, NotSerialized)
        {
          Return (Zero)
        }

        Method (_DSM, 4, NotSerialized)
        {
          Local0 = Package (0x06)
          {
            "AAPL,slot-name", 
            Buffer (0x07) { "Slot-4" }, 

            "built-in", 
            Buffer (One) { 0x00 }, 

            "PCI-Thunderbolt", 
            One
          }
          DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
          Return (Local0)
        }

        Device (DSB0)
        {
          Name (_ADR, Zero)
          OperationRegion (A1E0, PCI_Config, Zero, 0x40)
          Field (A1E0, ByteAcc, NoLock, Preserve)
          {
            AVND,   32, 
            BMIE,   3, 
            Offset (0x18), 
            PRIB,   8, 
            SECB,   8, 
            SUBB,   8, 
            Offset (0x1E), 
                ,   13, 
            MABT,   1
          }

          Method (_STA, 0, NotSerialized)
          {
            Return (0x0F)
          }

          Method (_RMV, 0, NotSerialized)
          {
            Return (Zero)
          }

          Method (_PRW, 0, NotSerialized)
          {
            Return (Package (0x02) { 0x69, 0x03 })
          }

          Method (_BBN, 0, NotSerialized)
          {
            Return (SECB)
          }

          Method (_DSM, 4, NotSerialized)
          {
            Local0 = Package (0x06)
            {
              "AAPL,slot-name", 
              Buffer (0x07) { "Slot-4" }, 

              "built-in", 
              Buffer (One) { 0x00 }, 

              "PCIHotplugCapable", 
              Zero
            }
            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
            Return (Local0)
          }

          Device (NHI0)
          {
            Name (_ADR, Zero)
            Name (_STR, Unicode ("Thunderbolt"))
            Method (_STA, 0, NotSerialized)
            {
              Return (0x0F)
            }

            Method (_PRW, 0, NotSerialized)
            {
              Return (Package (0x02) { 0x69, 0x03 })
            }

            Method (_RMV, 0, NotSerialized)
            {
              Return (Zero)
            }

            Method (_DSM, 4, NotSerialized)
            {
              Local0 = Package (0x11)
              {
                "AAPL,slot-name", 
                Buffer (0x07) { "Slot-4" },

                "name", 
                Buffer (0x23) { "Titan Ridge Thunderbolt Controller" }, 

                "model", 
                Buffer (0x2C) { "Intel JHL7540 Titan Ridge Thunderbolt 3 NHI" }, 

                "device_type", 
                Buffer (0x17) {  "Thunderbolt-Controller" }, 

                "ThunderboltDROM", 
                Buffer (0x6B)
                {
                  /* 0000 */  0xBB, 0x00, 0xCE, 0x8C, 0xBA, 0xB4, 0x7F, 0x56,
                  /* 0008 */  0x00, 0x72, 0x33, 0x13, 0x5A, 0x01, 0x5E, 0x00,
                  /* 0010 */  0x31, 0x00, 0x99, 0x60, 0x01, 0x3E, 0x08, 0x81,
                  /* 0018 */  0x80, 0x02, 0x80, 0x00, 0x00, 0x00, 0x08, 0x82,
                  /* 0020 */  0x90, 0x01, 0x80, 0x00, 0x00, 0x00, 0x08, 0x83,
                  /* 0028 */  0x80, 0x04, 0x80, 0x01, 0x00, 0x00, 0x08, 0x84,
                  /* 0030 */  0x90, 0x03, 0x80, 0x01, 0x00, 0x00, 0x05, 0x85,
                  /* 0038 */  0x50, 0x00, 0x00, 0x05, 0x86, 0x50, 0x00, 0x00,
                  /* 0040 */  0x02, 0x87, 0x0B, 0x88, 0x20, 0x01, 0x00, 0x64,
                  /* 0048 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x89, 0x80,
                  /* 0050 */  0x05, 0x8A, 0x50, 0x00, 0x00, 0x05, 0x8B, 0x50,
                  /* 0058 */  0x00, 0x00, 0x07, 0x01, 0x41, 0x53, 0x55, 0x53,
                  /* 0060 */  0x00, 0x0A, 0x02, 0x55, 0x58, 0x35, 0x38, 0x32,
                  /* 0068 */  0x4C, 0x52, 0x00
                }, 

                "ThunderboltConfig", 
                Buffer (0x20)
                {
                  /* 0000 */  0x00, 0x02, 0x1C, 0x00, 0x02, 0x00, 0x05, 0x03,
                  /* 0008 */  0x01, 0x00, 0x04, 0x00, 0x05, 0x03, 0x02, 0x00,
                  /* 0010 */  0x03, 0x00, 0x05, 0x03, 0x01, 0x00, 0x00, 0x00,
                  /* 0018 */  0x03, 0x03, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00
                }, 

                "linkDetails", 
                Buffer (0x08) { 0x08, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00 }, 

                "power-save", 
                One, 
                Buffer (One) { 0x00 }
              }
              DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
              Return (Local0)
            }
          }
        }

        Device (DSB1)
        {
          Name (_ADR, 0x00010000)
          OperationRegion (A1E0, PCI_Config, Zero, 0x40)
          Field (A1E0, ByteAcc, NoLock, Preserve)
          {
            AVND,   32, 
            BMIE,   3, 
            Offset (0x18), 
            PRIB,   8, 
            SECB,   8, 
            SUBB,   8, 
            Offset (0x1E), 
                ,   13, 
            MABT,   1
          }

          Method (_PRW, 0, NotSerialized)
          {
            Return (Package (0x02) { 0x69, 0x03 })
          }

          Method (_BBN, 0, NotSerialized)
          {
            Return (SECB)
          }

          Method (_STA, 0, NotSerialized)
          {
            Return (0x0F)
          }

          Method (_RMV, 0, NotSerialized)
          {
            Return (Zero)
          }
        }

        Device (DSB2)
        {
          Name (_ADR, 0x00020000)
          OperationRegion (A1E0, PCI_Config, Zero, 0x40)
          Field (A1E0, ByteAcc, NoLock, Preserve)
          {
            AVND,   32, 
            BMIE,   3, 
            Offset (0x18), 
            PRIB,   8, 
            SECB,   8, 
            SUBB,   8, 
            Offset (0x1E), 
                ,   13, 
            MABT,   1
          }

          Method (_PRW, 0, NotSerialized)
          {
            Return (Package (0x02) { 0x69, 0x03 })
          }

          Method (_BBN, 0, NotSerialized)
          {
            Return (SECB)
          }

          Method (_STA, 0, NotSerialized)
          {
            Return (0x0F)
          }

          Method (_RMV, 0, NotSerialized)
          {
            Return (Zero)
          }

          Device (XHC3)
          {
            Name (_ADR, Zero)
            Method (_STA, 0, NotSerialized)
            {
              Return (0x0F)
            }

            Method (_RMV, 0, NotSerialized)
            {
              Return (Zero)
            }

            Method (_DSM, 4, NotSerialized)
            {
              Local0 = Package (0x18)
              {
                "AAPL,slot-name", 
                Buffer (0x07) { "Slot-4" }, 

                "built-in", 
                Buffer (One) { 0x00 }, 

                "name", 
                Buffer (0x1F) { "Titan Ridge USB 3.1 Controller" }, 

                "model", 
                Buffer (0x22) { "Intel JHL7540 Titan Ridge USB 3.1" }, 

                "device_type", 
                Buffer (0x1F) { "USB eXtensible Host-Controller" }, 

                "AAPL,current-available", 
                0x0834, 
                "AAPL,current-extra", 
                0x0A8C, 
                "AAPL,current-in-sleep", 
                0x0A8C, 
                "AAPL,max-port-current-in-sleep", 
                0x0834, 
                "AAPL,device-internal", 
                Zero, 
                "AAPL,root-hub-depth", 
                0x1A, 
                "AAPL,XHC-clock-id", 
                One
              }
              DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
              Return (Local0)
            }

            Method (_PRW, 0, NotSerialized)
            {
              Return (Package (0x02) { 0x69, 0x03 })
            }

            Device (RHUB)
            {
              Name (_ADR, Zero)
              Method (_RMV, 0, NotSerialized)
              {
                Return (Zero)
              }

              Device (HS01)
              {
                  Name (_ADR, One)
                  Name (_UPC, Package (0x04) { 0xFF, 0x09, Zero, Zero })
                  Name (_PLD, Package (0x01)
                  {
                    ToPLD (
                      PLD_Revision           = 0x1,
                      PLD_IgnoreColor        = 0x1,
                      PLD_Red                = 0x0,
                      PLD_Green              = 0x0,
                      PLD_Blue               = 0x0,
                      PLD_Width              = 0x0,
                      PLD_Height             = 0x0,
                      PLD_UserVisible        = 0x1,
                      PLD_Dock               = 0x0,
                      PLD_Lid                = 0x0,
                      PLD_Panel              = "UNKNOWN",
                      PLD_VerticalPosition   = "UPPER",
                      PLD_HorizontalPosition = "LEFT",
                      PLD_Shape              = "UNKNOWN",
                      PLD_GroupOrientation   = 0x0,
                      PLD_GroupToken         = 0x0,
                      PLD_GroupPosition      = 0x0,
                      PLD_Bay                = 0x0,
                      PLD_Ejectable          = 0x0,
                      PLD_EjectRequired      = 0x0,
                      PLD_CabinetNumber      = 0x0,
                      PLD_CardCageNumber     = 0x0,
                      PLD_Reference          = 0x0,
                      PLD_Rotation           = 0x0,
                      PLD_Order              = 0x0,
                      PLD_VerticalOffset     = 0x0,
                      PLD_HorizontalOffset   = 0x0)
                  })
              }

              Device (HS02)
              {
                Name (_ADR, 0x02)
                Name (_UPC, Package (0x04) { 0xFF, 0x09, Zero, Zero })
                Name (_PLD, Package (0x01)
                {
                  ToPLD (
                    PLD_Revision           = 0x1,
                    PLD_IgnoreColor        = 0x1,
                    PLD_Red                = 0x0,
                    PLD_Green              = 0x0,
                    PLD_Blue               = 0x0,
                    PLD_Width              = 0x0,
                    PLD_Height             = 0x0,
                    PLD_UserVisible        = 0x1,
                    PLD_Dock               = 0x0,
                    PLD_Lid                = 0x0,
                    PLD_Panel              = "UNKNOWN",
                    PLD_VerticalPosition   = "UPPER",
                    PLD_HorizontalPosition = "LEFT",
                    PLD_Shape              = "UNKNOWN",
                    PLD_GroupOrientation   = 0x0,
                    PLD_GroupToken         = 0x0,
                    PLD_GroupPosition      = 0x0,
                    PLD_Bay                = 0x0,
                    PLD_Ejectable          = 0x0,
                    PLD_EjectRequired      = 0x0,
                    PLD_CabinetNumber      = 0x0,
                    PLD_CardCageNumber     = 0x0,
                    PLD_Reference          = 0x0,
                    PLD_Rotation           = 0x0,
                    PLD_Order              = 0x0,
                    PLD_VerticalOffset     = 0x0,
                    PLD_HorizontalOffset   = 0x0)
                })
              }

              Device (SSP1)
              {
                Name (_ADR, 0x03)
                Name (_UPC, Package (0x04) { 0xFF, 0x09, Zero, Zero })
                Name (_PLD, Package (0x01)
                {
                  ToPLD (
                    PLD_Revision           = 0x1,
                    PLD_IgnoreColor        = 0x1,
                    PLD_Red                = 0x0,
                    PLD_Green              = 0x0,
                    PLD_Blue               = 0x0,
                    PLD_Width              = 0x0,
                    PLD_Height             = 0x0,
                    PLD_UserVisible        = 0x1,
                    PLD_Dock               = 0x0,
                    PLD_Lid                = 0x0,
                    PLD_Panel              = "UNKNOWN",
                    PLD_VerticalPosition   = "UPPER",
                    PLD_HorizontalPosition = "LEFT",
                    PLD_Shape              = "UNKNOWN",
                    PLD_GroupOrientation   = 0x0,
                    PLD_GroupToken         = 0x0,
                    PLD_GroupPosition      = 0x0,
                    PLD_Bay                = 0x0,
                    PLD_Ejectable          = 0x0,
                    PLD_EjectRequired      = 0x0,
                    PLD_CabinetNumber      = 0x0,
                    PLD_CardCageNumber     = 0x0,
                    PLD_Reference          = 0x0,
                    PLD_Rotation           = 0x0,
                    PLD_Order              = 0x0,
                    PLD_VerticalOffset     = 0x0,
                    PLD_HorizontalOffset   = 0x0)
                })
                Method (_DSM, 4, NotSerialized)
                {
                  If ((Arg2 == Zero))
                  {
                    Return (Buffer (One) { 0x03 })
                  }

                  Return (Package (0x04)
                  {
                    "UsbCPortNumber", 
                    One, 
                    "UsbPowerSource", 
                    One
                  })
                }
              }

              Device (SSP2)
              {
                Name (_ADR, 0x04)
                Name (_UPC, Package (0x04) { 0xFF, 0x09, Zero, Zero })
                Name (_PLD, Package (0x01)
                {
                  ToPLD (
                    PLD_Revision           = 0x1,
                    PLD_IgnoreColor        = 0x1,
                    PLD_Red                = 0x0,
                    PLD_Green              = 0x0,
                    PLD_Blue               = 0x0,
                    PLD_Width              = 0x0,
                    PLD_Height             = 0x0,
                    PLD_UserVisible        = 0x1,
                    PLD_Dock               = 0x0,
                    PLD_Lid                = 0x0,
                    PLD_Panel              = "UNKNOWN",
                    PLD_VerticalPosition   = "UPPER",
                    PLD_HorizontalPosition = "LEFT",
                    PLD_Shape              = "UNKNOWN",
                    PLD_GroupOrientation   = 0x0,
                    PLD_GroupToken         = 0x0,
                    PLD_GroupPosition      = 0x0,
                    PLD_Bay                = 0x0,
                    PLD_Ejectable          = 0x0,
                    PLD_EjectRequired      = 0x0,
                    PLD_CabinetNumber      = 0x0,
                    PLD_CardCageNumber     = 0x0,
                    PLD_Reference          = 0x0,
                    PLD_Rotation           = 0x0,
                    PLD_Order              = 0x0,
                    PLD_VerticalOffset     = 0x0,
                    PLD_HorizontalOffset   = 0x0)
                })
                Method (_DSM, 4, NotSerialized) 
                {
                  If ((Arg2 == Zero))
                  {
                    Return (Buffer (One) { 0x03 })
                  }

                  Return (Package (0x04)
                  {
                    "UsbCPortNumber", 
                    0x02, 
                    "UsbPowerSource", 
                    0x02
                  })
                }
              }
            }
          }
        }

        Device (DSB4)
        {
          Name (_ADR, 0x00040000)
          OperationRegion (A1E0, PCI_Config, Zero, 0x40)
          Field (A1E0, ByteAcc, NoLock, Preserve)
          {
            AVND,   32, 
            BMIE,   3, 
            Offset (0x18), 
            PRIB,   8, 
            SECB,   8, 
            SUBB,   8, 
            Offset (0x1E), 
                ,   13, 
            MABT,   1
          }

          Method (_PRW, 0, NotSerialized)
          {
            Return (Package (0x02) { 0x69, 0x03 })
          }

          Method (_BBN, 0, NotSerialized)
          {
            Return (SECB)
          }

          Method (_STA, 0, NotSerialized)
          {
            Return (0x0F)
          }

          Method (_RMV, 0, NotSerialized)
          {
            Return (Zero)
          }
        }
      }
    }
  }
}