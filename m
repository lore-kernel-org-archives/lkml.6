Date: Tue, 24 Apr 2018 11:19:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.96
Message-ID: <20180424091941.GA21970@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.96 kernel.

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

 Makefile                                         |    2=20
 arch/arm/boot/dts/at91sam9g25.dtsi               |    2=20
 arch/arm/boot/dts/exynos5250.dtsi                |    8=20
 arch/arm/boot/dts/sama5d4.dtsi                   |    2=20
 arch/mips/include/asm/uaccess.h                  |   11 +
 arch/mips/lib/memset.S                           |   11 -
 arch/powerpc/include/asm/barrier.h               |    3=20
 arch/powerpc/include/asm/opal.h                  |    3=20
 arch/powerpc/include/asm/synch.h                 |    4=20
 arch/powerpc/kernel/eeh_pe.c                     |    3=20
 arch/powerpc/lib/feature-fixups.c                |    2=20
 arch/powerpc/platforms/powernv/opal-nvram.c      |   11 +
 arch/s390/hypfs/inode.c                          |    2=20
 arch/um/os-Linux/file.c                          |    1=20
 arch/um/os-Linux/signal.c                        |    3=20
 arch/x86/um/stub_segv.c                          |    3=20
 block/blk-mq.c                                   |    4=20
 drivers/acpi/nfit/core.c                         |    5=20
 drivers/acpi/video_detect.c                      |    9 +
 drivers/base/regmap/regmap.c                     |    2=20
 drivers/char/random.c                            |   29 ++-
 drivers/clk/bcm/clk-bcm2835.c                    |    8=20
 drivers/clk/mvebu/armada-38x.c                   |   15 -
 drivers/clk/renesas/clk-sh73a0.c                 |    6=20
 drivers/dma/at_xdmac.c                           |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c      |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |    2=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |    4=20
 drivers/gpu/drm/radeon/si_dpm.c                  |    4=20
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c      |   23 +-
 drivers/hid/hid-core.c                           |   10 -
 drivers/hid/hid-input.c                          |    3=20
 drivers/hid/hid-multitouch.c                     |    5=20
 drivers/hid/hid-rmi.c                            |    4=20
 drivers/hid/hidraw.c                             |    5=20
 drivers/hid/i2c-hid/i2c-hid.c                    |   13 -
 drivers/hid/wacom_sys.c                          |    2=20
 drivers/infiniband/core/ucma.c                   |    3=20
 drivers/infiniband/sw/rxe/rxe_verbs.c            |    5=20
 drivers/infiniband/ulp/srp/ib_srp.c              |   18 +-
 drivers/iommu/intel-svm.c                        |    1=20
 drivers/irqchip/irq-gic-common.c                 |    9 -
 drivers/mmc/host/jz4740_mmc.c                    |    2=20
 drivers/mtd/ubi/block.c                          |    2=20
 drivers/mtd/ubi/build.c                          |   11 +
 drivers/mtd/ubi/fastmap-wl.c                     |    1=20
 drivers/net/xen-netfront.c                       |    7=20
 drivers/nvdimm/namespace_devs.c                  |    4=20
 drivers/pci/hotplug/acpiphp_glue.c               |   23 +-
 drivers/pwm/pwm-rcar.c                           |    8=20
 drivers/spi/spi.c                                |   10 -
 drivers/thermal/imx_thermal.c                    |    6=20
 drivers/thunderbolt/nhi.c                        |    1=20
 drivers/tty/n_tty.c                              |    6=20
 drivers/tty/tty_io.c                             |    9 +
 drivers/usb/core/generic.c                       |    9 -
 drivers/usb/dwc3/dwc3-pci.c                      |    2=20
 drivers/usb/gadget/function/f_midi.c             |    3=20
 drivers/usb/gadget/u_f.h                         |    2=20
 drivers/usb/gadget/udc/core.c                    |    3=20
 drivers/usb/musb/musb_gadget_ep0.c               |   14 +
 drivers/vfio/pci/vfio_pci_config.c               |   29 +++
 drivers/watchdog/f71808e_wdt.c                   |    2=20
 fs/autofs4/root.c                                |    2=20
 fs/cifs/cifsglob.h                               |    1=20
 fs/cifs/inode.c                                  |   33 ++++
 fs/ext4/balloc.c                                 |    3=20
 fs/ext4/ialloc.c                                 |   47 -----
 fs/ext4/inode.c                                  |   11 -
 fs/ext4/super.c                                  |    6=20
 fs/fs-writeback.c                                |    7=20
 fs/jbd2/journal.c                                |    5=20
 fs/jffs2/super.c                                 |    2=20
 fs/namespace.c                                   |    3=20
 fs/notify/fanotify/fanotify.c                    |   34 +---
 fs/orangefs/super.c                              |    5=20
 fs/reiserfs/journal.c                            |    2=20
 fs/ubifs/super.c                                 |   14 +
 fs/udf/unicode.c                                 |    6=20
 include/dt-bindings/clock/mt2701-clk.h           |    3=20
 include/linux/backing-dev-defs.h                 |    5=20
 include/linux/backing-dev.h                      |   30 +--
 include/linux/hid.h                              |    6=20
 include/linux/tty.h                              |    1=20
 include/sound/pcm_oss.h                          |    1=20
 include/uapi/linux/random.h                      |    3=20
 ipc/shm.c                                        |   23 ++
 kernel/resource.c                                |    3=20
 mm/filemap.c                                     |    9 -
 mm/page-writeback.c                              |   18 +-
 mm/slab.c                                        |    3=20
 net/sunrpc/rpc_pipe.c                            |    1=20
 sound/core/oss/pcm_oss.c                         |  186 ++++++++++++++++++=
-----
 sound/core/pcm.c                                 |    8=20
 sound/core/rawmidi_compat.c                      |   18 +-
 sound/pci/hda/hda_intel.c                        |    3=20
 sound/soc/codecs/ssm2602.c                       |   19 +-
 sound/usb/line6/midi.c                           |    2=20
 99 files changed, 648 insertions(+), 300 deletions(-)

Aaron Ma (3):
      HID: i2c-hid: fix size check and type usage
      HID: Fix hid_report_len usage
      HID: core: Fix size as type u32

Al Viro (5):
      jffs2_kill_sb(): deal with failed allocations
      hypfs_kill_super(): deal with failed allocations
      orangefs_kill_sb(): deal with allocation failures
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts

Alex Deucher (2):
      drm/amdgpu: Add an ATPX quirk for hybrid laptop
      drm/amdgpu: Fix PCIe lane width calculation

Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update

Alex Williamson (1):
      vfio/pci: Virtualize Maximum Read Request Size

Amir Goldstein (1):
      fanotify: fix logic of events on child

Andrew Morton (1):
      fs/reiserfs/journal.c: add missing resierfs_warning() arg

Aniruddha Banerjee (1):
      irqchip/gic: Take lock when updating irq type

Arnd Bergmann (1):
      clk: fix false-positive Wmaybe-uninitialized warning

Bart Van Assche (3):
      RDMA/rxe: Fix an out-of-bounds read
      IB/srp: Fix srp_abort()
      IB/srp: Fix completion vector assignment algorithm

Bas Nieuwenhuizen (1):
      drm/amdgpu: Fix always_valid bos multiple LRU insertions.

Boris Brezillon (1):
      clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Dan Carpenter (1):
      regmap: Fix reversed bounds check in regmap_raw_write()

Dan Williams (2):
      libnvdimm, namespace: use a safe lookup for dimm device name
      nfit, address-range-scrub: fix scrub in-progress reporting

David Wang (1):
      ALSA: hda - New VIA controller suppor no-snoop path

Eric Biggers (1):
      ipc/shm: fix use-after-free of shm file via remap_file_pages()

Eryu Guan (1):
      ext4: protect i_disksize update by i_data_sem in direct write path

Fabi=E1n Inostroza (1):
      ALSA: line6: Use correct endpoint type for midi output

Felipe Balbi (1):
      usb: gadget: udc: core: update usb_ep_queue() documentation

Greg Kroah-Hartman (1):
      Linux 4.9.96

Greg Thelen (1):
      writeback: safer lock nesting

Hans de Goede (1):
      ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z=
5E

Heinrich Schuchardt (1):
      usb: musb: gadget: misplaced out of bounds check

Ian Kent (1):
      autofs: mount point create should honour passed in mode

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix WD_EN register read

James Kelly (1):
      ASoC: ssm2602: Replace reg_default_raw with reg_default

Jan Kara (1):
      udf: Fix leak of UTF-16 surrogates into encoded strings

Jason A. Donenfeld (1):
      um: Compile with modern headers

Jason Andryuk (1):
      xen-netfront: Fix hang on device removal

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

Lu Baolu (1):
      iommu/vt-d: Fix a potential memory leak

Marc Zyngier (1):
      drm/rockchip: Clear all interrupts before requesting the IRQ

Marek Szyprowski (1):
      ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250

Matt Redfearn (4):
      MIPS: uaccess: Add micromips clobbers to bzero invocation
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Maxime Chevallier (1):
      spi: Fix scatterlist elements size in spi_map_buf

Maxime Jayat (1):
      dmaengine: at_xdmac: fix rare residue corruption

Michael Ellerman (1):
      powerpc/lib: Fix off-by-one in alternate feature patching

Michael Neuling (1):
      powerpc/eeh: Fix enabling bridge MMIO windows

Mika Westerberg (2):
      ACPI / hotplug / PCI: Check presence of slot itself in get_slot_statu=
s()
      thunderbolt: Resume control channel after hibernation image is created

Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()

Nicholas Piggin (4):
      powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
      powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
      powerpc/powernv: define a standard delay for OPAL_BUSY type retry loo=
ps
      powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Paul Parsons (1):
      drm/radeon: Fix PCIe lane width calculation

Ralph Sennhauser (1):
      clk: mvebu: armada-38x: add support for 1866MHz variants

Richard Genoud (1):
      clk: mvebu: armada-38x: add support for missing clocks

Richard Weinberger (3):
      ubifs: Check ubifs_wbuf_sync() return code
      ubi: fastmap: Don't flush fastmap work on detach
      ubi: Reject MLC NAND

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Roland Dreier (1):
      RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA de=
vice

Romain Izard (1):
      ubi: Fix error for write access

Ryo Kodama (1):
      pwm: rcar: Fix a condition to prevent mismatch value setting to duty

Santiago Esteban (1):
      ARM: dts: at91: sama5d4: fix pinctrl compatible string

Sean Wang (1):
      dt-bindings: clock: mediatek: add binding for fixed-factor clock axis=
el_d4

Steve French (1):
      smb3: Fix root directory when server returns inode number of zero

Takashi Iwai (8):
      resource: fix integer overflow at reallocation
      ALSA: pcm: Fix UAF at PCM release via PCM timer access
      ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
      ALSA: pcm: Avoid potential races between OSS ioctls and read/write
      ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
      ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
      ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Tejun Heo (1):
      tty: make n_tty_read() always abort if hangup is in progress

Theodore Ts'o (8):
      random: use a tighter cap in credit_entropy_bits_safe()
      jbd2: if the journal is aborted then don't allow update of the log ta=
il
      ext4: don't update checksum of new initialized bitmaps
      ext4: fail ext4_iget for root directory if unallocated
      ext4: don't allow r/w mounts if metadata blocks overlap the superblock
      random: fix crng_ready() test
      random: crng_reseed() should lock the crng instance that it is modify=
ing
      random: add new ioctl RNDRESEEDCRNG

Thinh Nguyen (1):
      usb: dwc3: pci: Properly cleanup resource

Vlastimil Babka (1):
      mm, slab: reschedule cache_reap() on the same CPU

Wanpeng Li (1):
      block/mq: fix potential deadlock during cpu hotplug

Yavuz, Tuba (1):
      USB: gadget: f_midi: fixing a possible double-free in f_midi

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlre9qwACgkQONu9yGCS
aT4lLA//aVC5RBZ8306/eUIOlbS+zHZzwTIqcaHCsbOoslohUW7oYKDsLj+qWA76
wI3W7M66hw7pjz67DAQ+ozH2shmZ0SnJA6QPrkDP8P+y7ipJYWzaNaDoUdd31AFx
+od2pCXcIQXFoXQW7hNT2qVu0n1g7vdvFoiwGRfNdN1CD0+JScgW62rba1WOA7uZ
VZX+cN07gswRROas6KCgjua+aN91W7JPu0ACyuJtcgk9jjTRQ3io8XMc7p3AaYqN
HfP75bpJrIrJ8PDRrR5sm2zB5Nv+DmhwRdl8wdPPz3gvF3P35AP3buqPYs1PS361
BXQbOstahmLrRulMyWYxAYjbQEWl81/z4rVLJK+HYPvNoWoABAkv9MfObKpVdsMh
cHWN3dl2pmYKh/YhHJMBtk+GY9nqBL+8SGt/Hks2KqU1194fqLtK/+kxR9Vh3l03
sHRGXq59iM6nnkYggDBeQhCYAGCq5HnT3xQeGmkFp6e9YpAQ+/PBVJkPOiUFmwhK
hmCYzJxOIBKxBDfx72sQj9Z8x9JXNNwxbulbgrTQn8OmbQ6fXvfKlwReyDEr9j1M
5/jIa/UZTPCJVyDyZl8eqZ9/f8UMssEXhPTb/NuPL/qj+dLKtNpJRxiLxUC3gih8
pPAiR1rSqmJyXmcJi5PIFspSdSuIxf/8hu9Gi9eAXgJyZo6iqAs=
=H2Xa
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
