Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E3FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36402086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548938728;
	bh=ub3Zg6hZWdCh3UNFR+kunxApyC5axUq8ydQmSzpD+0A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r4zIxeYKT+0z+LmgWvusdpidvwTuIkqTB0t6J7ORnW+avfjkdPxiILFz6KI6khTnL
	 Dc7gGpCgHrn03JG56hmVx+xljs6sc2Y5tTonPmiupJRY6R4EaUrlx7Poj2/h5g2qML
	 gTRvZR7JRX1ZV5tkj9y1HmKTW7xX5nioqo+P98fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfAaMp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732916AbfAaMpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:45:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4512086C;
        Thu, 31 Jan 2019 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548938723;
        bh=ub3Zg6hZWdCh3UNFR+kunxApyC5axUq8ydQmSzpD+0A=;
        h=Date:From:To:Cc:Subject:From;
        b=t2uuNnKZt/c6vQjyPPwXN5v5uMbCsQK9UTpk0YFJ0OHdYD9p9XrVmqOOLIRtvfr2O
         wZhU6pQwLhMKtODSBPL/5Ap4AJLxRSmpoG3JnQfISKN/4S3UdG5UQmIHePHn68RBzr
         jTNKTalL92YyhOkWc3r5wGaDyifuZejXdVlLHIiU=
Date:   Thu, 31 Jan 2019 13:45:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.97
Message-ID: <20190131124521.GA7672@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.97 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/arc/include/asm/perf_event.h                 |    3=20
 arch/arc/lib/memset-archs.S                       |   40 +++-
 arch/arc/mm/init.c                                |    3=20
 arch/s390/kernel/early.c                          |    4=20
 arch/s390/kernel/setup.c                          |    2=20
 arch/s390/kernel/smp.c                            |   12 +
 arch/x86/entry/vdso/vma.c                         |    2=20
 arch/x86/include/asm/mmu_context.h                |   18 +
 arch/x86/include/asm/pvclock.h                    |   19 +-
 arch/x86/kernel/kvmclock.c                        |    7=20
 arch/x86/kernel/pvclock.c                         |   14 +
 arch/x86/kvm/x86.c                                |    9=20
 arch/x86/lib/kaslr.c                              |    4=20
 arch/x86/xen/suspend.c                            |    4=20
 arch/x86/xen/time.c                               |  118 ++++++++++++
 arch/x86/xen/xen-ops.h                            |    2=20
 drivers/acpi/nfit/core.c                          |   61 +++++-
 drivers/char/mwave/mwavedd.c                      |    7=20
 drivers/hv/hv_balloon.c                           |   10 -
 drivers/hv/ring_buffer.c                          |   31 +--
 drivers/hv/vmbus_drv.c                            |   91 ++++++---
 drivers/input/joystick/xpad.c                     |    3=20
 drivers/input/misc/uinput.c                       |    5=20
 drivers/irqchip/irq-gic-v3-its.c                  |   25 +-
 drivers/md/dm-crypt.c                             |   25 +-
 drivers/md/dm-thin-metadata.c                     |    4=20
 drivers/md/dm-thin-metadata.h                     |    2=20
 drivers/md/dm-thin.c                              |   10 -
 drivers/misc/mei/hw-me-regs.h                     |    2=20
 drivers/misc/mei/pci-me.c                         |    2=20
 drivers/mmc/host/Kconfig                          |    1=20
 drivers/net/can/dev.c                             |   27 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h       |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c          |   22 +-
 drivers/net/ethernet/stmicro/stmmac/common.h      |    3=20
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   15 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   22 ++
 drivers/net/phy/mdio_bus.c                        |    1=20
 drivers/net/ppp/pppoe.c                           |    1=20
 drivers/nvme/target/rdma.c                        |   17 +
 drivers/ptp/ptp_kvm.c                             |    5=20
 drivers/s390/char/sclp_config.c                   |    2=20
 drivers/staging/rtl8188eu/os_dep/usb_intf.c       |    1=20
 drivers/tty/n_hdlc.c                              |    1=20
 drivers/tty/serial/serial_core.c                  |   12 -
 drivers/tty/tty_io.c                              |    3=20
 drivers/tty/vt/vt.c                               |    1=20
 drivers/usb/dwc3/gadget.c                         |    2=20
 drivers/usb/host/xhci-mtk.c                       |    6=20
 drivers/usb/host/xhci-pci.c                       |    1=20
 drivers/usb/host/xhci-plat.c                      |    6=20
 drivers/usb/host/xhci-tegra.c                     |    1=20
 drivers/usb/host/xhci.c                           |    2=20
 drivers/usb/serial/pl2303.c                       |    1=20
 drivers/usb/serial/pl2303.h                       |    2=20
 drivers/usb/serial/usb-serial-simple.c            |    3=20
 drivers/vhost/net.c                               |    3=20
 drivers/vhost/vhost.c                             |   97 ++++++++--
 drivers/vhost/vhost.h                             |    3=20
 drivers/xen/events/events_base.c                  |    2=20
 fs/btrfs/dev-replace.c                            |    9=20
 fs/cifs/cifssmb.c                                 |   35 ++-
 fs/cifs/connect.c                                 |   21 ++
 fs/cifs/smb2ops.c                                 |   62 ++++--
 fs/f2fs/node.c                                    |    4=20
 include/linux/compiler-clang.h                    |   14 +
 include/linux/compiler-gcc.h                      |    4=20
 include/linux/compiler-intel.h                    |    4=20
 include/linux/hyperv.h                            |    5=20
 include/linux/overflow.h                          |  205 +++++++++++++++++=
+++++
 include/linux/skbuff.h                            |    1=20
 include/net/ip_fib.h                              |    2=20
 include/xen/interface/vcpu.h                      |   42 ++++
 kernel/time/posix-cpu-timers.c                    |    1=20
 net/bridge/br_forward.c                           |    9=20
 net/bridge/br_netfilter_ipv6.c                    |    1=20
 net/bridge/netfilter/nft_reject_bridge.c          |    1=20
 net/can/bcm.c                                     |   27 ++
 net/ipv4/fib_frontend.c                           |    4=20
 net/ipv4/fib_trie.c                               |   15 +
 net/ipv4/inet_fragment.c                          |    2=20
 net/ipv4/ip_input.c                               |    1=20
 net/ipv4/tcp.c                                    |    2=20
 net/openvswitch/flow_netlink.c                    |    2=20
 net/sched/cls_api.c                               |    3=20
 sound/pci/hda/patch_conexant.c                    |    1=20
 sound/soc/codecs/rt5514-spi.c                     |    2=20
 sound/soc/intel/atom/sst-mfld-platform-pcm.c      |    8=20
 tools/perf/util/unwind-libdw.c                    |    4=20
 tools/testing/selftests/seccomp/seccomp_bpf.c     |   61 ------
 tools/testing/selftests/x86/protection_keys.c     |   41 +++-
 92 files changed, 1072 insertions(+), 327 deletions(-)

Alexander Popov (1):
      KVM: x86: Fix single-step debugging

Anand Jain (1):
      btrfs: dev-replace: go back to suspended state if target device is mi=
ssing

Anthony Wong (1):
      ALSA: hda - Add mute LED support for HP ProBook 470 G5

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Christian Borntraeger (1):
      s390/early: improve machine detection

Cong Wang (1):
      net_sched: refetch skb protocol for each filter

Dan Williams (2):
      acpi/nfit: Block function zero DSMs
      acpi/nfit: Fix command-supported detection

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Hansen (2):
      x86/pkeys: Properly copy pkey state at fork()
      x86/selftests/pkeys: Fork() to check for state being preserved

David Hildenbrand (1):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Dexuan Cui (1):
      Drivers: hv: vmbus: Check for ring when getting debug info

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
      Linux 4.14.97

Gustavo A. R. Silva (2):
      ASoC: rt5514-spi: Fix potential NULL pointer dereference
      char/mwave: fix potential Spectre v1 vulnerability

Ido Schimmel (1):
      net: ipv4: Fix memory leak in network namespace dismantle

Israel Rukshin (1):
      nvmet-rdma: Add unlikely for response allocated check

Jack Pham (1):
      usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup

Jason Wang (1):
      vhost: log dirty page correctly

Jeff Mahoney (1):
      btrfs: fix error handling in btrfs_dev_replace_start

Joao Martins (4):
      ptp_kvm: probe for kvm guest availability
      x86/pvclock: add setter for pvclock_pvti_cpu0_va
      x86/xen/time: set pvclock flags on xen_time_init()
      x86/xen/time: setup vcpu 0 time info page

Joe Thornber (1):
      dm thin: fix passdown_double_checking_shared_status()

Jose Abreu (1):
      net: stmmac: Use correct values in TQS/RQS fields

Juergen Gross (1):
      xen: Fix x86 sched_clock() interface for xen

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Lendacky, Thomas (1):
      amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb=
 by removing it

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Martin Vuille (1):
      perf unwind: Unwind with libdw doesn't take symfs into account

Mathias Nyman (1):
      xhci: Fix leaking USB3 shared_hcd at xhci removal

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Milan Broz (1):
      dm crypt: fix parsing of extended IV arguments

Milian Wolff (1):
      perf unwind: Take pgoff into account when reporting elf to libdwfl

Nicolas Pitre (1):
      vt: invoke notifier on screen size change

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Pan Bian (1):
      f2fs: read page index before freeing

Paolo Abeni (1):
      ipfrag: really prevent allocation on netns exit

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Pavel Shilovsky (4):
      CIFS: Fix possible hang during async MTU reads and writes
      CIFS: Fix credits calculations for reads with errors
      CIFS: Fix credit calculation for encrypted reads with errors
      CIFS: Do not reconnect TCP session in add_credits()

Pavel Tatashin (1):
      x86/xen/time: Output xen sched_clock time from 0

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Rasmus Villemoes (1):
      compiler.h: enable builtin overflow checkers and add fallback code

Ross Lagerwall (2):
      net: Fix usage of pskb_trim_rcsum
      openvswitch: Avoid OOB read when parsing flow nlattrs

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char

Sasha Levin (1):
      Revert "seccomp: add a selftest for get_metadata"

Sean Christopherson (1):
      KVM: x86: Fix a 4.14 backport regression related to userspace/guest F=
PU

Thomas Gleixner (1):
      posix-cpu-timers: Unbreak timer rearming

Thomas Petazzoni (1):
      net: phy: mdio_bus: add missing device_del() in mdiobus_register() er=
ror handling

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Tomas Winkler (1):
      mei: me: add denverton innovation engine device IDs

Vijay Viswanath (1):
      mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS

Vitaly Kuznetsov (1):
      hv_balloon: avoid touching uninitialized struct page during tail onli=
ning

Willem de Bruijn (1):
      tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxS7eEACgkQONu9yGCS
aT6t+Q//XVreLEfmRfEiZqRgIgHtQmpgeXJs99F4ytgVM5kCehP2hLACGVDZq5yF
Q3dS1ujhghlErSOt4B0ZVhj7Bfb+16D4dBriZ3M1IeF/ecahXW9/NrHf98LYgvwa
CsDxW6T5PMuzWq7uCiHoV6CQ8I+GtcgdxPQWa69Fu+GhB7Ipo5qnLp0SCN0/sIGd
u2XLNOv4LlvKqJhwodHyGpGpb/g9BzFBhkLkT0jE4WqcPzp679ziRb4QvlL+bd74
xoSbPT18NX0q+Ve1TNf5h3nU5qVSFxrTmaePnElmctfTg6MyB+R3bulned01asps
f2uyxhtPhvPTFWgEUoWcQRye2bD84rTnDpy44RoSmgeH4KKOgH5ec1GTvjBChrm5
fIiLCU/mlVbwW5O87qjgQGCbbx/MZa/0vLyJz4N2pIPLMpkZtWCyyVgqMdWipQd5
ZGND1JolDeNvvBDH3Rr7dCUT0SoBo2DzhzRXSNeNnwjWyL0PlqN/6y/bYsJFj3ea
488MOHKudTfjwkVHYFSWaoPWlFuB8xg2PW2K+tOtztNHDULvb5YS+OsM848VM1JD
Ix2bJUbznfIjXxffBLwB6q2KgSCjj1qYO84Wk6HRt2S79whN1mDl8n9np/MoTdS3
WI517rsjFXUxT4JlgvJ0W6iEyE3LzzpibWArfCt/WiCcwdCkCNM=
=qHuX
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
