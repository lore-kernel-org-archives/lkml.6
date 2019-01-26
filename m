Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647AC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B60218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548495058;
	bh=tlwh9yf6BAnUrN6E7I6j1u7yTL2d2pc2xNS4Cy2JoDA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ajg3MFIKGZ42NFxaZ0qRW5SGOZ+s0z2zcMYreaGDC4V8D7yto/rkSwpaaf8GyG9nP
	 EVpEOJrkbK380e3NPkxhIffhlM70dMAc5TWpBMOBe+wjfEjTu+MU0fYZNnE0xcqQ8Z
	 IE1qsUX6QXkY/jZpWsEV78uwUJ04u02VBGpWUYmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfAZJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfAZJa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:30:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F1D218F0;
        Sat, 26 Jan 2019 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548495054;
        bh=tlwh9yf6BAnUrN6E7I6j1u7yTL2d2pc2xNS4Cy2JoDA=;
        h=Date:From:To:Cc:Subject:From;
        b=fNlHMEfen5SKodRCoFp2EWhC1YFWb7RVoHb1uKQin19qz8i3LDtQv+m5WAH6Z32UP
         ZAiHeOt7DuzapqYeudyYZd5QI/ulLeK+XMgtvY3USAGFR/cHLWhQOFfUYWdFRLIBMh
         YOnJHTH0CZMIKKXAIXxOMJk3i5ZgFW88HkJNW/s8=
Date:   Sat, 26 Jan 2019 10:30:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.96
Message-ID: <20190126093052.GA23651@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.96 kernel.

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

 Documentation/filesystems/proc.txt                       |    4=20
 Makefile                                                 |    2=20
 arch/arm64/include/asm/assembler.h                       |   30 ++-
 arch/arm64/kernel/perf_event.c                           |    1=20
 arch/arm64/mm/cache.S                                    |    3=20
 arch/mips/Kconfig                                        |    3=20
 arch/mips/sibyte/common/Makefile                         |    1=20
 arch/mips/sibyte/common/dma.c                            |   14 +
 arch/powerpc/xmon/xmon.c                                 |   18 +-
 arch/x86/include/asm/traps.h                             |    6=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c                     |    5=20
 arch/x86/kernel/cpu/mcheck/therm_throt.c                 |    3=20
 arch/x86/kernel/cpu/mcheck/threshold.c                   |    3=20
 drivers/base/bus.c                                       |    7=20
 drivers/char/ipmi/ipmi_si_intf.c                         |   12 +
 drivers/char/ipmi/ipmi_ssif.c                            |   25 ++-
 drivers/clk/imx/clk-busy.c                               |    2=20
 drivers/clk/imx/clk-fixup-mux.c                          |    2=20
 drivers/clk/imx/clk-imx6q.c                              |    6=20
 drivers/clk/imx/clk.h                                    |   18 +-
 drivers/clocksource/timer-integrator-ap.c                |   25 ++-
 drivers/cpuidle/cpuidle-pseries.c                        |    8 -
 drivers/gpio/gpio-pl061.c                                |   21 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                         |   21 ++
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c             |   11 -
 drivers/infiniband/sw/rxe/rxe_req.c                      |    1=20
 drivers/md/dm-crypt.c                                    |    6=20
 drivers/md/dm-kcopyd.c                                   |   19 +-
 drivers/md/dm-snap.c                                     |   22 ++
 drivers/media/firewire/firedtv-avc.c                     |    6=20
 drivers/media/firewire/firedtv.h                         |    6=20
 drivers/media/platform/qcom/venus/core.c                 |    8 +
 drivers/mmc/host/atmel-mci.c                             |    3=20
 drivers/net/dsa/mv88e6xxx/chip.c                         |  113 ++++++++++=
+++++
 drivers/net/dsa/mv88e6xxx/chip.h                         |    5=20
 drivers/net/dsa/mv88e6xxx/port.h                         |   10 +
 drivers/net/ethernet/intel/e1000e/ptp.c                  |   13 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c           |    7=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    2=20
 drivers/net/ethernet/realtek/r8169.c                     |    2=20
 drivers/net/usb/qmi_wwan.c                               |    1=20
 drivers/pci/dwc/pcie-designware-host.c                   |   15 +
 drivers/platform/x86/asus-wmi.c                          |    3=20
 drivers/scsi/megaraid/megaraid_sas_fp.c                  |    2=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c              |    2=20
 drivers/scsi/smartpqi/smartpqi_init.c                    |    4=20
 drivers/target/target_core_spc.c                         |   17 +-
 drivers/tty/serial/amba-pl011.c                          |    2=20
 drivers/tty/serial/pic32_uart.c                          |    1=20
 drivers/tty/serial/serial_core.c                         |   22 ++
 drivers/tty/serial/xilinx_uartps.c                       |    1=20
 drivers/usb/gadget/udc/renesas_usb3.c                    |   15 +
 fs/btrfs/inode.c                                         |    7=20
 fs/cifs/Kconfig                                          |   17 ++
 fs/cifs/connect.c                                        |    9 +
 fs/jffs2/super.c                                         |    3=20
 fs/nfs/client.c                                          |   11 +
 fs/nfs/nfs4client.c                                      |   17 +-
 fs/ocfs2/localalloc.c                                    |    9 -
 fs/pstore/ram_core.c                                     |    5=20
 fs/quota/quota.c                                         |    3=20
 include/linux/backing-dev-defs.h                         |    8 +
 include/linux/swap.h                                     |   11 +
 mm/page-writeback.c                                      |   35 ++--
 mm/swapfile.c                                            |    3=20
 net/core/skbuff.c                                        |    7=20
 net/core/sock.c                                          |    1=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                       |    3=20
 net/ipv6/af_inet6.c                                      |   14 +
 scripts/kconfig/zconf.l                                  |    4=20
 security/selinux/hooks.c                                 |    2=20
 sound/firewire/Kconfig                                   |    1=20
 sound/firewire/bebob/bebob.c                             |    2=20
 sound/firewire/oxfw/oxfw.c                               |    8 +
 tools/lib/subcmd/Makefile                                |    2=20
 tools/perf/arch/x86/util/intel-pt.c                      |   11 +
 tools/perf/util/parse-events.c                           |    2=20
 tools/perf/util/svghelper.c                              |    2=20
 tools/testing/selftests/kselftest_harness.h              |   42 ++---
 79 files changed, 623 insertions(+), 175 deletions(-)

A.s. Dong (1):
      clk: imx: make mux parent strings const

Aaron Lu (1):
      mm/swap: use nr_node_ids for avail_lists in swap_info_struct

Adrian Hunter (1):
      perf intel-pt: Fix error with config term "pt=3D0"

AliOS system security (1):
      dm crypt: use u64 instead of sector_t to store iv_offset

Anders Roxell (3):
      writeback: don't decrement wb->refcnt if !wb->bdi
      serial: set suppress_bind_attrs flag only if builtin
      arm64: perf: set suppress_bind_attrs flag to true

Andrew Lunn (1):
      net: dsa: mv88x6xxx: mv88e6390 errata

Arnaldo Carvalho de Melo (3):
      perf svghelper: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()
      tools lib subcmd: Don't add the kernel sources to the include path

Borislav Petkov (1):
      x86/mce: Fix -Wmissing-prototypes warnings

Breno Leitao (2):
      powerpc/xmon: Fix invocation inside lock region
      powerpc/pseries/cpuidle: Fix preempt warning

Brian Foster (1):
      mm/page-writeback.c: don't break integrity writeback on ->writepage()=
 error

Chuck Lever (1):
      rxe: IB_WR_REG_MR does not capture MR's iova field

Corey Minyard (2):
      ipmi:pci: Blacklist a Realtek "IPMI" device
      ipmi:ssif: Fix handling of multi-part return messages

Daniel Santos (1):
      jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Daniel Vetter (1):
      sysfs: Disable lockdep for driver bind/unbind files

Daniele Palmas (1):
      qmi_wwan: add MTU default to qmap network interface

David Ahern (2):
      ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped a=
ddress
      ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Disseldorp (1):
      scsi: target: use consistent left-aligned ASCII INQUIRY data

David Rientjes (1):
      net, skbuff: do not prefer skb allocation fails early

Dmitry V. Levin (1):
      selftests: do not macro-expand failed assertion expressions

Greg Kroah-Hartman (1):
      Linux 4.14.96

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Set PVID correctly during VLAN deletion

Javier Barrio (1):
      quota: Lock s_umount in exclusive mode for Q_XQUOTA{ON,OFF} quotactls.

Jiri Pirko (1):
      mlxsw: spectrum: Disable lag port TX before removing it

Joel Fernandes (Google) (1):
      pstore/ram: Do not treat empty buffers as valid

Johannes Thumshirn (1):
      btrfs: improve error handling of btrfs_add_link

Jonas Danielsson (1):
      mmc: atmel-mci: do not assume idle after atmci_request_end

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Tell the EC the OS will handle the display of=
f hotkey

Junxiao Bi (1):
      ocfs2: fix panic due to unrecovered local alloc

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Kevin Barnett (1):
      scsi: smartpqi: correct lun reset issues

Lucas Stach (1):
      clk: imx6q: reset exclusive gates on init

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Manivannan Sadhasivam (1):
      gpio: pl061: Move irq_chip definition inside struct pl061

Marc Zyngier (1):
      PCI: dwc: Move interrupt acking into the proper callback

Masahiro Yamada (2):
      kconfig: fix file name and line number of warn_ignored_character()
      kconfig: fix memory leak when EOF is encountered in quotation

Michal Hocko (1):
      mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/sma=
ps

Miroslav Lichvar (1):
      e1000e: allow non-monotonic SYSTIM readings

Nathan Chancellor (1):
      media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Nikos Tsironis (2):
      dm kcopyd: Fix bug causing workqueue stalls
      dm snapshot: Fix excessive memory usage and workqueue stalls

Ondrej Mosnacek (1):
      selinux: always allow mounting submounts

Parvi Kaustubhi (1):
      IB/usnic: Fix potential deadlock

Qian Cai (1):
      scsi: megaraid: fix out-of-bound array accesses

Scott Mayhew (1):
      nfs: fix a deadlock in nfs client initialization

Sergey Senozhatsky (1):
      tty/serial: do not free trasnmit buffer page under port lock

Steve French (1):
      cifs: allow disabling insecure dialects in the config

Taehee Yoo (1):
      netfilter: ipt_CLUSTERIP: check MAC address when duplicate config is =
set

Takashi Sakamoto (2):
      ALSA: oxfw: add support for APOGEE duet FireWire
      ALSA: bebob: fix model-id of unit for Apogee Ensemble

Vivek Gautam (1):
      media: venus: core: Set dma maximum segment size

Will Deacon (1):
      arm64: Fix minor issues with the dcache_by_line_op macro

Yangtao Li (1):
      clocksource/drivers/integrator-ap: Add missing of_node_put()

Yanjiang Jin (1):
      scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: add a safety connection way for force=
d_b_device

Zhenyu Wang (1):
      drm/i915/gvt: Fix mmap range check

yupeng (1):
      net: call sk_dst_reset when set SO_DONTROUTE


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxMKMwACgkQONu9yGCS
aT7oQBAAo9beg99cHhJ/opIuoURSARJRJsj8gL71NROq0ZUZ1WMNu7gKUujrBz0G
41wMPTLHPeLVaBjEwk2LrZ8QmJZ0aoYG90WwHaw+SPUljwPyaXHi8hUu6UXCbGr1
YtsP89RLUuFmtrvNhPBMcTFJi9il8v6T4BQ0sO9GtJBMcbty6cUMRphrxhfGlhVp
SvKSsXGfZ6UAg0x1g6O8pPJDq04TW/QM5ifHTFzkqkZmA9e8ep2VN45AtkMaA66e
na9ZpBXCGxA2/w/5zFbzFRP8B9i/KIMsBI3dogTzCQxuXe7PK3bBQURuXeKU0gs2
Q8GJ4yeRulfe3st/lNwxhI/u3cxLByb1B4yJqm4IetW0Q3y/QH8bEoKmTqDs/MCy
ELh9F9tUJN4TnJvQCuvdMJ90SVTcxNBKROpNbLuoPC5w38ZZwdk2eCgRnIHu78Qa
bkAHDC2oDec9Wpc8oAzVc1FnwiQGD9R9l8a4ZgvHSQy8CvFn3AXYlVIiUkYFeMiA
cOMjYmaA0adPIYdFiLb1HaGdv0vj63KLEeJqtdXc3sUAf74Tpr511hUrLAmcuzJD
RpithP4JKLd7vetJ6exrA0xr2MxUJFSdIXMsPUv6i+kFyNPZq3iM/9At0YSnRbC7
hp1BJVaHf85oFw8GAdp+gfdXBDRYoEzTc+2loCK9/y2YAN/LRzA=
=WeNf
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
