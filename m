Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6CCC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423BC21773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058563;
	bh=LpSRrdXljYDfNi4DL/2QOlK3O1u+TIlAH/PnGdNyAVw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nG49k1TGzorLApSJ0ioVwAFm38FIim8lFFfyU/N0MIn03ESEL7NUGlvj2AHRh45FE
	 PXfRJ+eE9/8lRUNSUvIkgDB7G3+re8qZXMAtHq8ZtXVlY2WvVSeFwkf/SW+8eKcD0S
	 vmw3T8/8Zf8D3e4ptGteDjc8OsncfvfTbdBqt+jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfAIS3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfAIS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:29:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5949D20665;
        Wed,  9 Jan 2019 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547058560;
        bh=LpSRrdXljYDfNi4DL/2QOlK3O1u+TIlAH/PnGdNyAVw=;
        h=Date:From:To:Cc:Subject:From;
        b=oNOPHqE1E13B2k5dXmMWGsoH0+3b/C48i75iuoNnhRJmspy7xpLmpzAnYUQunixjg
         vh7yBy/w63mJ6M0dSPFy7MN/VOLkhP7boGSVtg5MK/gfJCFU+wc77znop8XoGV8jU0
         pnhaFwVI/zjME2g//tgO3dY4WUlUawxGCaRewb/Q=
Date:   Wed, 9 Jan 2019 19:29:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.14
Message-ID: <20190109182918.GA17500@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.14 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Aaro Koskinen (1):
      MIPS: OCTEON: mark RGMII interface disabled on OCTEON III

Adrian Hunter (4):
      perf machine: Record if a arch has a single user/kernel address space
      perf thread: Add fallback functions for cases where cpumode is insuff=
icient
      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf script: Use fallbacks for branch stacks

Alaa Hleihel (1):
      net/mlx5e: Remove the false indication of software timestamping suppo=
rt

Alexey Brodkin (1):
      clocksource/drivers/arc_timer: Utilize generic sched_clock

Allan W. Nielsen (1):
      mscc: Configured MAC entries should be locked.

Anand Jain (2):
      btrfs: dev-replace: go back to suspended state if target device is mi=
ssing
      btrfs: dev-replace: go back to suspend state if another EXCL_OP is ru=
nning

Antoine Tenart (2):
      net: mvpp2: 10G modes aren't supported on all ports
      net: mvpp2: fix the phylink mode validation

Arnaldo Carvalho de Melo (1):
      perf env: Also consider env->arch =3D=3D NULL as local operation

Arnd Bergmann (1):
      mtd: atmel-quadspi: disallow building on ebsa110

Atul Gupta (1):
      crypto: chcr - small packet Tx stalls the queue

Ben Hutchings (1):
      perf pmu: Suppress potential format-truncation warning

Boris Brezillon (1):
      mtd: rawnand: omap2: Pass the parent of pdev to dma_request_chan()

Breno Leitao (1):
      powerpc/tm: Unset MSR[TS] if not recheckpointing

Christoffer Dall (1):
      KVM: arm/arm64: vgic-v2: Set active_source to 0 when restoring state

Christophe JAILLET (1):
      net/ipv6: Fix a test against 'ipv6_find_idev()' return value

Claudiu Beznea (1):
      net: macb: restart tx after tx used bit read

Colin Ian King (1):
      staging: wilc1000: fix missing read_write setting when reading data

Cong Wang (11):
      ax25: fix a use-after-free in ax25_fillin_cb()
      ipv6: explicitly initialize udp6_addr in udp_sock_create6()
      netrom: fix locking in nr_find_socket()
      net/wan: fix a double free in x25_asy_open_tty()
      ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()
      tipc: check tsk->group in tipc_wait_for_cond()
      tipc: compare remote and local protocols in tipc_udp_enable()
      tipc: fix a double free in tipc_enable_bearer()
      tipc: fix a double kfree_skb()
      tipc: use lock_sock() in tipc_sk_reinit()
      tipc: check group dests after tipc_wait_for_cond()

Dan Carpenter (1):
      net: stmmac: Fix an error code in probe()

Dan Williams (2):
      x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_in=
it()
      dax: Use non-exclusive wait in wait_entry_unlocked()

Davide Caratti (1):
      net: Use __kernel_clockid_t in uapi net_stamp.h

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Diana Craciun (1):
      powerpc/fsl: Fix spectre_v2 mitigations reporting

Dmitry Eremin-Solenikov (2):
      crypto: testmgr - add AES-CFB tests
      crypto: cfb - fix decryption

Eric Anholt (1):
      drm/v3d: Skip debugfs dumping GCA on platforms without GCA.

Eric Dumazet (5):
      ipv6: tunnels: fix two use-after-free
      isdn: fix kernel-infoleak in capi_unlocked_ioctl
      net: clear skb->tstamp in forwarding paths
      net/hamradio/6pack: use mod_timer() to rearm timers
      tcp: fix a race in inet_diag_dump_icsk()

Eugeniy Paltsev (1):
      DRM: UDL: get rid of useless vblank initialization

Filipe Manana (2):
      Btrfs: fix fsync of files with multiple hard links in new directories
      Btrfs: send, fix race with transaction commits that create snapshots

Ganesh Goudar (1):
      net/tls: allocate tls context using GFP_ATOMIC

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Greg Kroah-Hartman (1):
      Linux 4.19.14

Greg Kurz (2):
      ocxl: Fix endiannes bug in ocxl_link_update_pe()
      ocxl: Fix endiannes bug in read_afu_name()

Gustavo A. R. Silva (7):
      ip6mr: Fix potential Spectre v1 vulnerability
      ipv4: Fix potential Spectre v1 vulnerability
      ALSA: rme9652: Fix potential Spectre v1 vulnerability
      ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
      ALSA: pcm: Fix potential Spectre v1 vulnerability
      ALSA: emux: Fix potential Spectre v1 vulnerabilities
      KVM: arm/arm64: vgic: Fix off-by-one bug in vgic_get_irq()

Hans Verkuil (5):
      media: cec: keep track of outstanding transmits
      media: cec-pin: fix broken tx_ignore_nack_until_eom error injection
      media: vivid: free bitmap_cap when updating std/timings/etc.
      media: vb2: check memory model for VIDIOC_CREATE_BUFS
      media: v4l2-tpg: array index could become negative

Hans de Goede (2):
      ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromeb=
ook Clapper
      ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromeb=
ook Gnawty

Heikki Krogerus (1):
      usb: roles: Add a description for the class to Kconfig

Heiner Kallweit (1):
      r8169: fix WoL device wakeup enable

Herbert Xu (1):
      ipv6: frags: Fix bogus skb->sk in reassembled packets

Huacai Chen (4):
      MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB
      MIPS: Fix a R10000_LLSC_WAR logic in atomic.h

Jaegeuk Kim (1):
      f2fs: sanity check of xattr entry size

Jason Wang (1):
      vhost: make sure used idx is seen before log in vhost_add_used_n()

Jernej Skrabec (1):
      clk: sunxi-ng: Use u64 for calculation of NM rate

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable the headset mic auto detection for ASUS lap=
tops

Johan Jonker (1):
      clk: rockchip: fix typo in rk3188 spdif_frac parent

Jorgen Hansen (1):
      VSOCK: Send reset control packet when socket is partially bound

Josef Bacik (1):
      btrfs: run delayed items before dropping the snapshot

Juergen Gross (1):
      xen/netfront: tolerate frags with no data

Julien Thierry (1):
      KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled

J=C3=B6rgen Storvist (4):
      qmi_wwan: Added support for Fibocom NL668 series
      qmi_wwan: Added support for Telit LN940 series
      qmi_wwan: Add support for Fibocom NL678 series
      USB: serial: option: add Fibocom NL678 series

Kunihiko Hayashi (1):
      net: phy: Fix the issue that netif always links up after resuming

Lorenzo Bianconi (1):
      gro_cell: add napi_disable in gro_cells_destroy

Lu Fengqi (1):
      btrfs: skip file_extent generation check for free_space_inode in run_=
delalloc_nocow

Luca Ceresoli (1):
      media: imx274: fix stack corruption in imx274_read_reg

Lukas Wunner (4):
      spi: bcm2835: Fix race on DMA termination
      spi: bcm2835: Fix book-keeping of DMA termination
      spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
      spi: bcm2835: Unbreak the build of esoteric configs

Lyude Paul (1):
      brcmfmac: Fix out of bounds memory access during fw load

Maciej W. Rozycki (1):
      rtc: m41t80: Correct alarm month range with RTC reads

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Malcolm Priestley (1):
      media: dvb-usb-v2: Fix incorrect use of transfer_flags URB_FREE_BUFFER

Mantas Mikul=C4=97nas (1):
      ALSA: hda: add mute LED support for HP EliteBook 840 G4

Marc Zyngier (3):
      arm64: KVM: Make VHE Stage-2 TLB invalidation operations non-interrup=
tible
      arm/arm64: KVM: vgic: Force VM halt when changing the active state of=
 GICv3 PPIs/SGIs
      KVM: arm/arm64: vgic: Cap SPIs to the VM-defined maximum

Marcin Wojtas (1):
      net: mvneta: fix operation for 64K PAGE_SIZE

Martin Blumenstingl (2):
      usb: dwc2: disable power_down on Amlogic devices
      f2fs: fix validation of the block count in sanity_check_raw_super

Matthew Wilcox (1):
      dax: Don't access a freed inode

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Michael J. Ruhl (1):
      IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Michal Hocko (1):
      x86/speculation/l1tf: Drop the swap storage limit restriction when l1=
tf=3Doff

Michal Kubecek (1):
      net: ipv4: do not handle duplicate fragments as overlapping

Mikhael Goikhman (1):
      net/mlx5e: Remove unused UDP GSO remaining counter

Miquel Raynal (2):
      mtd: rawnand: marvell: prevent timeouts on a loaded machine
      platform-msi: Free descriptors in platform_msi_domain_free()

Moshe Shemesh (1):
      net/mlx5e: RX, Verify MPWQE stride size is in range

Myungho Jung (1):
      net/smc: fix TCP fallback socket release

Nava kishore Manne (1):
      serial: uartps: Fix interrupt mask issue to handle the RX interrupts =
properly

Pan Bian (2):
      ext4: fix possible use after free in ext4_quota_enable
      f2fs: read page index before freeing

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Paul Aurich (1):
      smb3: fix large reads on encrypted connections

Paul Burton (3):
      MIPS: math-emu: Write-protect delay slot emulation pages
      MIPS: Expand MIPS32 ASIDs to 64 bits
      MIPS: Only include mmzone.h when CONFIG_NEED_MULTIPLE_NODES=3Dy

Pieter Jansen van Vuuren (1):
      nfp: flower: ensure TCP flags can be placed in IPv6 frame

Robin Murphy (1):
      iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes

Sameer Pujar (1):
      ALSA: hda/tegra: clear pending irq handlers

Sanjeev Chugh (1):
      Input: atmel_mxt_ts - don't try to free unallocated kernel memory

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (2):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup
      KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails

Sean Young (1):
      media: rc: cec devices do not have a lirc chardev

Sebastian Ott (1):
      s390/pci: fix sleeping in atomic during hotplug

Shalom Toledo (1):
      mlxsw: core: Increase timeout during firmware flash process

Stefano Brivio (1):
      ipv6: route: Fix return value of ip6_neigh_lookup() on neigh_create()=
 error

Stephan Gerhold (1):
      Revert "usb: dwc3: pci: Use devm functions to get the phy GPIOs"

Steven Rostedt (VMware) (1):
      tools lib traceevent: Fix processing of dereferenced args in bprintk =
events

Stijn Tintel (1):
      brcmfmac: fix roamoff=3D1 modparam

Sudarsana Reddy Kalluru (1):
      qed: Fix command number mismatch between driver and the mfw

Sylwester Nawrocki (1):
      ARM: dts: exynos: Specify I2S assigned clocks in proper node

Takashi Sakamoto (4):
      ALSA: fireface: fix for state to fetch PCM frames
      ALSA: firewire-lib: fix wrong handling payload_length as payload_quad=
let
      ALSA: firewire-lib: fix wrong assignment for 'out_packet_without_head=
er' tracepoint
      ALSA: firewire-lib: use the same print format for 'without_header' tr=
acepoints

Tal Gilboa (1):
      net/mlx5e: Cancel DIM work on close SQ

Tariq Toukan (1):
      net/mlx5e: RX, Fix wrong early return in receive queue poll

Tejun Heo (1):
      cgroup: fix CSS_TASK_ITER_PROCS

Terin Stock (1):
      usb: dwc2: host: use hrtimer for NAK retries

Theodore Ts'o (5):
      ext4: add ext4_sb_bread() to disambiguate ENOMEM cases
      ext4: include terminating u32 in size of xattr entries when expanding=
 inodes
      ext4: avoid declaring fs inconsistent due to invalid file handles
      ext4: force inode writes when nfsd calls commit_metadata()
      ext4: check for shutdown and r/o file system in ext4_write_inode()

Tomas Winkler (2):
      tpm: tpm_try_transmit() refactor error flow.
      tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Wandrille RONCE (1):
      ALSA: hda/realtek: Enable audio jacks of ASUS UX391UA with ALC294

Wenwen Wang (1):
      crypto: cavium/nitrox - fix a DMA pool free failure

Will Deacon (2):
      arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1
      arm64: compat: Avoid sending SIGILL for unallocated syscall numbers

Willem de Bruijn (4):
      ieee802154: lowpan_header_create check must check daddr
      ip: validate header length on virtual device xmit
      packet: validate address length
      packet: validate address length if non-zero

Xin Long (1):
      sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Yuval Avnery (1):
      net/mlx5: Typo fix in del_sw_hw_rule

ruippan (=E6=BD=98=E7=9D=BF) (1):
      ext4: fix EXT4_IOC_GROUP_ADD ioctl


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw2PX0ACgkQONu9yGCS
aT58zg/+M/wYGqj1yxs/9vnms6r4AjiwlL30VbragJqnuLGdUzeejMOiFj+iX5j0
0MtZvX1hNlOYDIlo9c8OMLeSMs4GcQqgk3HL0kDxNATsxmYGVYzeaKPChA3GdwuY
XJUBSAWamSyYEJoTEfDQA/Aqp2T+oO61nIR44EGxrWrldu6U1figgd1780rH1Y76
BhzP14YJ2pE7hk1TR5RGhUFTRCMLHEW60t0Hin22sZPJQ1VjoOFmoDhTAgoLb4uB
kqCxLRAENr1qaudq2SydFn8xMhRGc2Wdm//0/p4tAzmTy8Jq/RRs3ofdpy4B+qyt
jOJAQPqGUjwn3J+oiCzPqL6clCbt+Q8bT1FslskCjNStAlp1MrRgS6ql1mLgAEu7
80mPFYGV63IRi3yeFztr9YCnSojYTiT6L5tj1ywiGRzkjig+9kXTXXLxgrshE0iO
F8THsJCywLqhW33J9sthnOs/kAnznozPqamqRqlJ9DTvY395Tkkx0qJpiTsb3Wdx
wCYmLU1UBS3UFTuqoiEweFRs+6peov3nNSJEMw/tCum4dk58eXekYokZrd2Z/KrE
Dw+RyGy2xNqZM1Q/iTNlzyQxpC56XoeJyYQEae9v4bCvdfxCTZNZ1gHV4n7rS1AE
SvNkJXm9vxw0F4nX709lLJj+AJX44Ws3bxeaxQmiOBoahe3nsUY=
=upEW
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
