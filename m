Date: Sun, 4 Feb 2018 11:42:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.1
Message-ID: <20180204104256.GA7475@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.1 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                               |    2=20
 arch/x86/crypto/aesni-intel_asm.S                      |  199 ++++--------=
-----
 arch/x86/crypto/aesni-intel_glue.c                     |   70 ++++-
 crypto/Kconfig                                         |    2=20
 crypto/af_alg.c                                        |   10=20
 crypto/sha3_generic.c                                  |    5=20
 drivers/android/binder.c                               |   12 +
 drivers/android/binder_alloc.c                         |    2=20
 drivers/bluetooth/hci_serdev.c                         |    1=20
 drivers/crypto/inside-secure/safexcel_hash.c           |   56 +++-
 drivers/firmware/efi/Kconfig                           |    5=20
 drivers/gpio/gpio-ath79.c                              |    3=20
 drivers/gpio/gpio-iop.c                                |    4=20
 drivers/gpio/gpio-stmpe.c                              |   20 -
 drivers/gpio/gpiolib.c                                 |    3=20
 drivers/hid/wacom_sys.c                                |   24 +-
 drivers/hid/wacom_wac.c                                |   16 -
 drivers/iio/adc/stm32-adc.c                            |    3=20
 drivers/iio/chemical/ccs811.c                          |   13 -
 drivers/input/rmi4/rmi_driver.c                        |   14 -
 drivers/input/rmi4/rmi_f03.c                           |   64 ++++-
 drivers/misc/mei/pci-me.c                              |    5=20
 drivers/mtd/nand/denali_pci.c                          |    4=20
 drivers/net/ethernet/intel/igb/igb_main.c              |    2=20
 drivers/power/reset/zx-reboot.c                        |    4=20
 drivers/scsi/aacraid/aachba.c                          |   15 -
 drivers/scsi/aacraid/commsup.c                         |    9=20
 drivers/scsi/storvsc_drv.c                             |    4=20
 drivers/spi/spi-imx.c                                  |   15 +
 drivers/staging/ccree/ssi_cipher.c                     |    1=20
 drivers/staging/ccree/ssi_driver.c                     |    2=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    7=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |    2=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    6=20
 drivers/tty/serial/8250/8250_dw.c                      |   30 +-
 drivers/tty/serial/8250/8250_of.c                      |    5=20
 drivers/tty/serial/8250/8250_uniphier.c                |    5=20
 drivers/tty/serial/imx.c                               |   14 -
 drivers/tty/tty_io.c                                   |    8=20
 drivers/tty/tty_ldisc.c                                |    4=20
 drivers/usb/class/cdc-acm.c                            |    5=20
 drivers/usb/gadget/function/f_fs.c                     |    3=20
 drivers/usb/gadget/udc/core.c                          |    2=20
 drivers/usb/serial/Kconfig                             |    1=20
 drivers/usb/serial/io_edgeport.c                       |    1=20
 drivers/usb/serial/option.c                            |    5=20
 drivers/usb/serial/pl2303.c                            |    1=20
 drivers/usb/serial/pl2303.h                            |    1=20
 drivers/usb/serial/usb-serial-simple.c                 |    7=20
 drivers/usb/storage/uas.c                              |    7=20
 include/linux/tty.h                                    |    2=20
 lib/test_firmware.c                                    |    1=20
 security/integrity/ima/ima_policy.c                    |    2=20
 sound/pci/hda/patch_realtek.c                          |    6=20
 tools/gpio/gpio-event-mon.c                            |    1=20
 tools/usb/usbip/src/usbip_bind.c                       |    9=20
 tools/usb/usbip/src/usbip_list.c                       |    9=20
 57 files changed, 424 insertions(+), 309 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: EKR: ensure devres groups at higher indexes are released

Andy Shevchenko (1):
      serial: 8250_dw: Revert "Improve clock rate setting"

Antoine Tenart (2):
      crypto: inside-secure - fix hash when length is a multiple of a block
      crypto: inside-secure - avoid unmapping DMA memory that was not mapped

Ard Biesheuvel (1):
      crypto: sha3-generic - fixes for alignment and big endian operation

Benjamin Herrenschmidt (1):
      usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Dan Carpenter (1):
      scsi: storvsc: missing error code in storvsc_probe()

Dmitry Eremin (1):
      staging: lustre: separate a connection destroy from free struct kib_c=
onn

Dmitry Torokhov (2):
      Input: synaptics-rmi4 - unmask F03 interrupts when port is opened
      Input: synaptics-rmi4 - do not delete interrupt memory too early

Fabio Estevam (1):
      serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Fabrice Gasnier (1):
      iio: adc: stm32: fix scan of multiple channels with DMA

Ganesh Mahendran (1):
      android: binder: use VM_ALLOC to get vm area

Gaurav Kohli (1):
      tty: fix data race between tty_init_dev and flush of buf

Gilad Ben-Yossef (2):
      staging: ccree: NULLify backup_info when unused
      staging: ccree: fix fips event irq handling build

Greg Kroah-Hartman (2):
      USB: serial: pl2303: new device id for Chilitag
      Linux 4.15.1

Hans de Goede (1):
      USB: cdc-acm: Do not log urb submission errors on disconnect

Hauke Mehrtens (1):
      crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound

Jason Gerecke (1):
      HID: wacom: Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) =
events

Jesse Chan (4):
      power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
      mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic

Joel Stanley (1):
      tools/gpio: Fix build error with musl libc

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra driver

Junaid Shahid (2):
      crypto: aesni - Fix out-of-bounds access of the data buffer in generi=
c-gcm-aesni
      crypto: aesni - Fix out-of-bounds access of the AAD buffer in generic=
-gcm-aesni

Linus Walleij (1):
      gpio: Fix kernel stack leak to userspace

Lukas Wunner (1):
      Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops

Lyude Paul (1):
      igb: Free IRQs when device is hotplugged

Martijn Coenen (1):
      ANDROID: binder: remove waitqueue when thread exits.

Masahiro Yamada (1):
      serial: 8250_of: fix return code when probe function fails to get res=
et

Matthew Garrett (1):
      x86/efi: Clarify that reset attack mitigation needs appropriate users=
pace

Mike Rapoport (1):
      ima/policy: fix parsing of fsuuid

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels

OKAMOTO Yoshiaki (1):
      usb: option: Add support for FS040U modem

Oliver Neukum (2):
      CDC-ACM: apply quirk for card reader
      usb: uas: unconditionally bring back host after reset

Patrice Chotard (1):
      gpio: stmpe: i2c transfer are forbiden in atomic context

Raghava Aditya Renukunta (2):
      scsi: aacraid: Fix udev inquiry race condition
      scsi: aacraid: Fix hang in kdump

Sabrina Dubroca (2):
      crypto: aesni - fix typo in generic_gcmaes_decrypt
      crypto: aesni - add wrapper for generic gcm(aes)

Shuah Khan (2):
      usbip: prevent bind loops on devices attached to vhci_hcd
      usbip: list: don't list devices attached to vhci_hcd

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled

Stephan Mueller (2):
      crypto: aesni - handle zero length dst buffer
      crypto: af_alg - whitelist mask and type

Takashi Iwai (1):
      ALSA: hda - Reduce the suspend time consumption for ALC256

Tomas Winkler (1):
      mei: me: allow runtime pm for platform with D0i3

Wei Yongjun (2):
      serial: 8250_uniphier: fix error return code in uniphier_uart_probe()
      test_firmware: fix missing unlock on error in config_num_requests_sto=
re()


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlp247AACgkQONu9yGCS
aT7y1g//c6pKwwzM8clc+90+ZZca2Etk6ci6Yv4eqgrtcCuBsCg3OB/SM23BCmu0
M1En0+uen8TwWv4clhQtJQAl1Il/opAVXPPWHCCIKycapNHwBuRyAf71dGoumhkF
JCIrRpFJkKiyquh4cyXz+sYuNM8c5e+tjLssNICNP76J3RKckAUJcbI3jS8IGqo8
wrIT1VtAmqUSBlZl2vCu+g6cJ+6A9qS58+zDYSszBZpthC2HXvsXArebRccbT0Mo
4i/npPQyCweXcnyC9LpmzBnsRILb+JZVAUwM95nYngP8jWxc96zYDyNDF2fkUHB0
xg7MU/EYv/4OxW7yuBBEHNPRDp/aRtsMYjnbKCXqHyV8dBchNZeg9zXRQPJEI3ic
jjIAUmCWgI81WqyFUQGBtW4r12HTn/H4YifO0BnujBzLO6GnUfvwFzuh7XrXEl8c
I4UBN+nYwBsfYGaeuURNvRDEuhqXeJc3GHHthKAvrUUHw0kLiIA1hOll1adiTxtJ
0Vqkbr4XerhAWWunFnjJrm00BTAlg5TzckzZ4P6UcJApTeLfNAsqYzsAJ6HE209V
/pU14k7YTII7I6pUHIVSvQVi2wzol/Qnksjmxk3mjeaRziPfN/ikfOamLqh9ekyN
CyaE42dVvIqLh3H5/T5TdXCqDcimfGLllsZCnmIpsqY660mfEWY=
=zXuq
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
