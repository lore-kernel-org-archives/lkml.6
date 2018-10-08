Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21240C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6362084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PYeqKZK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6362084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJHQXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:23:09 -0400
Received: from ozlabs.org ([203.11.71.1]:54915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeJHQXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:23:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TF4J6QRQz9sBh;
        Mon,  8 Oct 2018 20:12:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538989937;
        bh=CTmuCoplg5ZbsWa1w8iEoBFsgFe9U6SJ0yC/1t+WmSc=;
        h=Date:From:To:Cc:Subject:From;
        b=PYeqKZK8euE8g2fyIfpDqezPAxkNA5FG6CWwEuk2StrxR08/6y5mi0k3IGcFa4O3B
         97HYtA79LfTq8IdVP2ZmAn8HwzVUFE9QWvIR7wE6OCkvqtZGs+9zlMf+H3s+98knhw
         9qtDf2m2Qn+TyjUUs0oGFBtO7vdqGXPehwi9o6O4vK3W2GEgukMpEkkqGnMiHB0xfa
         9c28IW8kcGzFXjvBHcRpWWpTOnSjswccyClvHGXglb8mKLKufELRrm4kfWt8q3DNlZ
         cLspMr/+MjEvza0VbVBEzMb9FR6EdrbJ7I0ORoXe1CNUdJQGAndjkV1zyjJ3ePsuhU
         rIkYuLf93vHWA==
Date:   Mon, 8 Oct 2018 20:12:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 8
Message-ID: <20181008201216.601d3c02@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Yc/e=DWdc57CFQsBBl/Pb8l"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yc/e=DWdc57CFQsBBl/Pb8l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20181005:

New tree: compiler-attributes

The nfsd tree still had its build failure so I used the version from
next-20181004.

The rdma tree gained a conflict against the vfs tree.

The crypto tree gained a conflict against the compiler-attributes tree
and a build failure, so I used the version from next-20181005.

The drm-msm tree still had its build failure, so I used the version from
next-20181004.

The tip tree gained conflicts against the arm-soc and pm trees.

The irqchip tree gained a build failure so I used the version from
next-20181005.

The drivers-x86 tree gained conflicts against the tip tree.

The staging tree gained conflicts against the v4l-dvb tree.

The kspp tree gained a conflict against the tip tree.

The akpm-current tree gained conflicts against the compiler-attributes tree.

The akpm tree gained a conflict against the jc_docs tree and a build
failure due to an interaction with the tip tree for which I applied
a patch.

Non-merge commits (relative to Linus' tree): 8949
 8531 files changed, 396254 insertions(+), 182619 deletions(-)

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

I am currently merging 291 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (0238df646e62 Linux 4.19-rc7)
Merging fixes/master (72358c0b59b7 linux-next: build warnings from the buil=
d of Linus' tree)
Merging kbuild-current/fixes (ef8c4ed9db80 kbuild: allow to use GCC toolcha=
in not in Clang search path)
Merging arc-current/for-curr (c58a584f05e3 ARC: clone syscall to setp r25 a=
s thread pointer)
Merging arm-current/fixes (3a58ac65e2d7 ARM: 8799/1: mm: fix pci_ioremap_io=
() offset check)
Merging arm64-fixes/for-next/fixes (2a3f93459d68 arm64: KVM: Sanitize PSTAT=
E.M when being set from userspace)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (ac1788cc7da4 powerpc/numa: Skip onlining a off=
line node in kdump path)
Merging sparc/master (c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux=
/kernel/git/davem/net)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/davem/net)
Merging bpf/master (b799207e1e18 bpf: 32-bit RSH verification must truncate=
 input before the ALU op)
Merging ipsec/master (4da402597c2b xfrm: fix gro_cells leak when remove vir=
tual xfrm interfaces)
Merging netfilter/master (1ad98e9d1bdf tcp/dccp: fix lockdep issue when SYN=
 is backlogged)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (3baafeffa48a iwlwifi: 1000: set the TFD qu=
eue size)
Merging mac80211/master (1db585294547 cfg80211: fix use-after-free in reg_p=
rocess_hint())
Merging rdma-fixes/for-rc (5c5702e259dc RDMA/core: Set right entry state be=
fore releasing reference)
Merging sound-current/for-linus (709ae62e8e6d ALSA: hda/realtek - Cannot ad=
just speaker's volume on Dell XPS 27 7760)
Merging sound-asoc-fixes/for-linus (af6f398d13da Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (7876320f8880 Linux 4.19-rc4)
Merging regulator-fixes/for-linus (17b57b1883c1 Linux 4.19-rc6)
Merging spi-fixes/for-linus (17b57b1883c1 Linux 4.19-rc6)
Merging pci-current/for-linus (95375f2ab296 PCI: mvebu: Fix PCI I/O mapping=
 creation sequence)
Merging driver-core.current/driver-core-linus (7876320f8880 Linux 4.19-rc4)
Merging tty.current/tty-linus (5b162cc4ac27 Revert "serial: sh-sci: Allow f=
or compressed SCIF address")
Merging usb.current/usb-linus (555df5820e73 usb: xhci-mtk: resume USB3 root=
hub first)
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (0238df646e62 Linux 4.19-rc7)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (7876320f8880 Linux 4.19-rc4)
Merging char-misc.current/char-misc-linus (eafa717bc145 thunderbolt: Initia=
lize after IOMMUs)
Merging soundwire-fixes/fixes (8d6ccf5cebbc soundwire: Fix acquiring bus lo=
ck twice during master release)
Merging input-current/for-linus (cecf10704899 Input: uinput - add a schedul=
e point in uinput_inject_events())
Merging crypto-current/master (ba439a6cbfa2 crypto: qat - Fix KASAN stack-o=
ut-of-bounds bug in adf_probe())
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (ce01a1575f45 rseq/selftests: fix parametrize=
d test with -fpie)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (111b009f7e8b dmaengine: mic_x100_dma: use de=
vm_kzalloc to fix an issue)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (6bf4ca7fbc85 Linux 4.19-rc5)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (ad608fbcf166 media: v4l: event: Prevent freein=
g event subscriptions while accessed)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (148b9aba99e0 MIPS: memset: Fix CPU_DADDI_WOR=
KAROUNDS `small_fixup' regression)
Merging at91-fixes/at91-fixes (379e36d3f591 ARM: dts: at91: sama5d2_ptc_ek:=
 fix nand pinctrl)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (cc906f07d7d5 Merge tag 'kvm-ppc-fixes-4.19-3' of =
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-maste=
r)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (234b69e3e089 ocfs2: fix ocfs2 read block panic)
Merging nvdimm-fixes/libnvdimm-fixes (f52afc93cd01 dax: Fix deadlock in dax=
_lock_mapping_entry())
Merging btrfs-fixes/next-fixes (675c168b2b92 Merge branch 'misc-4.19' into =
next-fixes)
Merging vfs-fixes/fixes (b07581d2d5ad cachefiles: fix the race between cach=
efiles_bury_object() and rmdir(2))
Merging dma-mapping-fixes/for-linus (46bbeb69ff2f dma-mapping: add the miss=
ing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration)
Merging drivers-x86-fixes/fixes (6bf4ca7fbc85 Linux 4.19-rc5)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (e54192b48da7 of: fix phandle cache creat=
ion for DTs with no phandles)
Merging scsi-fixes/fixes (3cc5746e5ad7 scsi: qedi: Initialize the stats mut=
ex lock)
Merging drm-fixes/drm-fixes (bdf800c6fdf5 Merge branch 'drm-fixes-4.19' of =
git://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (4c9613ce556f drm/i915: Handle=
 incomplete Z_FINISH for compressed error states)
Merging mmc-fixes/fixes (1b09d9c232cd mmc: slot-gpio: Fix debounce time to =
use miliseconds again)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (064253c1c062 drm: fix use of f=
reed memory in drm_mode_setcrtc)
Merging kbuild/for-next (55b27e93208a Merge branch 'kbuild' into for-next)
Merging compiler-attributes/compiler-attributes (f0604f63033d Compiler Attr=
ibutes: ext4: remove local __nonstring definition)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (1fc8e6423edb dma-direct: fix return value of =
dma_direct_supported)
CONFLICT (content): Merge conflict in kernel/dma/Kconfig
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (6ff78af01049 Merge branches 'fixes', 'misc' and 'spec=
tre' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (5387ff1b8901 Merge branches 'fixes', 'next/dt' an=
d 'next/defconfig' into for-next)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (90133eb56b76 Merge branch 'v4.20/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (3368e06e2a91 ARM: dts: aspeed: Adding Facebook Tio=
gaPass BMC)
Merging at91/at91-next (128f53d05feb Merge branches 'at91-drivers', 'at91-s=
oc', 'at91-dt' and 'at91-defconfig' into at91-next)
Merging bcm2835/for-next (ca5b45b7c5cd Merge branch 'bcm2835-defconfig-next=
' into for-next)
Merging imx-mxs/for-next (56269494893a Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (42ac5fee3a13 Merge branch 'v4.19-next/soc' into =
for-next)
Merging mvebu/for-next (0f8a14a7cb8c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (b161216b621f Merge branch 'omap-for-v4.20/ti-sysc-ta=
ke2' into for-next)
Merging reset/reset/next (dbb3da346e80 reset: socfpga: add an early reset d=
river for SoCFPGA)
Merging qcom/for-next (6252f3298861 Merge tag 'qcom-arm64-defconfig-for-4.2=
0' into 4.20-tagged)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (2586035c01f6 Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-dt-for-v4.20', 'arm-soc-for-v4.20', 'arm64-dt-for-v4.20' and 'driver=
s-for-v4.20' into next)
Merging rockchip/for-next (ad1d7023f7c2 Merge branch 'v4.20-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (b9acde832ba8 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (25c5fc5a4923 Merge branch 'sunxi/h3-h5-for-4.=
20' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/allwinner/sun50i-=
h5.dtsi
CONFLICT (content): Merge conflict in arch/arm/boot/dts/sun8i-h3.dtsi
Merging tegra/for-next (22fed951fe3b Merge branch for-4.20/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (c20c650d9116 MAINTAINERS: fix bad sdei paths)
Merging clk/clk-next (488cd4a6db84 Merge branch 'clk-k3-tisci' into clk-nex=
t)
Merging clk-samsung/for-next (9dbcfe1ace4e dt-bindings: clock: samsung: Add=
 SPDX license identifiers)
Merging c6x/for-linux-next (929ba9300082 c6x: switch to NO_BOOTMEM)
Merging csky/linux-next (97238a67924b MAINTAINERS: Add csky)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (02b4da5f84d1 intel-iommu: mark intel_dma_ops static)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (da56cb950fb6 m68k: fix command-line parsing whe=
n passed from u-boot)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (2f0b649b3b4a MIPS: stop using _PTRS_PER_PGD)
Merging nds32/next (3350139c0ff3 nds32: linker script: GCOV kernel may refe=
rs data in __exit)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (2c18d35d677d parisc: Remove PTE load and fault =
check from L2_ptep macro)
Merging powerpc/next (d90fe2acd9b2 powerpc: Wire up memtest)
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (bd96461249bd powerpc/dts/fsl: t2080rdb: use the Cortina P=
HY driver compatible)
Merging risc-v/for-next (4a3041e3c244 automerging branch "kernel.org-palmer=
-linux/next-smp" into "for-next")
Merging s390/features (ccc413f62143 s390/qdio: clean up AOB handling)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (c9efd0d7beb3 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (33dc82dfd6e1 Merge branch 'for-next-next-v4.2=
0-20181003' into for-next-20181003)
Merging ceph/master (e92c0eaf7543 rbd: support cloning across namespaces)
Merging cifs/for-next (3ae6ac49259a cifs: minor clarification in comments)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (990f62ec34e7 Pull fanotify support for reporting PID=
 instead of TGID and other fsnotify cleanups.)
Merging ext4/dev (6c7d46439d0c docs: promote the ext4 data structures book =
to top level)
Merging f2fs/dev (6fe2fd437ef6 f2fs: allow to mount, if quota is failed)
Merging fuse/for-next (e52a8250480a fuse: realloc page array)
Merging jfs/jfs-next (1390643d1d5c jfs: remove redundant dquot_initialize()=
 in jfs_evict_inode())
Merging nfs/linux-next (44f411c353bf NFSv4.x: fix lock recovery during dele=
gation recall)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (619dd18b6f70 svcrdma: Increase the default connecti=
on credit limit)
Applying: svcrdma: fix up for recv_lock rename
$ git reset --hard HEAD^
Merging next-20181004 version of nfsd
Merging orangefs/for-next (a3bb1b184669 Orangefs: some error code paths mis=
sed kmem_cache_free to bad effect.)
Merging overlayfs/overlayfs-next (1a8f8d2a443e ovl: fix format of setxattr =
debug)
Merging ubifs/linux-next (f061c1cc404a Revert "ubifs: xattr: Don't operate =
on deleted inodes")
Merging v9fs/9p-next (76b600d46911 9p: potential NULL dereference)
Merging xfs/for-next (e55ec4ddbef9 xfs: fix error handling in xfs_bmap_exte=
nts_to_btree)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (f022b08a0a9b Merge branches 'work.mount', 'work.alpha=
' and 'work.compat' into for-next)
CONFLICT (content): Merge conflict in fs/f2fs/super.c
Applying: f2fs: update for MS_* flags mostly going away
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a6ae928c2583 Revert "printk: make sure to print lo=
g on console.")
Merging pci/next (73f3a5b3a519 Merge branch 'remotes/lorenzo/pci/tools')
Merging pstore/for-next/pstore (bac6f6cda206 pstore/ram: Fix failure-path m=
emory leak in ramoops_init)
Merging hid/for-next (4c2b9385b4d4 Merge branch 'for-4.20/logitech-highres'=
 into for-next)
Merging i2c/i2c/for-next (5ce8331f1a0c Merge branch 'i2c/for-4.20' into i2c=
/for-next)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (68eec4257bc7 hwmon: (core) Add hwmon_in_e=
nable attribute)
Merging jc_docs/docs-next (44ba0bb4f2ad docs: improve readability for peopl=
e with poorer eyesight)
Merging v4l-dvb/master (557c97b51336 media: cec: name for RC passthrough de=
vice does not need 'RC for')
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (7c968791f775 video/fbdev/stifb: Fix spelling =
mistake in fall-through annotation)
Merging pm/linux-next (c2c852100de9 Merge branches 'pm-cpuidle' and 'pm-dom=
ains' into linux-next)
Merging cpupower/cpupower (8a7e2d2ea080 cpupower: remove stringop-truncatio=
n waring)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (5ed4cecd75e9 OPP: Pass OPP table to _of_add_opp=
_table_v{1|2}())
Merging thermal/next (d7a4303b8d1f dt-bindings: thermal: Allow multiple dev=
ices to share cooling map)
Merging thermal-soc/next (152395fd03d4 thermal: of-thermal: disable passive=
 polling when thermal zone is disabled)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (ed7a01fd3fd7 RDMA/restrack: Release task struct whic=
h was hold by CM_ID object)
CONFLICT (content): Merge conflict in drivers/infiniband/core/cache.c
CONFLICT (content): Merge conflict in drivers/infiniband/Kconfig
Merging net-next/master (5057ef7f566d Merge tag 'wireless-drivers-next-for-=
davem-2018-10-07' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wi=
reless-drivers-next)
CONFLICT (modify/delete): Documentation/networking/00-INDEX deleted in HEAD=
 and modified in net-next/master. Version net-next/master of Documentation/=
networking/00-INDEX left in tree.
$ git rm -f Documentation/networking/00-INDEX
Merging bpf-next/master (df1ea77bc51d Merge branch 'bpf-xsk-fix-mixed-mode')
Merging ipsec-next/master (6140cc20caf7 Merge branch 'Support-of-Flow-Direc=
tor-in-HNS3-Ethernet-Driver-for-HiP08-Rev2-SoC')
Merging mlx5-next/mlx5-next (bd37197554eb net/mlx5: Update mlx5_ifc with DE=
VX UID bits)
Merging netfilter-next/master (e9837e55b020 netfilter: xt_quota: fix the be=
havior of xt_quota module)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (5057ef7f566d Merge tag 'wireless-driv=
ers-next-for-davem-2018-10-07' of git://git.kernel.org/pub/scm/linux/kernel=
/git/kvalo/wireless-drivers-next)
Merging bluetooth/master (3c89f1404396 Bluetooth: btsdio: Do not bind to no=
n-removable BCM43430)
Merging mac80211-next/master (5207ca554bfc cfg80211: sort tracing properly)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (b965053e0805 mtd: maps: gpio-addr-flash: Convert to g=
piod)
Merging nand/nand/next (5196d2e53251 mtd: rawnand: marvell: fix the IRQ han=
dler complete() condition)
Merging spi-nor/spi-nor/next (496c415717b8 mtd: spi-nor: fsl-quadspi: Don't=
 let -EINVAL on the bus)
Merging crypto/master (fd27b571c9f6 crypto: lrw - fix rebase error after ou=
t of bounds fix)
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
Applying: crypto: fixup for movement of __aligned_largest
$ git reset --hard HEAD^
Merging next-20181005 version of crypto
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
[master 12fe3d9b262c] next-20181005/crypto
Applying: crypto: fixup for movement of __aligned_largest
[master 213e9b833840] next-20181005/crypto
Merging drm/drm-next (c530174b90fa Merge branch 'for-upstream/mali-dp' of g=
it://linux-arm.org/linux-ld into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (98a9bce38b3d drm/i915: Avoid compiler war=
ning for maybe unused gu_misc_iir)
Merging drm-tegra/drm/tegra/for-next (5ac93f81096a drm/tegra: Detach device=
s from IOMMU DMA domain on arm32)
Merging drm-misc/for-linux-next (8c1d1bb0f0bd drm/imx: fix build failure wi=
thout CONFIG_DRM_FBDEV_EMULATION)
Merging drm-msm/msm-next (3ce36b4542b5 drm/msm/a6xx: Remove CP perfcounter =
selects from the protected list)
$ git reset --hard HEAD^
Merging next-20181004 version of drm-msm
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (5c41bb607125 gpu: ipu-v3: add support for XRG=
B32 and XBGR32 V4L2 pixel formats)
Merging etnaviv/etnaviv/next (1a866306e0fb drm/etnaviv: add DMA configurati=
on for etnaviv platform device)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (fadf3e019411 Merge remote-tracking branch 'regmap/=
topic/single-rw' into regmap-next)
Merging sound/for-next (d39f1d68fe1d ALSA: usb-audio: Add custom mixer stat=
us quirks for RME CC devices)
Merging sound-asoc/for-next (425071ffd3d0 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (dde274432110 Input: silead - try firmware reload after =
unsuccessful resume)
Merging block/for-next (2cab5e449a21 Merge branch 'for-4.20/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (5d07384a666d dm cache: fix resize crash if =
user doesn't reload cache table)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (741a46467b15 mmc: meson-mx-sdio: mark expected switch fal=
l-through)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (059421e041eb md: allow metadata updates while suspendi=
ng an array - fix)
Merging mfd/for-mfd-next (92d6ba4ff700 mfd: ti-lmu: constify mfd_cell table=
s)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (a4ac1f5ced58 power: reset: qcom-pon: Add pms405 p=
on support)
Merging regulator/for-next (a6645cf454d9 Merge remote-tracking branches 're=
gulator/topic/bd718xx' and 'regulator/topic/pfuze100' into regulator-next)
Merging security/next-testing (ad33b870a66b Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (250f2da49cb8 apparmor: Fix uninitialized va=
lue in aa_split_fqname)
Merging integrity/next-integrity (2a5817ba41c1 ima: fix showing large 'viol=
ations' or 'runtime_measurements_count')
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (4458bba09788 selinux: Add __GFP_NOWARN to allocation =
at str_read())
Merging tpmdd/next (e487a0f52301 tpm: Restore functionality to xen vtpm dri=
ver.)
Merging watchdog/master (59c66636aec7 MAINTAINERS: Fix file pattern for MEN=
 Z069 watchdog driver)
Merging iommu/next (f56735130b01 Merge branches 'iommu/fixes', 'arm/renesas=
', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (cf3f98c7f466 drivers/vfio: Allow type-1 IOMMU instantiat=
ion with all ARM/ARM64 IOMMUs)
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (57361846b52b Linux 4.19-rc2)
Merging devicetree/for-next (4355151de47c Merge branch 'all-dtbs' into dt/n=
ext)
CONFLICT (content): Merge conflict in drivers/soc/qcom/apr.c
CONFLICT (content): Merge conflict in arch/c6x/kernel/setup.c
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (4925720b58ef Merge remote-tracking branch 'spi/topic/=
of' into spi-next)
Merging tip/auto-latest (12a5f7fdd756 Merge branch 'x86/vdso')
CONFLICT (content): Merge conflict in drivers/powercap/intel_rapl.c
CONFLICT (content): Merge conflict in drivers/idle/intel_idle.c
CONFLICT (content): Merge conflict in MAINTAINERS
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (432de7fd7630 EDAC, {i7core,sb,skx}_edac: Fix unc=
orrected error counting)
Merging irqchip/irq/irqchip-next (b817ff5c9509 irqchip: Add driver for Cirr=
us Logic Madera codecs)
$ git reset --hard HEAD^
Merging next-20181005 version of irqchip
Merging ftrace/for-next (5a5e3d3ceae2 perf probe: Support SDT markers havin=
g reference counter (semaphore))
Merging rcu/rcu/next (0b1aba265b93 Merge LKMM and RCU branches)
Merging kvm/linux-next (dd5bd0a65ff6 Merge tag 'kvm-s390-next-4.20-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (fd2ef358282c KVM: arm/arm64: Ensure only THP is candi=
date for adjustment)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_mmu.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_arm.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
CONFLICT (content): Merge conflict in arch/arm/include/asm/kvm_mmu.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (46dec40fb741 KVM: PPC: Book3S HV: Don't trunc=
ate HPTE index in xlate function)
Merging kvms390/next (3b999a9b4881 Merge branch 'apv11' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next)
Merging xen-tip/linux-next (811e0345cfc1 xen/balloon: Grammar s/Is it/It is=
/)
Merging percpu/for-next (ad19ef010db1 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (5aa389aa29ce MAINTAINERS: intel_pmc_core: Upd=
ate MAINTAINERS)
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_mid_powerb=
tn.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_int0002_vg=
pio.c
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (2d00f35c55e7 leds: add Panasonic AN30259A support)
Merging ipmi/for-next (10042504ed92 ipmi:ssif: Add support for multi-part t=
ransmit messages > 2 parts)
Merging driver-core/driver-core-next (a75e78f21f9a kernfs: Fix range checks=
 in kernfs_get_target_path)
Merging usb/usb-next (3c168909002e usb: gadget: fix spelling mistakeis "[En=
]queing" -> "[En]queuing")
Merging usb-gadget/next (3b766f453557 USB: net2280: Remove ->disconnect() c=
allback from net2280_pullup())
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/usb=
/renesas_usb3.txt
Merging usb-serial/usb-next (17c42e34997a USB: serial: cypress_m8: remove s=
et but not used variable 'iflag')
Merging usb-chipidea-next/ci-for-usb-next (59739131e0ca usb: chipidea: Fix =
otg event handler)
Merging phy-next/next (566b388440bb phy: renesas: convert to SPDX identifie=
rs)
Merging tty/tty-next (8ebfe885c65e TTY: sn_console: Replace spin_is_locked(=
) with spin_trylock())
Merging char-misc/char-misc-next (8f523d6db7ed VMCI: remove set but not use=
d variable 'cid')
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (502c00d9c315 Documentation: soundwire: fix stream.r=
st markup warnings)
Merging staging/staging-next (e24c1f8658c9 staging: rtl8712: add SPDX ident=
ifiers)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-media-o=
f.c
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-media-d=
ev.c
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (modify/delete): Documentation/filesystems/00-INDEX deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of Doc=
umentation/filesystems/00-INDEX left in tree.
$ git rm -f Documentation/filesystems/00-INDEX
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging icc/icc-next (23ba90b47dfc interconnect: fix build error without DE=
BUGFS)
Merging slave-dma/next (4d61af299a1d Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (b4eb6bdca334 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging scsi/for-next (aae9872c8b72 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (ef801f07e7b3 scsi: qla2xxx: Return switch comman=
d on a timeout)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (56675ccc1860 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (2199498087d8 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (de0c18a87cfa pinctrl: msm: Actually use function =
0 for gpio selection)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (4ce5f9c9e754 signal: Use a smaller struct siginfo =
in the kernel)
CONFLICT (content): Merge conflict in kernel/signal.c
CONFLICT (content): Merge conflict in arch/x86/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (9c476a573870 selftests: gpio: Fix OUTPUT directory =
in Makefile)
CONFLICT (content): Merge conflict in tools/testing/selftests/gpio/Makefile
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (29c222d1a9f5 Merge 4.19-rc6)
Merging rtc/rtc-next (bc51098cdd95 rtc: cmos: Remove the `use_acpi_alarm' m=
odule parameter for !ACPI)
Merging nvdimm/libnvdimm-for-next (be5ba2ca053d dax: Fix use of zero page)
Merging at24/at24/for-next (9a9e295e7c5c eeprom: at24: fix unexpected timeo=
ut under high load)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (06c87b45ff65 Merge branch 'for-next/array_size'=
 into for-next/kspp)
CONFLICT (content): Merge conflict in drivers/misc/lkdtm/core.c
CONFLICT (content): Merge conflict in Documentation/x86/x86_64/mm.txt
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ff6401301656 Merge branch 'for-powerpc' into for-ne=
xt)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging xarray/xarray (f176eda90aeb radix tree: Remove multiorder support)
CONFLICT (content): Merge conflict in fs/f2fs/data.c
CONFLICT (content): Merge conflict in fs/dax.c
Merging akpm-current/current (c8494de588f3 lib/lz4: update LZ4 decompressor=
 module)
CONFLICT (content): Merge conflict in mm/workingset.c
CONFLICT (content): Merge conflict in mm/swap_state.c
CONFLICT (content): Merge conflict in kernel/memremap.c
CONFLICT (content): Merge conflict in include/linux/swap.h
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
CONFLICT (content): Merge conflict in include/linux/compiler-gcc.h
CONFLICT (content): Merge conflict in block/blk-iolatency.c
CONFLICT (content): Merge conflict in arch/hexagon/Kconfig
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: percpu: remove PER_CPU_DEF_ATTRIBUTES macro
Applying: mm: remove CONFIG_NO_BOOTMEM
Applying: mm: remove now defunct NO_BOOTMEM from depends list for deferred =
init
Applying: mm: remove CONFIG_HAVE_MEMBLOCK
Applying: of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config option
Applying: csky: fixups after bootmem removal
Applying: memblock: remove stale #else and the code it protects
Applying: mm: remove bootmem allocator implementation.
Applying: mm: nobootmem: remove dead code
Applying: memblock: rename memblock_alloc{_nid,_try_nid} to memblock_phys_a=
lloc*
Applying: memblock: remove _virt from APIs returning virtual address
Applying: memblock: replace alloc_bootmem_align with memblock_alloc
Applying: memblock: replace alloc_bootmem_low with memblock_alloc_low
Applying: memblock: replace __alloc_bootmem_node_nopanic with memblock_allo=
c_try_nid_nopanic
Applying: memblock: replace alloc_bootmem_pages_nopanic with memblock_alloc=
_nopanic
Applying: memblock: replace alloc_bootmem_low with memblock_alloc_low (2)
Applying: memblock: replace __alloc_bootmem_nopanic with memblock_alloc_fro=
m_nopanic
Applying: memblock: add align parameter to memblock_alloc_node()
Applying: memblock: replace alloc_bootmem_pages_node with memblock_alloc_no=
de
Applying: memblock: replace __alloc_bootmem_node with appropriate memblock_=
 API
Applying: memblock: replace alloc_bootmem_node with memblock_alloc_node
Applying: memblock: replace alloc_bootmem_low_pages with memblock_alloc_low
Applying: memblock: replace alloc_bootmem_pages with memblock_alloc
Applying: memblock: replace __alloc_bootmem with memblock_alloc_from
Applying: memblock: replace alloc_bootmem with memblock_alloc
Applying: mm: nobootmem: remove bootmem allocation APIs
Applying: memblock: replace free_bootmem{_node} with memblock_free
Applying: memblock: replace free_bootmem_late with memblock_free_late
Applying: memblock: rename free_all_bootmem to memblock_free_all
Applying: memblock: rename __free_pages_bootmem to memblock_free_pages
Applying: mm: remove nobootmem
Applying: memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
Applying: mm: remove include/linux/bootmem.h
Applying: dma-direct: fix up for the removal of linux/bootmem.h
Applying: powerpc: fix up for removal of linux/bootmem.h
Applying: docs/boot-time-mm: remove bootmem documentation
Applying: drivers/android/binder_alloc.c: replace vm_insert_page with vmf_i=
nsert_page
Applying: mm/memory_hotplug: make remove_memory() take the device_hotplug_l=
ock
Applying: mm/memory_hotplug: make add_memory() take the device_hotplug_lock
Applying: mm/memory_hotplug: fix online/offline_pages called w.o. mem_hotpl=
ug_lock
Applying: powerpc/powernv: hold device_hotplug_lock when calling device_onl=
ine()
Applying: powerpc/powernv: hold device_hotplug_lock when calling memtrace_o=
ffline_pages()
Applying: powerpc-powernv-hold-device_hotplug_lock-when-calling-memtrace_of=
fline_pages-v3
Applying: memory-hotplug.txt: add some details about locking internals
CONFLICT (content): Merge conflict in Documentation/admin-guide/mm/memory-h=
otplug.rst
Applying: mm: Fix warning in insert_pfn()
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (5230db0cecaa drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)
Applying: x86/kaslr, ACPI/NUMA: fix for linux/bootmem.h removal

--Sig_/Yc/e=DWdc57CFQsBBl/Pb8l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu7H3AACgkQAVBC80lX
0GyBKgf7BbzcPOtpnzQMf4WXEXyNV6frjxFBHFI96B2ZoZtYtxsjavgtiWjqZ0Tv
T0dk37YuBQy+xMp+laRkyV4z//b8R0U63Fb2OJfkqtTT1lThYq4R8Texk8jhOnUv
kl0L61U8KT0wV6B/rOqZNP9XqaB9G15KPefVp9KF/nTR3BnJioS41cKkQgq7+EmG
yGDSZ8fe4XKDpSXFe/hsbKFFqaEyPaqlEsAeWTEdcXTInqc6cG43n4BjhIrZMDpN
5pKlgp/YHApNshnRKZQlSjY5A4ep9m7KnjGIvI7Ugy2qSvreYyxVuGj/w9M9Oa9Z
TKV2GKYgglTkunwvqKlXQD84CLHQwA==
=U4e+
-----END PGP SIGNATURE-----

--Sig_/Yc/e=DWdc57CFQsBBl/Pb8l--
