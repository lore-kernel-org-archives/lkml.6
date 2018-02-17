Date: Sat, 17 Feb 2018 14:25:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.82
Message-ID: <20180217132521.GA17728@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.82 kernel.

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

 Makefile                                            |    2=20
 arch/alpha/kernel/pci_impl.h                        |    3=20
 arch/alpha/kernel/process.c                         |    3=20
 arch/alpha/kernel/traps.c                           |   13=20
 arch/arm/kvm/arm.c                                  |    1=20
 arch/arm/kvm/handle_exit.c                          |   13=20
 arch/mn10300/mm/misalignment.c                      |    2=20
 arch/openrisc/kernel/traps.c                        |   10=20
 arch/powerpc/include/asm/hvcall.h                   |    1=20
 arch/sh/kernel/traps_32.c                           |    3=20
 arch/x86/crypto/poly1305_glue.c                     |    1=20
 arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c |   10=20
 arch/x86/include/asm/vsyscall.h                     |    2=20
 arch/x86/kvm/vmx.c                                  |    5=20
 arch/xtensa/include/asm/futex.h                     |   23=20
 crypto/ahash.c                                      |   11=20
 crypto/cryptd.c                                     |    3=20
 crypto/mcryptd.c                                    |    3=20
 crypto/poly1305_generic.c                           |   17=20
 drivers/acpi/nfit/core.c                            |    3=20
 drivers/acpi/sbshc.c                                |    4=20
 drivers/ata/ahci.c                                  |   37=20
 drivers/block/pktcdvd.c                             |    4=20
 drivers/bluetooth/btsdio.c                          |    9=20
 drivers/bluetooth/btusb.c                           |   19=20
 drivers/clocksource/timer-stm32.c                   |    8=20
 drivers/crypto/caam/ctrl.c                          |    8=20
 drivers/dma/dmatest.c                               |    2=20
 drivers/edac/octeon_edac-lmc.c                      |    1=20
 drivers/gpu/drm/i915/intel_dp.c                     |    6=20
 drivers/hid/hid-core.c                              |   12=20
 drivers/media/dvb-frontends/ascot2e.c               |    4=20
 drivers/media/dvb-frontends/cxd2841er.c             |    4=20
 drivers/media/dvb-frontends/helene.c                |    4=20
 drivers/media/dvb-frontends/horus3a.c               |    4=20
 drivers/media/dvb-frontends/itd1000.c               |    5=20
 drivers/media/dvb-frontends/mt312.c                 |    5=20
 drivers/media/dvb-frontends/stb0899_drv.c           |    3=20
 drivers/media/dvb-frontends/stb6100.c               |    6=20
 drivers/media/dvb-frontends/stv0367.c               |    4=20
 drivers/media/dvb-frontends/stv090x.c               |    4=20
 drivers/media/dvb-frontends/stv6110x.c              |    4=20
 drivers/media/dvb-frontends/ts2020.c                |    4=20
 drivers/media/dvb-frontends/zl10039.c               |    4=20
 drivers/media/usb/dvb-usb-v2/lmedm04.c              |   39=20
 drivers/media/usb/dvb-usb/cxusb.c                   |    2=20
 drivers/media/usb/dvb-usb/dib0700_devices.c         |    1=20
 drivers/media/usb/hdpvr/hdpvr-core.c                |   26=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c       | 1023 ++++++++++++---=
-----
 drivers/media/v4l2-core/v4l2-ioctl.c                |    5=20
 drivers/mtd/nand/brcmnand/brcmnand.c                |   13=20
 drivers/mtd/nand/nand_base.c                        |    5=20
 drivers/mtd/nand/sunxi_nand.c                       |    8=20
 drivers/mtd/ubi/block.c                             |   42=20
 drivers/mtd/ubi/wl.c                                |   77 +
 drivers/pinctrl/intel/pinctrl-intel.c               |   23=20
 drivers/usb/gadget/function/uvc_configfs.c          |   16=20
 drivers/watchdog/imx2_wdt.c                         |   20=20
 fs/btrfs/inode.c                                    |   11=20
 fs/cifs/cifsencrypt.c                               |    3=20
 fs/cifs/connect.c                                   |    6=20
 fs/cifs/file.c                                      |   26=20
 fs/cifs/misc.c                                      |   14=20
 fs/cifs/smb2pdu.c                                   |    3=20
 fs/kernfs/file.c                                    |    2=20
 fs/nfs/direct.c                                     |    4=20
 fs/nfs/io.c                                         |    2=20
 fs/nfs/nfs4idmap.c                                  |    6=20
 fs/nfs/pnfs.c                                       |    4=20
 fs/nfs/write.c                                      |    2=20
 fs/nsfs.c                                           |    1=20
 fs/overlayfs/readdir.c                              |    6=20
 fs/pipe.c                                           |   15=20
 fs/proc/kcore.c                                     |   18=20
 fs/ubifs/xattr.c                                    |   12=20
 include/crypto/internal/hash.h                      |    2=20
 include/crypto/poly1305.h                           |    2=20
 include/linux/mtd/map.h                             |  130 +-
 kernel/async.c                                      |   20=20
 kernel/relay.c                                      |    1=20
 kernel/sched/core.c                                 |   13=20
 kernel/sched/rt.c                                   |   24=20
 kernel/sched/sched.h                                |    2=20
 kernel/time/posix-timers.c                          |   34=20
 kernel/trace/ftrace.c                               |    1=20
 lib/ubsan.c                                         |   50=20
 lib/ubsan.h                                         |   14=20
 net/dccp/proto.c                                    |    5=20
 sound/soc/intel/skylake/skl-nhlt.c                  |    3=20
 sound/soc/rockchip/rockchip_i2s.c                   |    6=20
 90 files changed, 1244 insertions(+), 792 deletions(-)

Amir Goldstein (1):
      ovl: fix failure to fsync lower dir

Andrew Morton (1):
      lib/ubsan.c: s/missaligned/misaligned/

Andrey Ryabinin (1):
      lib/ubsan: add type mismatch handler for new GCC/Clang

Arnd Bergmann (2):
      mtd: cfi: convert inline functions to macros
      media: dvb-frontends: fix i2c access helpers for KASAN

Arvind Yadav (1):
      media: hdpvr: Fix an error handling path in hdpvr_probe()

Aurelien Aptel (1):
      CIFS: zero sensitive data when freeing

Bart Van Assche (1):
      pktcdvd: Fix pkt_setup_dev() error path

Bradley Bolen (1):
      ubi: block: Fix locking for idr_alloc/idr_remove

Cong Wang (1):
      nsfs: mark dentry with DCACHE_RCUACCESS

Daniel Lezcano (1):
      clocksource/drivers/stm32: Fix kernel panic with multiple timers

Daniel Mentz (2):
      media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
      media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Daniel N Pettersson (1):
      cifs: Fix autonegotiate security settings mismatch

Eric Biggers (9):
      NFS: reject request for id_legacy key without auxdata
      crypto: hash - introduce crypto_hash_alg_has_setkey()
      crypto: cryptd - pass through absence of ->setkey()
      crypto: mcryptd - pass through absence of ->setkey()
      crypto: poly1305 - remove ->setkey() method
      crypto: sha512-mb - initialize pending lengths correctly
      kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"
      pipe: actually allow root to exceed the pipe buffer limits
      pipe: fix off-by-one error when checking buffer limits

Eric W. Biederman (3):
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      signal/sh: Ensure si_signo is initialized in do_divide_error
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user=
 copy

Greg Kroah-Hartman (2):
      ACPI: sbshc: remove raw pointer from printk() message
      Linux 4.9.82

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

Heiko Carstens (1):
      fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()

Horia Geant=C4=83 (1):
      crypto: caam - fix endless loop when DECO acquire fails

Hugh Dickins (1):
      kaiser: fix compile error without vsyscall

Imre Deak (1):
      drm/i915: Avoid PPS HW/SW state mismatch due to rounding

Ivan Vecera (1):
      kernfs: fix regression in kernfs_fop_write caused by wrong type

J. Bruce Fields (1):
      NFS: commit direct writes even if they fail partially

James Hogan (1):
      EDAC, octeon: Fix an uninitialized variable warning

James Morse (1):
      KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED

John Keeping (1):
      ASoC: rockchip: i2s: fix playback after runtime resume

Kai-Heng Feng (1):
      Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Kamal Dasu (1):
      mtd: nand: brcmnand: Disable prefetch by default

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

Mauro Carvalho Chehab (2):
      media: ts2020: avoid integer overflows on 32 bit machines
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Max Filippov (1):
      xtensa: fix futex_atomic_cmpxchg_inatomic

Michal Suchanek (1):
      powerpc/pseries: include linux/types.h in asm/hvcall.h

Mika Westerberg (2):
      ahci: Add Intel Cannon Lake PCH-H PCI ID
      pinctrl: intel: Initialize GPIO properly when used through irqchip

Mikulas Patocka (3):
      alpha: fix crash if pthread_create races with signal delivery
      alpha: fix reboot on Avanti platform
      alpha: fix formating of stack content

Miquel Raynal (2):
      mtd: nand: Fix nand_do_read_oob() return value
      mtd: nand: sunxi: Fix ECC strength choice

Mohamed Ghannam (1):
      dccp: CVE-2017-8824: use-after-free in DCCP code

Nikolay Borisov (1):
      btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker

Petr Cvek (1):
      usb: gadget: uvc: Missing files for configfs interface

Rasmus Villemoes (1):
      kernel/async.c: revert "async: simplify lowest_in_progress()"

Sascha Hauer (1):
      ubi: fastmap: Erase outdated anchor PEBs during attach

Scott Mayhew (1):
      nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Steven Rostedt (VMware) (3):
      sched/rt: Use container_of() to get root domain in rto_push_irq_work_=
func()
      sched/rt: Up the root domain ref count when passing it around via IPIs
      ftrace: Remove incorrect setting of glob search field

Takashi Iwai (1):
      ASoC: skl: Fix kernel warning due to zero NHTL entry

Thomas Gleixner (1):
      posix-timer: Properly check sigevent->sigev_notify

Toshi Kani (1):
      acpi, nfit: fix register dimm error handling

Trond Myklebust (2):
      NFS: Add a cond_resched() to nfs_commit_release_pages()
      NFS: Fix a race between mmap() and O_DIRECT

Xiaolei Li (1):
      ubifs: Massage assert in ubifs_xattr_set() wrt. init_xattrs

Yang Shunyong (1):
      dmaengine: dmatest: fix container_of member in dmatest_callback


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqILUEACgkQONu9yGCS
aT4qVw/+IIxAfB5KmmdwyWBz9jxgUB+oujiO2ES5v2MabyxBY+Cq5pCM+epAuMJ8
GAmbU1WFgUhKkU9tU9j7b91dEOA3Oeu9HNbYTRC73Yft+I8f6FEpwKs1K+4TrBIq
ddlW25uU9P8PR8uKg3PIwoalUCyTdqWGkkE9pnb82u2UZmz2eSh/qXv4UC1gsDeR
PCURLEhRI1iEbKNbbt5y+PGXSHDXd47lKZklmC0exJ8TKqnxjuOpsAyZTiXUlenE
DzgtVYkNbzTJ6TIZyKOxIiWjH9INFsurysGOON1jjBY1oUo7rrKoL6PWpifc7n4x
ZMml2D9p2OJIHEcik5Eh8xRicCQnFhAj+XzKnl7BQGB55I4MPkFq3DY9akT7EzME
dcPsNbC+GkKLE7gmsl+DzzXKNHneyb3BxWmZILwh/WxSfu/hM17eA803vD9NUuQW
BJAIuhcW3hKjFbUPSum8rUnoi5u4EwKIPSYGyxhb1+azboETMgFf0t11gngaixXi
Nih8o4SB/jmR+VCjTgMQkI5LGv8bd9ZkkQ0TqN0j6ltPju4Bzsjm07agliziTqqt
2Kyhtr9ediB6GlveZXYrO0xPLJtLwJDi+QcKwpsbouCE7cG1I9zEqgE7TWZAITD2
3gZq22FpEziBYoiPxn4RQd9Ary6QVQVlGnJViQtSXkrgyq6qEFk=
=FhF4
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
