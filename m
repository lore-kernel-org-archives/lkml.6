Date: Sat, 17 Feb 2018 14:24:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.116
Message-ID: <20180217132458.GA16475@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.116 kernel.

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

 Makefile                                            |    2=20
 arch/alpha/kernel/pci_impl.h                        |    3=20
 arch/alpha/kernel/process.c                         |    3=20
 arch/arm/kvm/handle_exit.c                          |   13=20
 arch/mn10300/mm/misalignment.c                      |    2=20
 arch/openrisc/kernel/traps.c                        |   10=20
 arch/powerpc/Kconfig                                |    3=20
 arch/powerpc/include/asm/exception-64e.h            |    6=20
 arch/powerpc/include/asm/exception-64s.h            |   55 +
 arch/powerpc/include/asm/feature-fixups.h           |   15=20
 arch/powerpc/include/asm/hvcall.h                   |   18=20
 arch/powerpc/include/asm/paca.h                     |   10=20
 arch/powerpc/include/asm/plpar_wrappers.h           |   14=20
 arch/powerpc/include/asm/ppc_asm.h                  |   12=20
 arch/powerpc/include/asm/setup.h                    |   13=20
 arch/powerpc/kernel/asm-offsets.c                   |    4=20
 arch/powerpc/kernel/entry_64.S                      |   44=20
 arch/powerpc/kernel/exceptions-64s.S                |  126 ++
 arch/powerpc/kernel/misc_64.S                       |   32=20
 arch/powerpc/kernel/module_64.c                     |   12=20
 arch/powerpc/kernel/process.c                       |    5=20
 arch/powerpc/kernel/setup_64.c                      |  139 ++
 arch/powerpc/kernel/vmlinux.lds.S                   |    9=20
 arch/powerpc/kvm/book3s_hv_rmhandlers.S             |    7=20
 arch/powerpc/kvm/book3s_rmhandlers.S                |    7=20
 arch/powerpc/kvm/book3s_segment.S                   |    4=20
 arch/powerpc/lib/feature-fixups.c                   |   42=20
 arch/powerpc/platforms/powernv/setup.c              |   50=20
 arch/powerpc/platforms/pseries/setup.c              |   37=20
 arch/sh/kernel/traps_32.c                           |    3=20
 arch/x86/crypto/poly1305_glue.c                     |    1=20
 arch/x86/include/asm/asm.h                          |    4=20
 arch/x86/include/asm/vsyscall.h                     |    2=20
 arch/x86/kernel/cpu/microcode/core.c                |   47=20
 arch/x86/kvm/vmx.c                                  |    5=20
 arch/x86/mm/kaiser.c                                |    2=20
 arch/xtensa/include/asm/futex.h                     |   23=20
 crypto/ahash.c                                      |   11=20
 crypto/cryptd.c                                     |    3=20
 crypto/poly1305_generic.c                           |   17=20
 crypto/tcrypt.c                                     |    6=20
 drivers/acpi/sbshc.c                                |    4=20
 drivers/ata/ahci.c                                  |   37=20
 drivers/block/pktcdvd.c                             |    4=20
 drivers/bluetooth/btsdio.c                          |    9=20
 drivers/bluetooth/btusb.c                           |   19=20
 drivers/crypto/caam/ctrl.c                          |    8=20
 drivers/dma/dmatest.c                               |    2=20
 drivers/edac/octeon_edac-lmc.c                      |    1=20
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c              |   56 -
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h              |    8=20
 drivers/hid/hid-core.c                              |   12=20
 drivers/media/dvb-frontends/ts2020.c                |    4=20
 drivers/media/platform/soc_camera/soc_scale_crop.c  |    4=20
 drivers/media/usb/dvb-usb-v2/lmedm04.c              |   39=20
 drivers/media/usb/dvb-usb/cxusb.c                   |    2=20
 drivers/media/usb/dvb-usb/dib0700_devices.c         |    1=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c       | 1023 ++++++++++++---=
-----
 drivers/media/v4l2-core/v4l2-ioctl.c                |    5=20
 drivers/media/v4l2-core/videobuf2-v4l2.c            |    6=20
 drivers/mtd/nand/brcmnand/brcmnand.c                |   13=20
 drivers/mtd/nand/nand_base.c                        |    5=20
 drivers/mtd/nand/sunxi_nand.c                       |    8=20
 drivers/mtd/ubi/block.c                             |   42=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |   18=20
 drivers/net/ethernet/realtek/r8169.c                |    4=20
 drivers/net/usb/cdc_ncm.c                           |    6=20
 drivers/nvme/host/pci.c                             |   13=20
 drivers/usb/gadget/function/uvc_configfs.c          |   16=20
 drivers/usb/usbip/vhci_hcd.c                        |    2=20
 drivers/usb/usbip/vhci_sysfs.c                      |    7=20
 drivers/vhost/net.c                                 |    1=20
 drivers/watchdog/imx2_wdt.c                         |   20=20
 fs/btrfs/inode.c                                    |   10=20
 fs/cifs/cifsencrypt.c                               |    3=20
 fs/cifs/connect.c                                   |    6=20
 fs/cifs/file.c                                      |   26=20
 fs/cifs/misc.c                                      |   14=20
 fs/cifs/smb2pdu.c                                   |    3=20
 fs/ext4/inode.c                                     |    1=20
 fs/ext4/namei.c                                     |    1=20
 fs/ext4/symlink.c                                   |   10=20
 fs/f2fs/inode.c                                     |    1=20
 fs/f2fs/namei.c                                     |    5=20
 fs/inode.c                                          |    6=20
 fs/kernfs/file.c                                    |    2=20
 fs/nfs/direct.c                                     |    4=20
 fs/nfs/nfs4idmap.c                                  |    6=20
 fs/nfs/pnfs.c                                       |    4=20
 fs/nfs/write.c                                      |    2=20
 fs/nsfs.c                                           |    1=20
 fs/overlayfs/readdir.c                              |    6=20
 include/crypto/internal/hash.h                      |    2=20
 include/crypto/poly1305.h                           |    2=20
 include/linux/fs.h                                  |    1=20
 include/linux/mtd/map.h                             |  130 +-
 include/net/netfilter/nf_queue.h                    |    4=20
 include/net/netns/netfilter.h                       |    2=20
 kernel/async.c                                      |   20=20
 kernel/sched/core.c                                 |   13=20
 kernel/sched/rt.c                                   |   24=20
 kernel/sched/sched.h                                |    2=20
 kernel/time/posix-timers.c                          |   34=20
 kernel/trace/ftrace.c                               |    1=20
 net/dccp/proto.c                                    |    5=20
 net/ipv4/igmp.c                                     |    4=20
 net/ipv4/tcp.c                                      |    6=20
 net/ipv6/ip6mr.c                                    |    1=20
 net/netfilter/nf_queue.c                            |   17=20
 net/netfilter/nfnetlink_queue.c                     |   18=20
 scripts/mod/modpost.c                               |    3=20
 security/keys/encrypted-keys/encrypted.c            |   31=20
 sound/soc/codecs/pcm512x-spi.c                      |    4=20
 sound/soc/generic/simple-card.c                     |    8=20
 sound/soc/sh/rcar/rsnd.h                            |    2=20
 sound/soc/sh/rcar/ssi.c                             |    5=20
 116 files changed, 1820 insertions(+), 850 deletions(-)

Al Viro (1):
      don't put symlink bodies in pagecache into highmem

Alan Modra (1):
      powerpc: Simplify module TOC handling

Amir Goldstein (1):
      ovl: fix failure to fsync lower dir

Arnd Bergmann (1):
      mtd: cfi: convert inline functions to macros

Aurelien Aptel (1):
      CIFS: zero sensitive data when freeing

Bart Van Assche (1):
      pktcdvd: Fix pkt_setup_dev() error path

Benjamin Herrenschmidt (1):
      powerpc: Fix VSX enabling/flushing to also test MSR_FP and MSR_VEC

Borislav Petkov (2):
      x86/microcode/AMD: Do not load when running on a hypervisor
      x86/microcode: Do the family check first

Bradley Bolen (1):
      ubi: block: Fix locking for idr_alloc/idr_remove

Chunhao Lin (1):
      r8169: fix RTL8168EP take too long to complete driver initialization.

Cong Wang (1):
      nsfs: mark dentry with DCACHE_RCUACCESS

Daniel Mentz (2):
      media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
      media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Daniel N Pettersson (1):
      cifs: Fix autonegotiate security settings mismatch

Eric Biggers (6):
      KEYS: encrypted: fix buffer overread in valid_master_desc()
      x86/kaiser: fix build error with KASAN && !FUNCTION_GRAPH_TRACER
      NFS: reject request for id_legacy key without auxdata
      crypto: hash - introduce crypto_hash_alg_has_setkey()
      crypto: cryptd - pass through absence of ->setkey()
      crypto: poly1305 - remove ->setkey() method

Eric Dumazet (1):
      net: igmp: add a missing rcu locking section

Eric W. Biederman (4):
      netfilter: nf_queue: Make the queue_handler pernet
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      signal/sh: Ensure si_signo is initialized in do_divide_error
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user=
 copy

Greg Kroah-Hartman (2):
      ACPI: sbshc: remove raw pointer from printk() message
      Linux 4.4.116

Hans Verkuil (11):
      media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
      media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
      media: v4l2-compat-ioctl32.c: fix the indentation
      media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4=
l2_format32
      media: v4l2-compat-ioctl32.c: avoid sizeof(type)
      media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
      media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
      media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
      media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
      media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
      media: v4l2-compat-ioctl32.c: don't copy back the result for certain =
errors

Hans de Goede (5):
      ahci: Annotate PCI ids for mobile Intel chipsets as such
      ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake A=
HCI
      HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working
      Bluetooth: btsdio: Do not bind to non-removable BCM43341
      Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritt=
en" version

Horia Geant=C4=83 (1):
      crypto: caam - fix endless loop when DECO acquire fails

Hugh Dickins (1):
      kaiser: fix compile error without vsyscall

Ivan Vecera (1):
      kernfs: fix regression in kernfs_fop_write caused by wrong type

J. Bruce Fields (1):
      NFS: commit direct writes even if they fail partially

James Hogan (1):
      EDAC, octeon: Fix an uninitialized variable warning

Jason Wang (1):
      vhost_net: stop device during reset owner

Jesse Chan (2):
      ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUT=
HOR/LICENSE

Josh Poimboeuf (1):
      x86/asm: Fix inline asm call constraints for GCC 4.4

Julian Scheel (1):
      ASoC: simple-card: Fix misleading error message

Junxiao Bi (1):
      qlcnic: fix deadlock bug

Kai-Heng Feng (1):
      Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Kamal Dasu (1):
      mtd: nand: brcmnand: Disable prefetch by default

Keith Busch (1):
      nvme: Fix managing degraded controllers

Kuninori Morimoto (2):
      ASoC: rsnd: don't call free_irq() on Parent SSI
      ASoC: rsnd: avoid duplicate free_irq()

Laurent Pinchart (2):
      drm: rcar-du: Use the VBK interrupt for vblank events
      drm: rcar-du: Fix race condition when disabling planes at CRTC stop

Li RongQing (1):
      tcp: release sk_frag.page in tcp_disconnect

Liran Alon (1):
      KVM: nVMX: Fix races when sending nested PI while dest enters/leaves =
L2

Malcolm Priestley (2):
      media: dvb-usb-v2: lmedm04: Improve logic checking of warm start
      media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner

Marc Zyngier (1):
      arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls

Martin Kaiser (1):
      watchdog: imx2_wdt: restore previous timeout after suspend+resume

Matthew Wilcox (1):
      cifs: Fix missing put_xid in cifs_file_strict_mmap

Matthias Hintzmann (1):
      net: cdc_ncm: initialize drvflags before usage

Mauro Carvalho Chehab (2):
      media: ts2020: avoid integer overflows on 32 bit machines
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Max Filippov (1):
      xtensa: fix futex_atomic_cmpxchg_inatomic

Michael Ellerman (4):
      powerpc/64s: Add support for RFI flush of L1-D cache
      powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti
      powerpc/64s: Wire up cpu_show_meltdown()
      powerpc/64s: Allow control of RFI flush via debugfs

Michael Neuling (2):
      powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
      powerpc/pseries: Query hypervisor for RFI flush settings

Michal Suchanek (1):
      powerpc/pseries: include linux/types.h in asm/hvcall.h

Mika Westerberg (1):
      ahci: Add Intel Cannon Lake PCH-H PCI ID

Mikulas Patocka (2):
      alpha: fix crash if pthread_create races with signal delivery
      alpha: fix reboot on Avanti platform

Miquel Raynal (2):
      mtd: nand: Fix nand_do_read_oob() return value
      mtd: nand: sunxi: Fix ECC strength choice

Mohamed Ghannam (1):
      dccp: CVE-2017-8824: use-after-free in DCCP code

Naveen N. Rao (1):
      powerpc/bpf/jit: Disable classic BPF JIT on ppc64le

Nicholas Piggin (5):
      powerpc/64: Add macros for annotating the destination of rfid/hrfid
      powerpc/64s: Simple RFI macro conversions
      powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL
      powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL
      powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL

Nikolay Aleksandrov (1):
      ip6mr: fix stale iterator

Nikolay Borisov (1):
      btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker

Oliver O'Halloran (2):
      powerpc/64: Fix flush_(d|i)cache_range() called from modules
      powerpc/powernv: Check device-tree for RFI flush settings

Petr Cvek (1):
      usb: gadget: uvc: Missing files for configfs interface

Rasmus Villemoes (1):
      kernel/async.c: revert "async: simplify lowest_in_progress()"

Ricardo Ribalda Delgado (1):
      vb2: V4L2_BUF_FLAG_DONE is set after DQBUF

Robert Baronescu (1):
      crypto: tcrypt - fix S/G table for test_aead_speed()

Scott Mayhew (1):
      nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Shuah Khan (2):
      usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
      usbip: fix 3eee23c3ec14 tcp_socket address still in the status file

Steven Rostedt (VMware) (3):
      sched/rt: Use container_of() to get root domain in rto_push_irq_work_=
func()
      sched/rt: Up the root domain ref count when passing it around via IPIs
      ftrace: Remove incorrect setting of glob search field

Thomas Gleixner (1):
      posix-timer: Properly check sigevent->sigev_notify

Trond Myklebust (1):
      NFS: Add a cond_resched() to nfs_commit_release_pages()

Yang Shunyong (1):
      dmaengine: dmatest: fix container_of member in dmatest_callback


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqILSkACgkQONu9yGCS
aT5PIRAAte+sHZORLHU2BXQq73ubSW6Eku8fnKWgKolxccCf/zN5vSPClX6XSXXj
P9U0RN6A/w4QHQ1OTLARFScSd0jaHHNsMwGp0+nd9GHrANxjVESwPK3Pkr7TX60V
Ic8L/pYoS/j2t0OoSwYnzOJNvvPR3bpAOu5q0lbwGbJs7ouWXf+kMbk10YBQk7wK
oIeNri8MVHQq6lbEJ0/nsMdIvbkbSEGw2zi57mEI3dgY17QLljovIbzIz5psrd2Q
kPMSwhO2RW9ZLL74Sirzxx63/iqYd9BkWwTqizrS0XkG4lRVrWl9RZFgDRAuN+bn
XgXgz/o6S67FK13DMF84PGjf1etI3HenowsTEl2N62g519WYYgigLTTAEEQ21VnB
Ddol/oU95WOG3RsoB1ogY2P6//JWQAHgRiozHBwgbn4i3r70MfQoNSGGNGKxuJuT
6rmLTRpJL1eiK4oBM4i5ryIU1+KlE+sC2KP9K/eZsWYevIQMYcyNn0+Bp+2KSieb
4pcDFWJMicrs7CHx3k6GoKWhD8oVNr7DlCbldl0p+/MaQpIO7vkLyQL6O7njQoHI
AoUTNAtUQ2VswjK5f9Zwvq/vcbr4xXxFZ+E5LuveFXPPhPVB3Pebe1C+iXuiMZVg
8G4prCaBh/+1r65ADvd1rSZs5EQa90ytI8igtTt9c7QIth+CzIo=
=By6Q
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
