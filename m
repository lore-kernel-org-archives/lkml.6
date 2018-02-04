Date: Sun, 4 Feb 2018 11:42:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.80
Message-ID: <20180204104213.GA7381@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.80 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/arm/boot/dts/bcm-nsp.dtsi                          |    4=20
 arch/x86/crypto/aesni-intel_glue.c                      |    2=20
 arch/x86/include/asm/kvm_host.h                         |    3=20
 arch/x86/kvm/emulate.c                                  |    7 +
 arch/x86/kvm/ioapic.c                                   |   20 +++-
 arch/x86/kvm/vmx.c                                      |    4=20
 arch/x86/kvm/x86.c                                      |   13 +-
 crypto/Kconfig                                          |    2=20
 crypto/af_alg.c                                         |   10 +-
 crypto/sha3_generic.c                                   |    5 -
 drivers/acpi/device_sysfs.c                             |    4=20
 drivers/auxdisplay/Kconfig                              |    1=20
 drivers/block/loop.c                                    |   10 +-
 drivers/cpufreq/Kconfig                                 |    2=20
 drivers/gpio/gpio-ath79.c                               |    3=20
 drivers/gpio/gpio-iop.c                                 |    4=20
 drivers/gpio/gpio-stmpe.c                               |   20 ++--
 drivers/gpio/gpiolib.c                                  |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c       |   47 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                  |    4=20
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c        |    4=20
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  |   18 +++
 drivers/gpu/drm/bridge/tc358767.c                       |   73 ++++++++---=
-----
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                |    3=20
 drivers/gpu/drm/vc4/vc4_irq.c                           |    3=20
 drivers/gpu/drm/vc4/vc4_v3d.c                           |    3=20
 drivers/hid/wacom_sys.c                                 |   24 ++---
 drivers/hwmon/pmbus/pmbus_core.c                        |   21 ++--
 drivers/infiniband/hw/mlx5/main.c                       |   14 +++
 drivers/infiniband/hw/mlx5/mlx5_ib.h                    |    3=20
 drivers/infiniband/hw/mlx5/qp.c                         |   59 +++++-------
 drivers/md/bcache/btree.c                               |    5 -
 drivers/media/usb/usbtv/usbtv-core.c                    |    1=20
 drivers/mtd/nand/denali_pci.c                           |    4=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c       |    4=20
 drivers/net/ethernet/intel/igb/igb_main.c               |    2=20
 drivers/net/ethernet/xilinx/Kconfig                     |    1=20
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c          |    2=20
 drivers/net/xen-netfront.c                              |   18 +++
 drivers/power/reset/zx-reboot.c                         |    4=20
 drivers/scsi/aacraid/commsup.c                          |    2=20
 drivers/scsi/ufs/ufshcd.c                               |    7 +
 drivers/spi/spi-imx.c                                   |   15 ++-
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c     |    7 -
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h     |    2=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c  |    6 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c          |   14 ---
 drivers/tty/serial/imx.c                                |   14 +--
 drivers/tty/tty_io.c                                    |    8 +
 drivers/tty/tty_ldisc.c                                 |    4=20
 drivers/usb/class/cdc-acm.c                             |    5 -
 drivers/usb/gadget/composite.c                          |    7 +
 drivers/usb/gadget/function/f_fs.c                      |    3=20
 drivers/usb/gadget/udc/core.c                           |    2=20
 drivers/usb/serial/Kconfig                              |    1=20
 drivers/usb/serial/io_edgeport.c                        |    1=20
 drivers/usb/serial/option.c                             |    5 +
 drivers/usb/serial/pl2303.c                             |    1=20
 drivers/usb/serial/pl2303.h                             |    1=20
 drivers/usb/serial/usb-serial-simple.c                  |    7 +
 drivers/usb/storage/uas.c                               |    7 -
 drivers/usb/usbip/vhci_hcd.c                            |    2=20
 fs/btrfs/free-space-cache.c                             |    3=20
 fs/nfs_common/grace.c                                   |   10 +-
 fs/nfsd/nfs4state.c                                     |   34 ++++---
 fs/quota/dquot.c                                        |    3=20
 fs/reiserfs/super.c                                     |    1=20
 fs/xfs/xfs_aops.c                                       |    6 -
 fs/xfs/xfs_buf.c                                        |   15 ++-
 fs/xfs/xfs_dquot.c                                      |   14 ++-
 fs/xfs/xfs_dquot_item.c                                 |   40 ++++++++
 fs/xfs/xfs_inode.c                                      |   21 ++++
 include/linux/mlx5/mlx5_ifc.h                           |   10 +-
 include/linux/tty.h                                     |    2=20
 mm/kmemleak.c                                           |    2=20
 net/mac80211/mesh_hwmp.c                                |   15 +--
 net/openvswitch/flow_netlink.c                          |   16 +--
 net/sunrpc/xprtsock.c                                   |    1=20
 tools/gpio/gpio-event-mon.c                             |    1=20
 tools/power/cpupower/bench/system.c                     |    2=20
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c |    9 +
 tools/usb/usbip/src/usbip_bind.c                        |    9 +
 tools/usb/usbip/src/usbip_list.c                        |    9 +
 84 files changed, 542 insertions(+), 238 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: EKR: ensure devres groups at higher indexes are released

Abhishek Goel (2):
      cpupowerutils: bench - Fix cpu online check
      cpupower : Fix cpupower working when cpu0 is offline

Andrew Elble (1):
      nfsd: check for use of the closed special stateid

Andrey Gusakov (6):
      drm/bridge: tc358767: do no fail on hi-res displays
      drm/bridge: tc358767: filter out too high modes
      drm/bridge: tc358767: fix DP0_MISC register set
      drm/bridge: tc358767: fix timing calculations
      drm/bridge: tc358767: fix AUXDATAn registers access
      drm/bridge: tc358767: fix 1-lane behavior

Ard Biesheuvel (1):
      crypto: sha3-generic - fixes for alignment and big endian operation

Benjamin Herrenschmidt (1):
      usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Carlos Maiolino (1):
      xfs: Properly retry failed dquot items in case of error during buffer=
 writeback

Christian K=F6nig (1):
      drm/amdgpu: don't try to move pinned BOs

Christophe JAILLET (2):
      bnxt_en: Fix an error handling path in 'bnxt_get_module_eeprom()'
      drm/omap: Fix error handling path in 'omap_dmm_probe()'

Chun-Yeow Yeoh (1):
      mac80211: fix the update of path metric for RANN frame

Colin Ian King (1):
      usb: gadget: don't dereference g until after it has been null checked

Darrick J. Wong (2):
      xfs: always free inline data before resetting inode fork during ifree
      xfs: ubsan fixes

Dmitry Eremin (1):
      staging: lustre: separate a connection destroy from free struct kib_c=
onn

Eduardo Otubo (1):
      xen-netfront: remove warning when unloading module

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix the TX queue hang timeout for MONITOR vif type

Fabio Estevam (1):
      serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Felix Kuehling (2):
      drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode
      drm/amdkfd: Fix SDMA oversubsription handling

Florian Fainelli (1):
      ARM: dts: NSP: Fix PPI interrupt types

Gaurav Kohli (1):
      tty: fix data race between tty_init_dev and flush of buf

Geert Uytterhoeven (1):
      net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Greg Kroah-Hartman (2):
      USB: serial: pl2303: new device id for Chilitag
      Linux 4.9.80

Guilherme G. Piccoli (1):
      scsi: aacraid: Prevent crash in case of free interrupt during scsi EH=
 path

Gustavo A. R. Silva (1):
      scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_c=
onfig_vreg

Hans de Goede (2):
      ACPI / bus: Leave modalias empty for devices which are not present
      USB: cdc-acm: Do not log urb submission errors on disconnect

Hauke Mehrtens (1):
      crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound

Icenowy Zheng (1):
      media: usbtv: add a new usbid

James Hogan (1):
      cpufreq: Add Loongson machine dependencies

Jeff Layton (1):
      reiserfs: remove unneeded i_version bump

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

Josef Bacik (1):
      btrfs: fix deadlock when writing out space cache

Larry Finger (1):
      staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Linus Torvalds (1):
      loop: fix concurrent lo_open/lo_release

Linus Walleij (1):
      gpio: Fix kernel stack leak to userspace

Liran Alon (2):
      KVM: x86: emulator: Return to user-mode on L1 CPL=3D0 emulation failu=
re
      KVM: x86: Don't re-execute instruction when not passing CR2 value

Lyude Paul (1):
      igb: Free IRQs when device is hotplugged

Max Gurtovoy (2):
      net/mlx5: Define interface bits for fencing UMR wqe
      RDMA/mlx5: set UMR wqe fence according to HCA cap

Michael Lyle (1):
      bcache: check return value of register_shrinker

Michal Hocko (1):
      xfs: fortify xfs_alloc_buftarg error handling

Nikita Leshenko (3):
      KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race
      KVM: x86: ioapic: Clear Remote IRR when entry is switched to edge-tri=
ggered
      KVM: x86: ioapic: Preserve read-only values in the redirection table

OKAMOTO Yoshiaki (1):
      usb: option: Add support for FS040U modem

Oliver Neukum (2):
      CDC-ACM: apply quirk for card reader
      usb: uas: unconditionally bring back host after reset

Patrice Chotard (1):
      gpio: stmpe: i2c transfer are forbiden in atomic context

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values

Shuah Khan (3):
      usbip: prevent bind loops on devices attached to vhci_hcd
      usbip: list: don't list devices attached to vhci_hcd
      usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled

Stefan Schake (2):
      drm/vc4: Account for interrupts in flight
      drm/vc4: Move IRQ enable to PM path

Stephan Mueller (2):
      crypto: aesni - handle zero length dst buffer
      crypto: af_alg - whitelist mask and type

Tetsuo Handa (1):
      quota: Check for register_shrinker() failure.

Thomas Meyer (1):
      auxdisplay: img-ascii-lcd: Only build on archs that have IOMEM

Trond Myklebust (3):
      nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>=
0)
      nfsd: Ensure we check stateid validity in the seqid operation checks
      SUNRPC: Allow connect to return EHOSTUNREACH

Vasily Averin (2):
      grace: replace BUG_ON by WARN_ONCE in exit_net hook
      lockd: fix "list_add double add" caused by legacy signal interface

Wanpeng Li (3):
      KVM: X86: Fix operand/address-size during instruction decoding
      KVM: X86: Fix softlockup when get the current kvmclock
      KVM: VMX: Fix rflags cache during vCPU reset

Yisheng Xie (1):
      kmemleak: add scheduling point to kmemleak_scan()

shaoyunl (1):
      drm/amdkfd: Fix SDMA ring buffer size calculation

zhangliping (1):
      openvswitch: fix the incorrect flow action alloc size


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlp244QACgkQONu9yGCS
aT5zog/+L0YNj1Q4FLACBSkO5LPWyls3isuht0BjUcPzhFI167LsKlFDhsILYWXm
ionNLno4n6A1GduNnYYLrXSDwfuGTWPgJ+7YbMw1MK5cuz8CEuGjcjU3BN8xAmr0
TyM0NM8aajtYiwFZt9E65WfBSvai3XFxLIVZpA7YFlYe0foVNSR5O8ZmcAn0XSMp
CXOLP+DIo3BPOYOqdMyaVxcHrN7UD83W8OIkXVRc+iA8VIHi5xZ9grXxfTeMqGht
EI2uyhec0F/0eg0LJ+ULFLab0e3jGXC6t6x7lDqtDc2n/+0qckwX5O11tnADm4kd
o+9EDVF8tmL5IMyKz90JKIdpaayaomyvRFfa/QtwZvIKtstwKkTeDNcOc/OQiZf9
isIplxYGx7DJeBKmf1fhnZdmiaaz0bMsSRzG8FJ++cRLLNk6KlIZ/8YdQsZWP8ph
2aKVdVbDMWvHv+ZFJC3A8yalQ+7LM9n27dXfM3yAn6a9chNrp7zIRLm7q6c22yzm
Y2Hg+RiTEXBRyHrb/h7womU6LLvSikOzzJR6e9OaeKGg8UL8lrbxWbsXL+SUu6qL
4Gn1Xhv+vieiPX77C2p3cZGahJQuSTL+/vyysvrxLVuMlLpBOdjtwjmn72lStfmy
J/EMjgzdC/lj57U3s2zp9s0J3xBiA2jH4zLt/ngHoDblwALWXWc=
=5vsk
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
