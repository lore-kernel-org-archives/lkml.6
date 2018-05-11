Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeEKF7h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:59:37 -0400
Received: from ozlabs.org ([203.11.71.1]:59041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeEKF7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:59:33 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 11 May 2018 15:59:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 11
Message-ID: <20180511155930.30d1e8ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m4mA.oz2k.VFbdQK_dKSVwR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m4mA.oz2k.VFbdQK_dKSVwR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180510:

New trees: regmap-fixes
	regulator-fixes
	omap-fixes
	powerpc-pkey

Non-merge commits (relative to Linus' tree): 5376
 5157 files changed, 196107 insertions(+), 93830 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 267 trees (counting Linus' and 53 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (94d7dbf10881 Merge tag 'for-4.17/dm-fixes' of git://=
git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (0da7e4326114 genksyms: fix typo in parse.tab.=
{c,h} generation rules)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (30cfae461581 ARM: replace unnecessary perl with =
sed and the shell $(( )) operator)
Merging arm64-fixes/for-next/fixes (3789c122d0a0 arm64: avoid instrumenting=
 atomic_ll_sc.o)
Merging m68k-current/for-linus (ecd685580c8f m68k/mac: Remove bogus "FIXME"=
 comment)
Merging powerpc-fixes/fixes (6c0a8f6b5a45 powerpc/pseries: Fix CONFIG_NUMA=
=3Dn build)
Merging sparc/master (fff75eb2a08c Merge tag 'errseq-v4.17' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jlayton/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (ca3943c4aaff Merge tag 'linux-can-fixes-for-4.17-201805=
10' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can)
Merging bpf/master (26aeb9daa02c nfp: bpf: allow zero-length capabilities)
Merging ipsec/master (2c5d5b13c6eb llc: better deal with too small mtu)
Merging netfilter/master (bb7b40aecbf7 netfilter: nf_tables: bogus EBUSY in=
 chain deletions)
Merging ipvs/master (2f99aa31cd7a netfilter: nf_tables: skip synchronize_rc=
u if transaction log is empty)
Merging wireless-drivers/master (a8d7aa17bbc9 dccp: fix tasklet usage)
Merging mac80211/master (914eac248d87 mac80211: use timeout from the AddBA =
response instead of the request)
Merging rdma-fixes/for-rc (9aa169213d11 RDMA/cma: Do not query GID during Q=
P state transition to RTR)
Merging sound-current/for-linus (f13876e2c33a ALSA: pcm: Check PCM state at=
 xfern compat ioctl)
Merging sound-asoc-fixes/for-linus (4506b923fac4 Merge branch 'asoc-4.17' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (e37563bb6c59 Merge tag 'for-4.17-part2-tag'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging regulator-fixes/for-linus (e37563bb6c59 Merge tag 'for-4.17-part2-t=
ag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging spi-fixes/for-linus (19fe64cdd0be Merge branch 'spi-4.17' into spi-=
linus)
Merging pci-current/for-linus (0cf22d6b317c PCI: Add "PCIe" to pcie_print_l=
ink_status() messages)
Merging driver-core.current/driver-core-linus (6da6c0db5316 Linux v4.17-rc3)
Merging tty.current/tty-linus (6da6c0db5316 Linux v4.17-rc3)
Merging usb.current/usb-linus (75bc37fefc44 Linux 4.17-rc4)
Merging usb-gadget-fixes/fixes (ed769520727e usb: gadget: composite Allow f=
or larger configuration descriptors)
Merging usb-serial-fixes/usb-linus (4842ed5bfcb9 USB: serial: visor: handle=
 potential invalid device configuration)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging staging.current/staging-linus (9d569b1cf7a2 Merge tag 'iio-fixes-fo=
r-4.17a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into st=
aging-linus)
Merging char-misc.current/char-misc-linus (6da6c0db5316 Linux v4.17-rc3)
Merging input-current/for-linus (f6eeb9e54857 Input: atmel_mxt_ts - add mis=
sing compatible strings to OF device table)
Merging crypto-current/master (eea0d3ea7546 crypto: drbg - set freed buffer=
s to NULL)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (834814e80268 Revert: "vfio-pci: Mask INTx if =
a device is not capabable of enabling it")
Merging kselftest-fixes/fixes (c28077035ef3 tools/testing/selftests/x86: fi=
x error: conflicting types for 'pkey_get|pkey_set')
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (613e0bb622e7 Revert "dmaengine: pl330: add D=
MA_PAUSE feature")
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging mtd-fixes/master (3057fcef3853 mtd: rawnand: Make sure we wait tWB =
before polling the STATUS reg)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during=
 shutdown)
Merging v4l-dvb-fixes/fixes (b84c8fdf8e6c media: uvcvideo: Prevent setting =
unavailable flags)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (b3d7e55c3f88 MIPS: uaccess: Add micromips cl=
obbers to bzero invocation)
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (ecf08dad723d KVM: x86: remove APIC Timer periodic=
/oneshot spikes)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging hwmon-fixes/hwmon (40626a1bf657 hwmon: (k10temp) Fix reading critic=
al temperature register)
Merging nvdimm-fixes/libnvdimm-fixes (ce376ed6b706 radix tree: fix multi-or=
der iteration race)
Merging drm-intel-fixes/for-linux-next-fixes (e8f48f96db7e drm/i915: Fix dr=
m:intel_enable_lvds ERROR message in kernel log)
Merging drm-misc-fixes/for-linux-next-fixes (9a0e98022172 drm/vc4: Fix scal=
ing of uni-planar formats)
Merging kbuild/for-next (8b31e5b10006 kbuild: deb-pkg improve maintainer ad=
dress generation)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (d0c8ba40c6cc swiotlb: update comments to refe=
r to physical instead of virtual addresses)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (6dc8c9d147dd Merge branches 'fixes' and 'sa1100-for-n=
ext' into for-next)
Merging arm-perf/for-next/perf (44300aed5d28 perf: arm_spe: include linux/v=
malloc.h for vmap())
Merging arm-soc/for-next (c12d7e9fe9af ARM: defconfig: Update Gemini defcon=
fig)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (ce650ad1cde7 Merge branch 'v4.18/defconfig' into =
tmp/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (5c483a0c319c Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (75ed360763f2 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (fb5d812c3cb3 Merge branch 'for_4.18/keystone-dts' in=
to next)
Merging mediatek/for-next (2916ebd42a41 Merge branch 'v4.17-next/soc' into =
for-next)
Merging mvebu/for-next (e76bec8e643a Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (82ce9553c47f Merge branch 'omap-for-v4.17/fixes' int=
o for-next)
Merging reset/reset/next (d7bab65b1f57 reset: uniphier: add LD11/LD20 strea=
m demux system reset control)
Merging qcom/for-next (c9fe09a79371 soc: Unconditionally include qcom Makef=
ile)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (6480b1624fdd Merge branches 'arm64-dt-for-v4.18' and =
'dt-for-v4.18' into next)
Merging rockchip/for-next (d736f2a5e6bc Merge branch 'v4.18-armsoc/defconfi=
g64' into for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (cc4b07f8156c Merge branch 'next/dt' into for=
-next)
CONFLICT (content): Merge conflict in arch/arm/mach-exynos/Kconfig
Merging sunxi/sunxi/for-next (2b32dbbf4334 Merge branch 'sunxi/dt-for-4.18'=
 into sunxi/for-next)
Merging tegra/for-next (0331f709c1b5 Merge branch for-4.18/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (24534b351182 arm64: assembler: add macros to c=
onditionally yield the NEON under PREEMPT)
Merging clk/clk-next (96695741a646 Merge branch 'clk-qcom-sdm845' into clk-=
next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (f245ff73dbe9 m68k: Use read_persistent_clock64() con=
sistently)
Merging m68knommu/for-next (262afd3d980b m68k: fix ColdFire PCI config read=
s and writes)
Merging microblaze/next (a7a9e2f0410d microblaze: dts: replace 'linux,stdou=
t-path' with 'stdout-path')
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (23f8adc497b7 MIPS: BCM47XX: Use __initdata fo=
r the bcm47xx_leds_pdata)
Merging nds32/next (4b5b05725cf2 Merge branch 'next' of ssh://gitolite.kern=
el.org/pub/scm/linux/kernel/git/greentime/linux into gt-mainline-next)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (07943d6329dc parisc: Build kernel without -ffun=
ction-sections)
Merging powerpc/next (53da14d0833a powerpc: Make it clearer that systbl che=
ck errors are errors)
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/ftrace.h
Merging powerpc-pkey/topic/pkey (d86a4ba02fc6 powerpc/pkeys: Drop private V=
M_PKEY definitions)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (6d08b06e67cd Linux 4.17-rc2)
Merging s390/features (b7e7f5051bf8 s390: remove closung punctuation from s=
pectre messages)
Merging sparc-next/master (17dec0a94915 Merge branch 'userns-linus' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging sh/for-next (bf9c7e3d7924 arch/sh: pcie-sh7786: handle non-zero DMA=
 offset)
Merging uml/linux-next (e40238dedb48 Fix vector raw inintialization logic)
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (6da6c0db5316 Linux v4.17-rc3)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs wh=
en under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (b8111316f384 Merge branch 'for-next-next-v4.1=
8-20180509' into for-next-20180509)
Merging ceph/master (fc218544fbc8 ceph: fix iov_iter issues in ceph_direct_=
read_write())
Merging cifs/for-next (c3d5c2a93abf smb3: directory sync should not return =
an error)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (b1255ee6a289 Pull UDF UTF-16 handling improvements.)
Merging ext4/dev (7ef79ad52136 ext4: add MODULE_SOFTDEP to ensure crc32c is=
 included in the initramfs)
Merging f2fs/dev (5b19d284f519 f2fs: avoid fsync() failure caused by EAGAIN=
 in writepage())
Merging fuse/for-next (5ba24197b94d fuse: add writeback documentation)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (036db8bd9637 Merge branch 'for-4.17-fixes' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/tj/libata)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (5e90394d7f7c nfsd: update obselete comment referenc=
ing the BKL)
Merging orangefs/for-next (8e9ba5c48ea6 Orangefs: documentation updates)
Merging overlayfs/overlayfs-next (16149013f839 ovl: update documentation w.=
r.t "xino" feature)
Merging ubifs/linux-next (b5094b7f135b ubi: Reject MLC NAND)
Merging xfs/for-next (9d93388b0afe iomap: add a swapfile activation functio=
n)
Merging file-locks/locks-next (7a107c0f55a3 fasync: Fix deadlock between ta=
sk-context and interrupt-context kill_fasync())
Merging vfs/for-next (d944db1fd238 Merge branches 'work.dcache' and 'work.m=
isc' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (f8521c77fcd4 Merge branch 'for-4.18-vsprintf-clean=
up' into for-4.18)
Merging pci/next (03cdfc72ee02 Merge branch 'pci/virtualization')
CONFLICT (content): Merge conflict in arch/microblaze/include/asm/pci.h
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (4153e8aad377 Merge branch 'for-4.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (5c1718af7c4b Merge branch 'i2c/for-4.18' into i2c=
/for-next)
Merging dmi/master (5cb06cfce4a8 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (6153ff637b26 hwmon: (ltc2990) support all=
 measurement modes)
Merging jc_docs/docs-next (b971a90f7dd3 docs: ranoops.rst: fix location of =
ramoops.txt)
CONFLICT (modify/delete): Documentation/features/io/dma-api-debug/arch-supp=
ort.txt deleted in HEAD and modified in jc_docs/docs-next. Version jc_docs/=
docs-next of Documentation/features/io/dma-api-debug/arch-support.txt left =
in tree.
$ git rm -f Documentation/features/io/dma-api-debug/arch-support.txt
Merging v4l-dvb/master (901b9dd5e31e media: update/fix my e-mail on some pl=
aces)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (85d108dee574 video: omap: Improve a size dete=
rmination in omapfb_do_probe())
Merging pm/linux-next (6c1f315f566e Merge branch 'pm-pci' into linux-next)
Merging cpupower/cpupower (9fd0c4045146 cpupower: fix spelling mistake: "lo=
gilename" -> "logfilename")
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (28fa4aca262c PM / OPP: Remove dev_pm_opp_{un}re=
gister_get_pstate_helper())
Merging thermal/next (f9cd6a904e6e thermal: exynos: Propagate error value f=
rom tmu_read())
Merging thermal-soc/next (9efc58dfa14a thermal: mediatek: use of_device_get=
_match_data())
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (f706d830154b dlm: make sctp_connect_to_sock() return in s=
pecified time)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb=
_get_sgtable callback)
Merging rdma/for-next (056f9c7f39bf iw_cxgb4: dump detailed driver-specific=
 QP information)
CONFLICT (content): Merge conflict in drivers/infiniband/sw/rxe/rxe_resp.c
Merging net-next/master (ec9efb523cb8 rocker: Postpone filtering of !added_=
by_user FDB)
CONFLICT (content): Merge conflict in tools/testing/selftests/net/Makefile
CONFLICT (content): Merge conflict in net/tls/tls_main.c
CONFLICT (content): Merge conflict in kernel/bpf/syscall.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/realtek/r8169.c
CONFLICT (modify/delete): arch/s390/net/bpf_jit.S deleted in net-next/maste=
r and modified in HEAD. Version HEAD of arch/s390/net/bpf_jit.S left in tre=
e.
$ git rm -f arch/s390/net/bpf_jit.S
Merging bpf-next/master (a84880ef4352 Merge branch 'bpf-perf-rb-libbpf')
Merging ipsec-next/master (724e47a149f5 net-next/hinic: add pci device ids =
for 25ge and 100ge card)
Merging netfilter-next/master (90278871d4b0 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/pablo/nf-next)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (90278871d4b0 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/pablo/nf-next)
Merging wireless-drivers-next/master (4f9fb990013c mwifiex: increase TX thr=
eashold to avoid TX timeout during ED MAC test)
Merging bluetooth/master (7f98779fd9b3 Bluetooth: Add a new 13d3:3496 QCA_R=
OME device)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/apq8096-db82=
0c.dtsi
Merging mac80211-next/master (57c6cb81717f mac80211: ethtool: avoid 32 bit =
multiplication overflow)
Merging gfs2/for-next (9a38662ba4e2 gfs2: Remove sdp->sd_jheightsize)
Merging mtd/mtd/next (5ac67ce36cfe mtd: move code adding (registering) part=
itions to the parse_mtd_partitions())
Merging nand/nand/next (a676688032e8 mtd: rawnand.h: use nested union kerne=
l-doc markups)
Merging spi-nor/spi-nor/next (f134fbbb4ff8 mtd: spi-nor: clear Winbond Exte=
nded Address Reg on switch to 3-byte addressing.)
Merging crypto/master (158b52ff1436 crypto: ghash-clmulni - fix spelling mi=
stake: "acclerated" -> "accelerated")
Merging drm/drm-next (8eb008c80841 Merge tag 'drm-intel-next-2018-04-13' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Applying: drm/xen-front: merge fix for "drivers: remove force dma flag from=
 buses"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (2bdd045e3a30 drm/i915/psr: Check if VBT s=
ays PSR can be enabled.)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_dp.c
Merging drm-tegra/drm/tegra/for-next (5cb02b3dbbe9 drm/tegra: dc: Rename su=
pports_blending to has_legacy_blending)
Merging drm-misc/for-linux-next (3131f209468d drm/vc4: Fix leak of the file=
_priv that stored the perfmon.)
Merging drm-msm/msm-next (64cb96587ba6 drm/msm: Switch to atomic_helper_com=
mit())
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (22cd2b2b3151 drm/imx: Remove last traces of s=
truct imx_drm_crtc)
Merging etnaviv/etnaviv/next (0b50dffa736b drm/etnaviv: remove register log=
ging)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (76f721867da6 Merge branch 'regmap-4.18' into regma=
p-next)
Merging sound/for-next (10aa7cad37d3 ALSA: pcm: Hide local_irq_disable/enab=
le() and local_irqsave/restore())
Merging sound-asoc/for-next (b617f1eae1d2 Merge remote-tracking branches 'a=
soc/topic/doc' and 'asoc/topic/trace' into asoc-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (e7330fa032bb Input: add support for ChipOne icn8505 bas=
ed touchscreens)
Merging block/for-next (61445b56d031 sbitmap: warn if using smaller shallow=
 depth than was setup)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (28700a36232b dm thin: update Documentation =
to clarify when "read_only" is valid)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (cf56c819c851 mmc: tegra: remove redundant return statemen=
t)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (643369299cfe raid5: copy write hint from origin bio to=
 stripe)
Merging mfd/for-mfd-next (ae0280fe1689 mfd: tps65911-comparator: Fix a buil=
d error)
Merging backlight/for-backlight-next (840d40d941bf MAINTAINERS: Add dri-dev=
el for backlight subsystem patches)
Merging battery/for-next (1f140ff46708 Merge tag 'tags/tcpm-pps-4.18' into =
psy-next)
CONFLICT (content): Merge conflict in drivers/usb/core/hcd.c
Merging regulator/for-next (1fd083554fa0 Merge branch 'regulator-4.18' into=
 regulator-next)
Merging security/next-testing (5859cdf55063 smack: provide socketpair callb=
ack)
Merging apparmor/apparmor-next (938df8352997 apparmor: update git and wiki =
locations in AppArmor docs)
Merging integrity/next-integrity (3dea0d93d257 ima: Unify logging)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (d141136f523a audit: normalize MAC_POLICY_LOAD record)
Merging tpmdd/next (1fbad3028664 tpm: tpm_crb: relinquish locality on error=
 path.)
Merging watchdog/master (6d08b06e67cd Linux 4.17-rc2)
Merging iommu/next (00dcb938d482 Merge branches 'iommu/fixes', 'arm/io-pgta=
ble', 'arm/qcom', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (da9147140fe3 MAINTAINERS: vfio/platform: Update sub-main=
tainer)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (326bee0286d7 seccomp: Don't special case audited proces=
ses when logging)
Merging devicetree/for-next (ca3923bd91d0 Merge branch 'dt/linus' into for-=
next)
Merging mailbox/mailbox-for-next (dfbc9c5841fc mailbox: Remove depends on H=
AS_DMA in case of platform dependency)
Merging spi/for-next (7b4a87faf4cf ASoC: omap-mcpdm: Convert to use the sdm=
a-pcm instead of omap-pcm)
Merging tip/auto-latest (a9b6b3b055ea Merge branch 'x86/vdso')
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
Merging clockevents/clockevents/next (0136c741ff40 clocksource/drivers/imx-=
tpm: Add different counter width support)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (83e548bea4e7 EDAC, i7core: Fix spelling mistake:=
 "redundacy" -> "redundancy")
Merging irqchip/irq/irqchip-next (aa08192a254d irqchip/gic: Take lock when =
updating irq type)
Merging ftrace/for-next (0c5a9acc8b4e tracing: Fix the file mode of stack t=
racer)
Merging rcu/rcu/next (b92e1e16d7ca torture: Make online/offline messages ap=
pear only for verbose=3D2)
Merging kvm/linux-next (c18bb396d3d2 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (dc6ed61d2f82 arm64: Add temporary ERRATA_MIDR_ALL_VER=
SIONS compatibility macro)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (31c8b0d0694a KVM: PPC: Book3S HV: Use __gfn_t=
o_pfn_memslot() in page fault handler)
Merging kvms390/next (911eeef91b48 KVM: s390: generalize kvm_s390_get_tod_c=
lock_ext())
Merging xen-tip/linux-next (d1ecfa9d1f40 x86/xen: Reset VCPU0 info pointer =
after shared_info remap)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (1aa3798360db Merge branch 'for-4.17' into for-=
next)
Merging drivers-x86/for-next (6ed66c3ce095 platform/x86: Kconfig: Fix dell-=
laptop dependency chain.)
Merging chrome-platform/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (d54e5b522202 leds: wm831x-status: Use sysfs_match_st=
ring() helper)
Merging ipmi/for-next (163475ebf9f3 ipmi: Remove the proc interface)
Merging driver-core/driver-core-next (cd4846c5a68d Merge 4.17-rc3 into driv=
er-core-next)
Merging usb/usb-next (58318cd4df41 Merge 4.17-rc4 into usb-next)
Merging usb-gadget/next (60cc43fc8884 Linux 4.17-rc1)
Merging usb-serial/usb-next (4d304a6fe935 USB: serial: option: blacklist un=
used dwm-158 interfaces)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (cd3bf368aa7a phy: Add a driver for the ATH79 USB phy)
Merging tty/tty-next (7b6c81f46c5d Merge 4.17-rc3 into tty-next)
Merging char-misc/char-misc-next (720d690e3680 Merge 4.17-rc3 into char-mis=
c-next)
Merging extcon/extcon-next (60cc43fc8884 Linux 4.17-rc1)
Merging staging/staging-next (26a5e9b834a6 staging: mt7621-eth: Alignment s=
hould match open parenthesis)
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (95c1e4acb0c4 Merge branch 'topic/sprd' into next)
Merging cgroup/for-next (28610df5c585 selftests/cgroup: memory controller s=
elf-tests)
Merging scsi/for-next (5d2e147b4963 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (33d065ccb3b2 scsi: tcmu: refactor nl wr_cache at=
tr with new helpers)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (6c86b268a935 Merge branch 'for-4.18' into for-next)
Merging vhost/linux-next (cfcde40e8ce3 ACPI: disable extra P_LVLx access on=
 KVM)
Merging rpmsg/for-next (ff5cf749a5e5 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (22bd82b645bc Merge branch 'devel' into for-next)
Merging pinctrl/for-next (8e12867fb27d Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (0ca0557e3727 pinctrl: samsung: Remove sup=
port for Exynos5440)
Merging pwm/for-next (692099cdcf27 pwm: simplify getting .drvdata)
Merging userns/for-next (530621b79f9e signal/um: More carefully relay signa=
ls in relay_signal.)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (dec77e854318 selftests: net: return Kselftest Skip =
code for skipped tests)
Merging y2038/y2038 (5dc0b1529d21 y2038: ipc: Redirect ipc(SEMTIMEDOP, ...)=
 to compat_ksys_semtimedop)
Merging livepatching/for-next (3beed9bf1e3d Merge branch 'for-4.17/upstream=
-fixes' into for-next)
Merging coresight/next (659d7e66340e coresight: Remove %px for printing pcs=
r value)
Merging rtc/rtc-next (22cb47c1ea20 rtc: stm32: get DBP register and mask fr=
om DT st, syscfg property)
Merging nvdimm/libnvdimm-for-next (638a8e3f28dc memremap: mark devm_memrema=
p_pages() EXPORT_SYMBOL_GPL)
CONFLICT (content): Merge conflict in mm/hmm.c
Merging at24/at24/for-next (22e06c32b936 eeprom: at24: provide a separate r=
outine for creating dummy i2c clients)
Merging ntb/ntb-next (9b42913698a1 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (bd80928a6e0a Merge branch 'kspp/gcc-plugin/stac=
kleak-v11' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (6175f090fa51 ipc/shm: fix shmat() nil address=
 after round-down when remapping)
CONFLICT (content): Merge conflict in kernel/sched/core.c
CONFLICT (content): Merge conflict in arch/sh/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: mm: use octal not symbolic permissions
Applying: treewide: use PHYS_ADDR_MAX to avoid type casting ULLONG_MAX
Applying: mm: fix oom_kill event handling
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (8e03975b1258 sparc64: NG4 memset 32 bits overflow)

--Sig_/m4mA.oz2k.VFbdQK_dKSVwR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr1MUIACgkQAVBC80lX
0Gw+wwf/S9zyLDzDWa4PexK6hwdHTzipiW7KN7hx1v+Wv2D/5ll3xNfGdZtt6sFU
6UMfy8PG/rdgvfHyRWw+p8KoYeSWlOtMxhyADARsCzU4yRREJgUgXa7xO2jvHMBl
WICQsmsE1NA8sMrESurvsHAD2VikdIUi+H8L8/1gQr1wOddAD8SiPcBGlPsiZbhw
kCPjOsrO/yYPiiAIlzfe06eFLsh/Prz8wztbi1R9Wr5lOTfuLSOQgbdgdTVehAXK
JjRler7PuUuK9lGPAjdleuz0AGzvq0HUrBTy8Dg4L57198CziYYhh0N9UqUno4dz
6XZEfF5AZ6yKmhu3T21JD3HKVWZinw==
=3rSM
-----END PGP SIGNATURE-----

--Sig_/m4mA.oz2k.VFbdQK_dKSVwR--
