Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C76C282DB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BA8218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548938748;
	bh=bK2t1moljDaAbPME77crk+j7cXvCPua5VdkC7y2m5rI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Zh4SZDkIBSoT5yio+gi44gwOdJv2ThpM/ol0Px3HxpF67N1KWeqwiLxchXGHc9AKO
	 TRPYCeB6WTKagrBbPu085n5E8oBWl3wsycLZilzB966NiU2P5HIGapDWwItmZA/X8w
	 dX7slSEQZtiPjTkd9Z8XyUp/ShXOfr0SqRizasfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfAaMpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732916AbfAaMpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:45:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799BC218AF;
        Thu, 31 Jan 2019 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548938743;
        bh=bK2t1moljDaAbPME77crk+j7cXvCPua5VdkC7y2m5rI=;
        h=Date:From:To:Cc:Subject:From;
        b=EbkOqdjqmiSwV56zlVuue/+DGRoPnCJdWZMDQW5AN4I+uhV/qwTq58Vrlf+EhIsj6
         gFbFTXuoMBb5PRvdVfbLSy8HRsfA5m8NA6xqpYFymgDXvP3R6MLEg6EIn+OIQKFPXp
         uWhH+MgfC/PZc4qzDgTYw3n4aoKWrn01vVBfCWtw=
Date:   Thu, 31 Jan 2019 13:45:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.19
Message-ID: <20190131124540.GA7773@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.19 kernel.

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

 Makefile                                           |    2=20
 arch/arc/include/asm/perf_event.h                  |    3=20
 arch/arc/lib/memset-archs.S                        |   40 +
 arch/arc/mm/init.c                                 |    3=20
 arch/s390/include/asm/mmu_context.h                |    5=20
 arch/s390/kernel/early.c                           |    4=20
 arch/s390/kernel/setup.c                           |    2=20
 arch/s390/kernel/smp.c                             |   12=20
 arch/x86/entry/entry_64_compat.S                   |    6=20
 arch/x86/include/asm/mmu_context.h                 |   18=20
 arch/x86/kernel/kvm.c                              |    7=20
 arch/x86/kvm/vmx.c                                 |   14=20
 arch/x86/kvm/x86.c                                 |    5=20
 arch/x86/lib/kaslr.c                               |    4=20
 drivers/acpi/nfit/core.c                           |   61 ++
 drivers/char/mwave/mwavedd.c                       |    7=20
 drivers/clk/socfpga/clk-pll-s10.c                  |    2=20
 drivers/clk/socfpga/clk-s10.c                      |   20=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    1=20
 drivers/gpu/drm/meson/meson_crtc.c                 |   23 -
 drivers/gpu/drm/meson/meson_drv.c                  |    5=20
 drivers/hv/hv_balloon.c                            |   10=20
 drivers/hv/ring_buffer.c                           |   31 -
 drivers/hv/vmbus_drv.c                             |   91 ++--
 drivers/ide/ide-proc.c                             |    2=20
 drivers/input/joystick/xpad.c                      |    3=20
 drivers/input/misc/uinput.c                        |    5=20
 drivers/irqchip/irq-gic-v3-its.c                   |   25 -
 drivers/md/dm-crypt.c                              |   25 -
 drivers/md/dm-thin-metadata.c                      |    4=20
 drivers/md/dm-thin-metadata.h                      |    2=20
 drivers/md/dm-thin.c                               |   10=20
 drivers/misc/ibmvmc.c                              |    7=20
 drivers/misc/mei/hw-me-regs.h                      |    2=20
 drivers/misc/mei/pci-me.c                          |    4=20
 drivers/mmc/host/dw_mmc-bluefield.c                |    5=20
 drivers/mmc/host/meson-gx-mmc.c                    |   18=20
 drivers/net/can/dev.c                              |   27 -
 drivers/net/can/flexcan.c                          |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |   22=20
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   12=20
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h       |    3=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |    4=20
 drivers/net/ethernet/sun/cassini.c                 |   15=20
 drivers/net/ethernet/sun/cassini.h                 |   15=20
 drivers/net/phy/marvell.c                          |   37 +
 drivers/net/phy/mdio_bus.c                         |    1=20
 drivers/net/ppp/pppoe.c                            |    1=20
 drivers/nvme/target/rdma.c                         |   17=20
 drivers/s390/char/sclp_config.c                    |    2=20
 drivers/scsi/ufs/ufshcd.c                          |   10=20
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |    1=20
 drivers/tty/n_hdlc.c                               |    1=20
 drivers/tty/serial/serial_core.c                   |   12=20
 drivers/tty/tty_io.c                               |    3=20
 drivers/tty/vt/vt.c                                |   50 --
 drivers/usb/core/ledtrig-usbport.c                 |   17=20
 drivers/usb/dwc3/gadget.c                          |    2=20
 drivers/usb/serial/pl2303.c                        |    1=20
 drivers/usb/serial/pl2303.h                        |    2=20
 drivers/usb/serial/usb-serial-simple.c             |    3=20
 drivers/vhost/net.c                                |    3=20
 drivers/vhost/vhost.c                              |   97 +++-
 drivers/vhost/vhost.h                              |    3=20
 drivers/video/console/vgacon.c                     |    7=20
 fs/ceph/caps.c                                     |    2=20
 fs/cifs/cifssmb.c                                  |   35 +
 fs/cifs/connect.c                                  |   21=20
 fs/cifs/smb2misc.c                                 |    7=20
 fs/cifs/smb2ops.c                                  |   62 +-
 fs/notify/inotify/inotify_user.c                   |    6=20
 include/linux/bpf_verifier.h                       |   13=20
 include/linux/filter.h                             |   10=20
 include/linux/hyperv.h                             |    5=20
 include/linux/skbuff.h                             |    1=20
 include/net/ip_fib.h                               |    2=20
 include/uapi/linux/input.h                         |    6=20
 kernel/bpf/core.c                                  |   54 +-
 kernel/bpf/map_in_map.c                            |   17=20
 kernel/bpf/verifier.c                              |  470 ++++++++++++++++=
+----
 kernel/time/posix-cpu-timers.c                     |    1=20
 mm/page_alloc.c                                    |   12=20
 net/bridge/br_forward.c                            |    9=20
 net/bridge/br_netfilter_ipv6.c                     |    1=20
 net/bridge/netfilter/nft_reject_bridge.c           |    1=20
 net/can/bcm.c                                      |   27 +
 net/ipv4/fib_frontend.c                            |    4=20
 net/ipv4/fib_trie.c                                |   15=20
 net/ipv4/ip_gre.c                                  |   23 -
 net/ipv4/ip_input.c                                |    1=20
 net/ipv4/tcp.c                                     |    2=20
 net/ipv4/udp.c                                     |   16=20
 net/ipv6/ip6_gre.c                                 |   14=20
 net/ipv6/udp.c                                     |   16=20
 net/openvswitch/flow_netlink.c                     |    2=20
 net/sched/act_tunnel_key.c                         |   19=20
 net/sched/cls_api.c                                |    3=20
 net/sched/cls_flower.c                             |   19=20
 sound/pci/hda/patch_conexant.c                     |    1=20
 sound/pci/hda/patch_realtek.c                      |    2=20
 sound/soc/codecs/rt5514-spi.c                      |    2=20
 sound/soc/codecs/tlv320aic32x4.c                   |    4=20
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    8=20
 tools/testing/selftests/x86/protection_keys.c      |   41 +
 105 files changed, 1299 insertions(+), 515 deletions(-)

Alex Deucher (1):
      drm/amdgpu: Add APTX quirk for Lenovo laptop

Alexander Popov (1):
      KVM: x86: Fix single-step debugging

Alexander Usyskin (1):
      mei: me: mark LBG devices as having dma support

Alexei Starovoitov (2):
      bpf: improve verifier branch analysis
      bpf: add per-insn complexity limit

Andrew Lunn (2):
      net: phy: marvell: Errata for mv88e6390 internal PHYs
      net: phy: marvell: Fix deadlock from wrong locking

Anthony Wong (1):
      ALSA: hda - Add mute LED support for HP ProBook 470 G5

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Christian Borntraeger (1):
      s390/early: improve machine detection

Christian Lamparter (1):
      USB: leds: fix regression in usbport led trigger

Christoph Hellwig (1):
      ide: fix a typo in the settings proc file name

Cong Wang (1):
      net_sched: refetch skb protocol for each filter

Dan Williams (2):
      acpi/nfit: Block function zero DSMs
      acpi/nfit: Fix command-supported detection

Daniel Borkmann (10):
      bpf: move {prev_,}insn_idx into verifier env
      bpf: move tmp variable into ax register in interpreter
      bpf: enable access to ax register also from verifier rewrite
      bpf: restrict map value pointer arithmetic for unprivileged
      bpf: restrict stack pointer arithmetic for unprivileged
      bpf: restrict unknown scalars of mixed signed bounds for unprivileged
      bpf: fix check_map_access smin_value test when pointer contains offset
      bpf: prevent out of bounds speculation on pointer arithmetic
      bpf: fix sanitation of alu op with pointer / scalar type from differe=
nt paths
      bpf: fix inner map masking to prevent oob under speculation

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Hansen (2):
      x86/pkeys: Properly copy pkey state at fork()
      x86/selftests/pkeys: Fork() to check for state being preserved

David Hildenbrand (1):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Davide Caratti (1):
      net/sched: act_tunnel_key: fix memory leak in case of action replace

Deepa Dinamani (2):
      Input: input_event - provide override for sparc64
      Input: input_event - fix the CONFIG_SPARC64 mixup

Dexuan Cui (1):
      Drivers: hv: vmbus: Check for ring when getting debug info

Dinh Nguyen (2):
      clk: socfpga: stratix10: fix rate calculation for pll clocks
      clk: socfpga: stratix10: fix naming convention for the fixed-clocks

Dmitry Torokhov (1):
      Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Eugeniy Paltsev (3):
      ARCv2: lib: memeset: fix doing prefetchw outside of buffer
      ARC: adjust memblock_reserve of kernel memory
      ARC: perf: map generic branches to correct hardware condition

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Greg Kroah-Hartman (2):
      tty: Handle problem if line discipline does not have receive_buf
      Linux 4.19.19

Gustavo A. R. Silva (3):
      ASoC: rt5514-spi: Fix potential NULL pointer dereference
      misc: ibmvsm: Fix potential NULL pointer dereference
      char/mwave: fix potential Spectre v1 vulnerability

Hangbin Liu (1):
      ip6_gre: update version related info when changing link

Ido Schimmel (2):
      net: ipv4: Fix memory leak in network namespace dismantle
      mlxsw: pci: Ring CQ's doorbell before RDQ's

Israel Rukshin (1):
      nvmet-rdma: Add unlikely for response allocated check

Ivan Vecera (1):
      net/sched: cls_flower: allocate mask dynamically in fl_change()

Jack Pham (1):
      usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup

Jan Beulich (1):
      x86/entry/64/compat: Fix stack switching for XEN PV

Jason Wang (1):
      vhost: log dirty page correctly

Joe Thornber (1):
      dm thin: fix passdown_double_checking_shared_status()

Kailang Yang (1):
      ALSA: hda/realtek - Fix typo for ALC225 model

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

KarimAllah Ahmed (1):
      KVM/nVMX: Do not validate that posted_intr_desc_addr is page aligned

Lendacky, Thomas (1):
      amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs

Liming Sun (1):
      mmc: dw_mmc-bluefield: : Fix the license information

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb=
 by removing it

Marc Gonzalez (1):
      scsi: ufs: Use explicit access size in ufshcd_dump_regs

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Martin Schwidefsky (1):
      s390/mm: always force a load of the primary ASCE on context switch

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Michal Hocko (1):
      Revert "mm, memory_hotplug: initialize struct pages for the full memo=
ry section"

Milan Broz (1):
      dm crypt: fix parsing of extended IV arguments

Neil Armstrong (1):
      drm/meson: Fix atomic mode switching regression

Nicolas Pitre (4):
      vgacon: unconfuse vc_origin when using soft scrollback
      vt: make vt_console_print() compatible with the unicode screen buffer
      vt: always call notifier with the console lock held
      vt: invoke notifier on screen size change

Nir Dotan (2):
      mlxsw: pci: Increase PCI SW reset timeout
      mlxsw: spectrum_fid: Update dummy FID index

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Olivier Matz (1):
      ip6_gre: fix tunnel list corruption for x-netns

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Pavel Shilovsky (4):
      CIFS: Fix possible hang during async MTU reads and writes
      CIFS: Fix credits calculations for reads with errors
      CIFS: Fix credit calculation for encrypted reads with errors
      CIFS: Do not reconnect TCP session in add_credits()

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Remi Pommarel (1):
      mmc: meson-gx: Free irq in release() callback

Ronnie Sahlberg (1):
      smb3: add credits we receive from oplock/break PDUs

Ross Lagerwall (2):
      net: Fix usage of pskb_trim_rcsum
      openvswitch: Avoid OOB read when parsing flow nlattrs

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char

Sean Christopherson (2):
      KVM: x86: Fix PV IPIs for 32-bit KVM host
      KVM: x86: WARN_ONCE if sending a PV IPI returns a fatal error

Tetsuo Handa (1):
      inotify: Fix fd refcount leak in inotify_add_watch().

Thomas Gleixner (2):
      posix-cpu-timers: Unbreak timer rearming
      net: sun: cassini: Cleanup license conflict

Thomas Petazzoni (1):
      net: phy: mdio_bus: add missing device_del() in mdiobus_register() er=
ror handling

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Tom Roeder (1):
      kvm: x86/vmx: Use kzalloc for cached_vmcs12

Tomas Winkler (1):
      mei: me: add denverton innovation engine device IDs

Uwe Kleine-K=F6nig (1):
      can: flexcan: fix NULL pointer exception during bringup

Vitaly Kuznetsov (1):
      hv_balloon: avoid touching uninitialized struct page during tail onli=
ning

Willem de Bruijn (2):
      udp: with udp_segment release on error path
      tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state

Xin Long (1):
      erspan: build the header with the right proto according to erspan_ver

Yan, Zheng (1):
      ceph: clear inode pointer when snap realm gets dropped by its inode

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable

b-ak (1):
      ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxS7fQACgkQONu9yGCS
aT6BzA/8CKgZIUSUsZGdR3ZAJ9g1EuZGPmscccmLWrZv8vbiFCN6BnmKOv+YMiE1
EXY1+USpd3bC6sK3gmfBnCWvNXZanfvheFa17d+1krGo/JLIrJ4eyldK/Wrg3VnZ
ORf7/FjvmlcnmE+x8A00oSoNZ9fD5TdavHD8PDqPxJ5lxEuYxcN8zIcoOfygIQ4c
mgikBpvtbc2lBfX2n5m6CrjfVdnOjQt8dUyRGLZ4I1QxmERDUxlwpoG77FdyBtsY
x3AX/BVwJYvdE2SsgdMp/EJg12v1eBp82UjZkbn9x3h6V34vGokt7qjoMCznZV9u
xhUcREvH3zIcIaPc9Hoqg+kcBea5piZ2THhucVxmI/2j2UknQ8YkJh4OaeFMYN0c
jHhkx4oRwRpzWxXg+Qwj51J9xiIheLfACJcKG0TdpXC2bgKTMKao1oSaI/EFZWEb
i2roDt2qsySkhNTYDt/FWNXWTErV+zT0SfgPlcYb12kOnc3Puwf3hQ9VGiNdQ+bt
OzV9wnJb6Se4STwuqqZ+Frk1oC7ptHjs2PZttJt+UDUXZujqhH0O6n6PY94QnSP4
TJXQHLsJmnzBim/IyswAc4VeqYrXCb7r8Lxs0pVw2u0Whj/8BmBqaAIno2iVo8eG
I1PCOd4rYJ3AZuNp74/SCy9wfZPmcmZb9bNhtjqKUoWnieTUpjA=
=ZWzQ
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
