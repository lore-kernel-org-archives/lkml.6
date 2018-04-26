Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeDZFUX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:20:23 -0400
Received: from ozlabs.org ([203.11.71.1]:44731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeDZFUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:20:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 15:18:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 26
Message-ID: <20180426151853.6a82ed6e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SUt5xib0THceGj7I+IhrGnB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SUt5xib0THceGj7I+IhrGnB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: There will be no linux-next release tomorrow.

Changes since 20180424:

The qcom tree gained a build failure so I used the version from
next-20180424.

The clk-samsung tree gained a build failure so I used the version from
next-20180424.

The bpf-next tree gained conflicts against the bpf and net-next trees.

The wireless-drivers-next gained a conflict against the wireless-drivers
tree.

The rpmsg tree gained a build failure so I used the version from
next-20180424.

Non-merge commits (relative to Linus' tree): 2654
 2460 files changed, 93337 insertions(+), 43456 deletions(-)

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

I am currently merging 258 trees (counting Linus' and 44 trees of bug
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
Merging origin/master (3be4aaf4e2d3 Merge branch 'userns-linus' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (28913ee8191a netfilter: nf_nat_snmp_basic: ad=
d correct dependency to Makefile)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (30cfae461581 ARM: replace unnecessary perl with =
sed and the shell $(( )) operator)
Merging arm64-fixes/for-next/fixes (ad40bdafb495 arm64: support __int128 wi=
th clang)
Merging m68k-current/for-linus (ecd685580c8f m68k/mac: Remove bogus "FIXME"=
 comment)
Merging powerpc-fixes/fixes (75ecfb49516c powerpc/mce: Fix a bug where mce =
loops on memory UE.)
Merging sparc/master (17dec0a94915 Merge branch 'userns-linus' of git://git=
.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (91a825290ca4 rds: ib: Fix missing call to rds_ib_dev_pu=
t in rds_ib_setup_qp)
Merging bpf/master (9c299a32ede9 bpf: fix for lex/yacc build error with gcc=
-5)
Merging ipsec/master (b48c05ab5d32 xfrm: Fix warning in xfrm6_tunnel_net_ex=
it.)
Merging netfilter/master (6cd968f44814 Merge branch 'amd-xgbe-fixes')
Merging ipvs/master (765cca91b895 netfilter: conntrack: include kmemleak.h =
for kmemleak_not_leak())
Merging wireless-drivers/master (af8a41cccf8f rtlwifi: cleanup 8723be ant_s=
el definition)
Merging mac80211/master (2f0605a697f4 nl80211: Free connkeys on external au=
thentication failure)
Merging rdma-fixes/for-rc (dc5640f294e4 IB/core: Fix deleting default GIDs =
when changing mac adddress)
Merging sound-current/for-linus (8a7d6003df41 ALSA: hda - Skip jack and oth=
ers for non-existing PCM streams)
Merging pci-current/for-linus (0cf22d6b317c PCI: Add "PCIe" to pcie_print_l=
ink_status() messages)
Merging driver-core.current/driver-core-linus (b93815d0f37e firmware: some =
documentation fixes)
Merging tty.current/tty-linus (bcdd0ca8cb87 tty: Use __GFP_NOFAIL for tty_l=
disc_get())
Merging usb.current/usb-linus (be75d8f1da08 USB: musb: dsps: drop duplicate=
 phy initialisation)
Merging usb-gadget-fixes/fixes (c6ba5084ce0d usb: gadget: udc: renesas_usb3=
: add binging for r8a77965)
Merging usb-serial-fixes/usb-linus (470b5d6f0cf4 USB: serial: ftdi_sio: use=
 jtag quirk for Arrow USB Blaster)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging staging.current/staging-linus (b00e2fd10429 staging: wilc1000: fix =
NULL pointer exception in host_int_parse_assoc_resp_info())
Merging char-misc.current/char-misc-linus (d2ffed5185df ARM: amba: Don't re=
ad past the end of sysfs "driver_override" buffer)
Merging input-current/for-linus (596ea7aad431 MAINTAINERS: Rakesh Iyer can'=
t be reached anymore)
Merging crypto-current/master (eea0d3ea7546 crypto: drbg - set freed buffer=
s to NULL)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (834814e80268 Revert: "vfio-pci: Mask INTx if =
a device is not capabable of enabling it")
Merging kselftest-fixes/fixes (8bf24e831961 selftests/filesystems: Don't ru=
n dnotify_test by default)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during=
 shutdown)
Merging v4l-dvb-fixes/fixes (f017ca642e8a media: imx-media-csi: Fix inconsi=
stent IS_ERR and PTR_ERR)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bi=
t compilation)
Merging mips-fixes/mips-fixes (b3d7e55c3f88 MIPS: uaccess: Add micromips cl=
obbers to bzero invocation)
Merging kvm-fixes/master (06e22bb6fa5b Merge tag 'kvmarm-fixes-for-4.17-1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging drm-intel-fixes/for-linux-next-fixes (0b551f1e0fc5 drm/i915/fbdev: =
Enable late fbdev initial configuration)
Merging drm-misc-fixes/for-linux-next-fixes (1f6b8eef11c3 drm/edid: Reset m=
ore of the display info)
Merging syscalls/syscalls-next (c9a211951c7c bpf: whitelist all syscalls fo=
r error injection)
Merging kbuild/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (60695be2bb6b dma-mapping: postpone cpu addr t=
ranslation on mmap)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (6dc8c9d147dd Merge branches 'fixes' and 'sa1100-for-n=
ext' into for-next)
Merging arm-perf/for-next/perf (44300aed5d28 perf: arm_spe: include linux/v=
malloc.h for vmap())
Merging arm-soc/for-next (cb799267bb65 MAINTAINERS: Update ASPEED entry wit=
h details)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b9b2e4f8f5fd ARM64: dts: meson-axg: add tdm pins)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (5c483a0c319c Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (7a3adfb6a804 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (dacf37850167 Merge branch 'for_4.17/soc-drivers' int=
o next)
Merging mvebu/for-next (4c1b45a44e35 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (fb289e3ab10c Merge branch 'omap-for-v4.17/fixes-ti-s=
ysc' into omap-for-v4.17/fixes)
Merging reset/reset/next (0089313d8595 Merge branch 'reset/lookup' into res=
et/next)
Merging qcom/for-next (c78d6951a806 Merge branch 'soc-for-4.18' into all-fo=
r-4.18)
$ git reset --hard HEAD^
Merging next-20180424 version of qcom
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (9444640b1d77 Merge branches 'fixes-for-v4.17', 'arm64=
-dt-for-v4.18', 'defconfig-for-v4.18', 'dt-for-v4.18' and 'soc-for-v4.18' i=
nto next)
Merging rockchip/for-next (aaa7709c6703 Merge branch 'v4.18-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (64c3552d7255 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (62960b11f7d9 Merge branches 'sunxi/dt-for-4.1=
8' and 'sunxi/h3-h5-for-4.18' into sunxi/for-next)
Merging tegra/for-next (6b9b5116227d Merge branch for-4.17/clk into for-nex=
t)
Merging arm64/for-next/core (24534b351182 arm64: assembler: add macros to c=
onditionally yield the NEON under PREEMPT)
Merging clk/clk-next (3baba436e3a6 Merge branch 'clk-core' into clk-next)
Merging clk-samsung/for-next (e4d61444bd51 clk: samsung: simplify getting .=
drvdata)
$ git reset --hard HEAD^
Merging next-20180424 version of clk-samsung
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (b87ed027ce5d m68k: Use read_persistent_clock64() con=
sistently)
Merging m68knommu/for-next (6d08b06e67cd Linux 4.17-rc2)
Merging microblaze/next (a7a9e2f0410d microblaze: dts: replace 'linux,stdou=
t-path' with 'stdout-path')
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (23f8adc497b7 MIPS: BCM47XX: Use __initdata fo=
r the bcm47xx_leds_pdata)
Merging nds32/next (99c7c4f57c4f nds32: Fix the allmodconfig build. To make=
 sure CONFIG_CPU_LITTLE_ENDIAN is default y)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (c04d31f98cf5 parisc: Fix section mismatches)
Merging powerpc/next (60cc43fc8884 Linux 4.17-rc1)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (6d08b06e67cd Linux 4.17-rc2)
Merging s390/features (6cf09958f32b s390: correct module section names for =
expoline code revert)
Merging sparc-next/master (17dec0a94915 Merge branch 'userns-linus' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging sh/for-next (bf9c7e3d7924 arch/sh: pcie-sh7786: handle non-zero DMA=
 offset)
Merging uml/linux-next (e40238dedb48 Fix vector raw inintialization logic)
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (0b1dfa4cc6c6 fscrypt: fix build with pre-4.6 gcc ve=
rsions)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs wh=
en under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (b2bcca2c9b16 Merge branch 'for-next-next-v4.1=
8-20180424' into for-next-20180424)
Merging ceph/master (ff2adf13bf7e libceph: validate con->state at the top o=
f try_write())
Merging cifs/for-next (d18ee79ecab8 cifs: smbd: Enable signing with smbdire=
ct)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (b1255ee6a289 Pull UDF UTF-16 handling improvements.)
Merging ext4/dev (b025a674fc5d ext4: force revalidation of directory pointe=
r after seekdir(2))
Merging f2fs/dev (b549e322861b f2fs: check cap_resource only for data block=
s)
Merging fuse/for-next (5ba24197b94d fuse: add writeback documentation)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (60cc43fc8884 Linux 4.17-rc1)
Merging nfs-anna/linux-next (98de9ce6f666 NFS: advance nfs_entry cookie onl=
y after decoding completes successfully)
Merging nfsd/nfsd-next (36e000768550 nfsd: update obselete comment referenc=
ing the BKL)
Merging orangefs/for-next (8e9ba5c48ea6 Orangefs: documentation updates)
Merging overlayfs/overlayfs-next (16149013f839 ovl: update documentation w.=
r.t "xino" feature)
Merging ubifs/linux-next (b5094b7f135b ubi: Reject MLC NAND)
Merging xfs/for-next (7b38460dc8e4 xfs: don't fail when converting shortfor=
m attr to long form during ATTR_REPLACE)
Merging file-locks/locks-next (fa28b25b62ba fasync: Fix deadlock between ta=
sk-context and interrupt-context kill_fasync())
Merging vfs/for-next (d944db1fd238 Merge branches 'work.dcache' and 'work.m=
isc' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (f8521c77fcd4 Merge branch 'for-4.18-vsprintf-clean=
up' into for-4.18)
Merging pci/next (60cc43fc8884 Linux 4.17-rc1)
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (ae8e917ce5db Merge branch 'for-4.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging dmi/master (0a5f08c2f0c7 firmware: dmi_scan: Use lowercase letters =
for UUID)
Merging hwmon-staging/hwmon-next (03af583b1f65 Merge tag 'ib-mfd-hwmon-v4.1=
8' into hwmon-next)
Merging jc_docs/docs-next (3b443955596e Docs: tell maintainers to put [GIT =
PULL] in their subject lines)
Merging v4l-dvb/master (a2b2eff6ac27 media: v4l: fwnode: Fix comment incorr=
ectly mentioning v4l2_fwnode_parse_endpoint)
Merging v4l-dvb-next/master (17dec0a94915 Merge branch 'userns-linus' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging fbdev/fbdev-for-next (4f7afece3afd video: fbdev: sh_mobile_meram: D=
rop SUPERH platform dependency)
Merging pm/linux-next (fa3ee26bbaed Merge branches 'pm-cpufreq' and 'pm-cor=
e' into linux-next)
Merging cpupower/cpupower (7928b2cbe55b Linux 4.16-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (4a823c0be80f opp: cpu: Replace GFP_ATOMIC with =
GFP_KERNEL in dev_pm_opp_init_cpufreq_table)
Merging thermal/next (b907b408ca64 Merge branches 'thermal-core' and 'therm=
al-soc' into next)
Merging thermal-soc/next (629d835db501 thermal: imx: add i.MX7 thermal sens=
or support)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb=
_get_sgtable callback)
Merging rdma/for-next (fe896ceb5772 IB/rxe: replace refcount_inc with skb_g=
et)
Merging net-next/master (c8ad08929d1b Merge branch '10GbE' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jkirsher/next-queue)
Merging bpf-next/master (af487c577770 Merge branch 'bpf-optimize-neg-sums')
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/.gitignore
CONFLICT (modify/delete): samples/sockmap/Makefile deleted in bpf-next/mast=
er and modified in HEAD. Version HEAD of samples/sockmap/Makefile left in t=
ree.
$ git rm -f samples/sockmap/Makefile
Merging ipsec-next/master (cd027a5433d6 udp: enable UDP checksum offload fo=
r ESP)
Merging netfilter-next/master (159f02977b2f Merge branch 'net-mvneta-improv=
e-suspend-resume')
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (9a17740e0ea1 ipvs: fix multiplicative hashing in =
sh/dh/lblc/lblcr algorithms)
Merging wireless-drivers-next/master (51c12756de42 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/iw=
l-nvm-parse.c
Merging bluetooth/master (e53e9e4e6bb8 Bluetooth: btusb: add ID for LiteOn =
04ca:301a)
Merging mac80211-next/master (8db0c433692e regulatory: Rename confusing 'co=
untry IE' in log output)
Merging gfs2/for-next (9a38662ba4e2 gfs2: Remove sdp->sd_jheightsize)
Merging mtd/master (7b70eb14392a mtd: cfi: cmdset_0002: Do not allow read/w=
rite to suspend erase block.)
Merging l2-mtd/mtd/next (0e210b542cdb mtd: devices: simplify getting .drvda=
ta)
Merging nand/nand/next (bfc3ff92b152 mtd: onenand: simplify getting .drvdat=
a)
Merging spi-nor/spi-nor/next (f134fbbb4ff8 mtd: spi-nor: clear Winbond Exte=
nded Address Reg on switch to 3-byte addressing.)
Merging crypto/master (b930f3a2292d crypto: caam: - Use kmemdup() function)
Merging drm/drm-next (6d08b06e67cd Linux 4.17-rc2)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (ff047a87cfac drm/i915/icl: Correctly clea=
r lost ctx-switch interrupts across reset for Gen11)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_runtime_pm=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_bios.c
Merging drm-tegra/drm/tegra/for-next (27e92f1f1600 drm/tegra: prime: Implem=
ent ->{begin,end}_cpu_access())
Merging drm-misc/for-linux-next (3131f209468d drm/vc4: Fix leak of the file=
_priv that stored the perfmon.)
Merging drm-msm/msm-next (789d4c300e10 drm/msm: don't deref error pointer i=
n the msm_fbdev_create error path)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (22cd2b2b3151 drm/imx: Remove last traces of s=
truct imx_drm_crtc)
Merging etnaviv/etnaviv/next (4ed75c3e5255 drm/etnaviv: bump HW job limit t=
o 4)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (9e12b358300f Merge branch 'regmap-4.18' into regma=
p-next)
Merging sound/for-next (4d31c6e41ed2 Merge branch 'for-linus' into for-next)
Merging sound-asoc/for-next (f6cf346128bb Merge branch 'asoc-4.18' into aso=
c-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (d91abc21e1e6 Input: alps - demystify trackstick initial=
ization for v3 and v6 protocols)
Merging block/for-next (667eea5d591b Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (a1c0a8e35b88 dm bufio: fix buffer alignment)
Merging mmc/next (9e9356de51be mmc: sdhci-msm: support voltage pad switchin=
g)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (fd823089ffac raid5: copy write hint from origin bio to=
 stripe)
Merging mfd/for-mfd-next (ae0280fe1689 mfd: tps65911-comparator: Fix a buil=
d error)
Merging backlight/for-backlight-next (ea388d6cffd4 pwm-backlight: Add suppo=
rt for PWM delays proprieties.)
Merging battery/for-next (a78c0c30ec73 power: supply: axp288_fuel_gauge: Re=
move polling from the driver)
Merging regulator/for-next (49b07c0d58da Merge remote-tracking branch 'regu=
lator/topic/bd9571mwv' into regulator-next)
Merging security/next-testing (b393a707c84b Merge tag 'v4.17-rc2' into next=
-general)
Merging apparmor/apparmor-next (588558eb6d0e apparmor: fix memory leak on b=
uffer on error exit path)
Merging integrity/next-integrity (ab60368ab6a4 ima: Fallback to the builtin=
 hash algorithm)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (d141136f523a audit: normalize MAC_POLICY_LOAD record)
Merging tpmdd/next (33bfe29814bd tpm/st33zp24: Fix spelling mistake in macr=
o ST33ZP24_TISREGISTER_UKNOWN)
Merging watchdog/master (6d08b06e67cd Linux 4.17-rc2)
Merging iommu/next (d4f96fd5c249 Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos', 'arm/renesas', 'arm/s=
mmu' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (da9147140fe3 MAINTAINERS: vfio/platform: Update sub-main=
tainer)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (23bcc480dac2 audit: allow not equal op for audit by exe=
cutable)
Merging devicetree/for-next (c01d05ef0005 Merge branches 'dt/next' and 'dt/=
linus' into for-next)
Merging mailbox/mailbox-for-next (dfbc9c5841fc mailbox: Remove depends on H=
AS_DMA in case of platform dependency)
Merging spi/for-next (fd2c2d98e1b6 Merge branch 'spi-4.18' into spi-next)
Merging tip/auto-latest (2657134b9a40 Merge branch 'x86/cpu')
Merging clockevents/clockevents/next (0136c741ff40 clocksource/drivers/imx-=
tpm: Add different counter width support)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6fd052665274 EDAC, sb_edac: Remove variable leng=
th array usage)
Merging irqchip/irq/irqchip-next (aa08192a254d irqchip/gic: Take lock when =
updating irq type)
Merging ftrace/for-next (0b3dec05dbbc tracing: Enforce passing in filter=3D=
NULL to create_filter())
Merging rcu/rcu/next (248d0f34b437 Merge branches 'exp.2018.04.20a', 'fixes=
.2018.04.23b', 'lock.2018.04.22a' and 'torture.2018.04.20a' into HEAD)
Merging kvm/linux-next (c18bb396d3d2 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (dc6ed61d2f82 arm64: Add temporary ERRATA_MIDR_ALL_VER=
SIONS compatibility macro)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (31c8b0d0694a KVM: PPC: Book3S HV: Use __gfn_t=
o_pfn_memslot() in page fault handler)
Merging kvms390/next (ccc40c53c07b KVM: s390: provide counters for all inte=
rrupt injects/delivery)
Merging xen-tip/linux-next (eb0b4aa89cf2 x86/xen: Remove use of VLAs)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (1aa3798360db Merge branch 'for-4.17' into for-=
next)
Merging drivers-x86/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging chrome-platform/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (9e50d5fb0d18 leds: add LED driver for CR0014114 boar=
d)
Merging ipmi/for-next (1211229399b3 ipmi_ssif: Fix uninitialized variable i=
ssue)
Merging driver-core/driver-core-next (9ee84466b713 fs: kernfs: Adding new r=
eturn type vm_fault_t)
Merging usb/usb-next (3f0989e4d366 usb: core: hcd: mark expected switch fal=
l-through)
CONFLICT (content): Merge conflict in drivers/usb/core/hcd.c
Merging usb-gadget/next (60cc43fc8884 Linux 4.17-rc1)
Merging usb-serial/usb-next (86c225c1b2e0 USB: serial: option: blacklist un=
used dwm-158 interfaces)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (cd3bf368aa7a phy: Add a driver for the ATH79 USB phy)
Merging tty/tty-next (c1c734cb1f54 serial: core: Make sure compiler barfs f=
or 16-byte earlycon names)
Merging char-misc/char-misc-next (3eb87d4e5a93 char: mspec: change return t=
ype to vm_fault_t)
Merging extcon/extcon-next (60cc43fc8884 Linux 4.17-rc1)
Merging staging/staging-next (7cc6f682ca6f Revert "staging: nvec: Augment T=
ODO file with GPIO work item")
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (be20f0a8ebdf Merge branch 'topic/ti' into next)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (6980151fba2a Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (f990bee3f187 scsi: ips: fix firmware timestamps =
for 32-bit)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (fd17ed684b6e Revert "ata: ahci-platform: add reset=
 control support")
Merging vhost/linux-next (cfcde40e8ce3 ACPI: disable extra P_LVLx access on=
 KVM)
Merging rpmsg/for-next (d84cf4818962 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
$ git reset --hard HEAD^
Merging next-20180424 version of rpmsg
Merging gpio/for-next (348f3cde84ab gpio: Add Spreadtrum PMIC EIC driver su=
pport)
Merging pinctrl/for-next (4fc97ef94bbf pinctrl: uniphier: add UART hardware=
 flow control pin-mux settings)
Merging pinctrl-samsung/for-next (938a10bb4913 pinctrl: samsung: Document r=
equired order of banks)
Merging pwm/for-next (6873842235d6 pwm: rcar: Add suspend/resume support)
Merging userns/for-next (918101056590 signal/xtensa: Use force_sig_fault wh=
ere appropriate)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (60cc43fc8884 Linux 4.17-rc1)
Merging y2038/y2038 (5dc0b1529d21 y2038: ipc: Redirect ipc(SEMTIMEDOP, ...)=
 to compat_ksys_semtimedop)
Merging livepatching/for-next (3beed9bf1e3d Merge branch 'for-4.17/upstream=
-fixes' into for-next)
Merging coresight/next (53531a9947ed coresight: Moving framework and driver=
s to SPDX identifier)
Merging rtc/rtc-next (36d91a4d401c rtc: cmos: introduce quirks to enable us=
e_acpi_alarm mode)
Merging nvdimm/libnvdimm-for-next (c5794510d7b5 MAINTAINERS: Add backup mai=
ntainers for libnvdimm and DAX)
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (22e06c32b936 eeprom: at24: provide a separate r=
outine for creating dummy i2c clients)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (45888b40d2a6 rslib: Allocate decoder buffers to=
 avoid VLAs)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (e8ff6013dc39 exofs-avoid-vla-in-structures-v2)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: mm: use octal not symbolic permissions
Applying: treewide: use PHYS_ADDR_MAX to avoid type casting ULLONG_MAX
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (24dc823cc7e8 sparc64: NG4 memset 32 bits overflow)

--Sig_/SUt5xib0THceGj7I+IhrGnB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrhYT4ACgkQAVBC80lX
0GyiWAf/QkTgs46BFw1MnE9mJ6d3VVCbstyN2dkat+VlXNFIiJHQeDY1ufkvYLOI
TnjQ8E4hLYw23pATolF33T5XOBlExJTJA+bERBMgQaYJr2xs1Esfy5ySm5oX/enl
ksUv+wU6w1V4dahf9kU7zPK9lEBnuKZcBHpKtxbeGlt9xMvABWUh/bGR9zsSRy+X
DTkCswSQfGVsiy4D73ElCxtovV64KUKr3cd9DiVw5MCMlfoJXVnoOewe8Txi130E
1ev1/DE+wq715ntT0j8l3jj1UrUTWhw+LPtExXAbWLuKxO+jNbYvG4ugOqVMn0Qe
GN6fF/306imafxyePSy432SKcWbyLQ==
=8fMv
-----END PGP SIGNATURE-----

--Sig_/SUt5xib0THceGj7I+IhrGnB--
