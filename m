Date: Sun, 4 Feb 2018 11:41:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.115
Message-ID: <20180204104151.GA7318@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.115 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                               |    2=20
 arch/arm64/Kconfig                                     |    1=20
 arch/s390/Kconfig                                      |    1=20
 arch/x86/Kconfig                                       |    1=20
 arch/x86/crypto/aesni-intel_glue.c                     |    2=20
 arch/x86/include/asm/kvm_host.h                        |    3=20
 arch/x86/kernel/cpu/perf_event_intel_bts.c             |   44 ++++++++--
 arch/x86/kernel/tboot.c                                |   10 ++
 arch/x86/kvm/emulate.c                                 |    7 +
 arch/x86/kvm/ioapic.c                                  |   20 ++++
 arch/x86/kvm/vmx.c                                     |    4=20
 arch/x86/kvm/x86.c                                     |    2=20
 arch/x86/net/bpf_jit_comp.c                            |   13 +--
 crypto/af_alg.c                                        |   10 +-
 drivers/acpi/device_sysfs.c                            |    4=20
 drivers/block/loop.c                                   |   10 +-
 drivers/cpufreq/Kconfig                                |    2=20
 drivers/gpio/gpio-ath79.c                              |    3=20
 drivers/gpio/gpio-iop.c                                |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c      |   47 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c       |    4=20
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   18 ++++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c               |    3=20
 drivers/hwmon/pmbus/pmbus_core.c                       |   21 ++---
 drivers/md/bcache/btree.c                              |    5 -
 drivers/media/usb/usbtv/usbtv-core.c                   |    1=20
 drivers/mtd/nand/denali_pci.c                          |    4=20
 drivers/net/ethernet/intel/igb/igb_main.c              |    2=20
 drivers/net/ethernet/xilinx/Kconfig                    |    1=20
 drivers/net/xen-netfront.c                             |   18 ++++
 drivers/power/reset/zx-reboot.c                        |    4=20
 drivers/scsi/aacraid/commsup.c                         |    2=20
 drivers/scsi/ufs/ufshcd.c                              |    7 +
 drivers/spi/spi-imx.c                                  |   15 +++
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c         |   14 ---
 drivers/tty/serial/imx.c                               |   14 +--
 drivers/usb/class/cdc-acm.c                            |    5 -
 drivers/usb/gadget/composite.c                         |    7 +
 drivers/usb/gadget/function/f_fs.c                     |    3=20
 drivers/usb/serial/Kconfig                             |    1=20
 drivers/usb/serial/io_edgeport.c                       |    1=20
 drivers/usb/serial/option.c                            |    5 +
 drivers/usb/serial/pl2303.c                            |    1=20
 drivers/usb/serial/pl2303.h                            |    1=20
 drivers/usb/serial/usb-serial-simple.c                 |    7 +
 drivers/usb/storage/uas.c                              |    7 -
 fs/btrfs/free-space-cache.c                            |    3=20
 fs/nfs_common/grace.c                                  |   10 +-
 fs/nfsd/nfs4state.c                                    |   34 ++++----
 fs/quota/dquot.c                                       |    3=20
 fs/xfs/xfs_aops.c                                      |    6 -
 include/linux/bpf.h                                    |   16 ++-
 init/Kconfig                                           |    7 +
 kernel/bpf/core.c                                      |   30 ++++++-
 kernel/bpf/verifier.c                                  |   70 ++++++++++++=
+++++
 lib/test_bpf.c                                         |   13 +--
 mm/kmemleak.c                                          |    2=20
 net/Kconfig                                            |    3=20
 net/core/filter.c                                      |    8 +
 net/core/sysctl_net_core.c                             |    6 +
 net/mac80211/mesh_hwmp.c                               |   15 ++-
 net/openvswitch/flow_netlink.c                         |   16 +--
 net/socket.c                                           |    9 ++
 net/sunrpc/xprtsock.c                                  |    1=20
 security/selinux/hooks.c                               |    2=20
 sound/core/seq/seq_clientmgr.c                         |   10 +-
 sound/core/seq/seq_clientmgr.h                         |    1=20
 tools/usb/usbip/src/usbip_bind.c                       |    9 ++
 tools/usb/usbip/src/usbip_list.c                       |    9 ++
 69 files changed, 503 insertions(+), 141 deletions(-)

Alexei Starovoitov (4):
      bpf: fix branch pruning logic
      bpf: fix bpf_tail_call() x64 JIT
      bpf: introduce BPF_JIT_ALWAYS_ON config
      bpf: fix 32-bit divide by zero

Andrew Elble (1):
      nfsd: check for use of the closed special stateid

Christophe JAILLET (1):
      drm/omap: Fix error handling path in 'omap_dmm_probe()'

Chun-Yeow Yeoh (1):
      mac80211: fix the update of path metric for RANN frame

Colin Ian King (1):
      usb: gadget: don't dereference g until after it has been null checked

Daniel Borkmann (3):
      bpf: arsh is not supported in 32 bit alu thus reject it
      bpf: avoid false sharing of map refcount with max_entries
      bpf: reject stores into ctx via st and xadd

Darrick J. Wong (1):
      xfs: ubsan fixes

Dave Hansen (1):
      x86/pti: Make unpoison of pgd for trusted boot work for real

Eduardo Otubo (1):
      xen-netfront: remove warning when unloading module

Eric Dumazet (2):
      x86: bpf_jit: small optimization in emit_bpf_tail_call()
      bpf: fix divides by zero

Fabio Estevam (1):
      serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Felix Kuehling (2):
      drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode
      drm/amdkfd: Fix SDMA oversubsription handling

Geert Uytterhoeven (1):
      net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Greg Kroah-Hartman (2):
      USB: serial: pl2303: new device id for Chilitag
      Linux 4.4.115

Guilherme G. Piccoli (1):
      scsi: aacraid: Prevent crash in case of free interrupt during scsi EH=
 path

Gustavo A. R. Silva (1):
      scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_c=
onfig_vreg

Hans de Goede (2):
      ACPI / bus: Leave modalias empty for devices which are not present
      USB: cdc-acm: Do not log urb submission errors on disconnect

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound

Hugh Dickins (1):
      kaiser: fix intel_bts perf crashes

Icenowy Zheng (1):
      media: usbtv: add a new usbid

James Hogan (1):
      cpufreq: Add Loongson machine dependencies

Jesse Chan (4):
      power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
      mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra driver

Josef Bacik (1):
      btrfs: fix deadlock when writing out space cache

Larry Finger (1):
      staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Linus Torvalds (1):
      loop: fix concurrent lo_open/lo_release

Liran Alon (2):
      KVM: x86: emulator: Return to user-mode on L1 CPL=3D0 emulation failu=
re
      KVM: x86: Don't re-execute instruction when not passing CR2 value

Lyude Paul (1):
      igb: Free IRQs when device is hotplugged

Mark Salyzyn (1):
      selinux: general protection fault in sock_has_perm

Michael Lyle (1):
      bcache: check return value of register_shrinker

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

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values

Shuah Khan (2):
      usbip: prevent bind loops on devices attached to vhci_hcd
      usbip: list: don't list devices attached to vhci_hcd

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled

Stephan Mueller (2):
      crypto: aesni - handle zero length dst buffer
      crypto: af_alg - whitelist mask and type

Takashi Iwai (1):
      ALSA: seq: Make ioctls race-free

Tetsuo Handa (1):
      quota: Check for register_shrinker() failure.

Trond Myklebust (3):
      nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>=
0)
      nfsd: Ensure we check stateid validity in the seqid operation checks
      SUNRPC: Allow connect to return EHOSTUNREACH

Vasily Averin (2):
      grace: replace BUG_ON by WARN_ONCE in exit_net hook
      lockd: fix "list_add double add" caused by legacy signal interface

Wanpeng Li (2):
      KVM: X86: Fix operand/address-size during instruction decoding
      KVM: VMX: Fix rflags cache during vCPU reset

Yisheng Xie (1):
      kmemleak: add scheduling point to kmemleak_scan()

shaoyunl (1):
      drm/amdkfd: Fix SDMA ring buffer size calculation

zhangliping (1):
      openvswitch: fix the incorrect flow action alloc size


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlp242wACgkQONu9yGCS
aT62iQ/+KcjWwPLrSPuukt9a2VxdSXdvC0ZYOXz2b6p696pnnnDwoJbvdr0qJ3GJ
mCJdw+7pCflfWe0YsCopJpUdYuZi9yZYjbUWAeJJ1CkS7c2o/xMnczHgqv1tzME0
fC2oUvB5pFOk689I3O/LXxeeH+woW5RcQaIHH5AQhkAPNU23sq8M6EMLt9XL0A16
nNXwr/NW86mC9w99UFXISXiUKte2gKszah1/EHnYIA8TBeH+6oe5SHqfRDaK3xAU
ooA0CcwKvCQQYt4dKqC+vGZmh4jhGdM0bMgmz0zvLhw2Dmv04kh7iIPM97ChFL4S
IUKLATLjXElhqtgd67s73Vm0NvounYyHDY6+jlhgJOE7qEjVElOjLKgcCog8sSGr
sqpiaA+leHfDOVwRjtf3oOhnsxyLcgddWnibs3sjMh3O9QRNA87XziSaMJAEVtTv
A5cI0Q1wMhxNuIWg6U7p70NleZhu5oR8b/dM/e+nzZgDA/J9qUyLh2aTqhZnuNu1
FvANjn1c6Q75Z2OHZEqcCo+f6uvM6mEA8nsm4ObcQjX35fQML1ViWrf8apsWGj2W
FhFJNzrPJTEDzI4r59AzRYBb3nJsDSgwWGa84PVKuWvWeBpx+vW12wgokDvEA0aa
wyhtD9fG2y7mnOskHNWgVDWTnNz06SOXV7kUpkuWWcs1UMKJsGU=
=zTTn
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
