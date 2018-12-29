Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E74A2176F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546088874;
	bh=d1qLFhfjDzB9t5Cnk0s1tAGdMqhXYlZyO7nTJ6/LdNE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EZ97q9eZA0AtK6/zWCv8B1eA5BK7NwK2UjVpJt3La5YitMizFqteFEUiMVNlnfRA5
	 RN0VJdOity+5lukjMMDQhZCh1UwmudE3Ag/Kzqcjjhue1YlGDPr9uw+/wIqyHjyg1D
	 ib1gpWJuyPkvtMF86QGLVjrCm1r87sxycTblW0dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeL2NHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeL2NHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:07:53 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D8A20873;
        Sat, 29 Dec 2018 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546088871;
        bh=d1qLFhfjDzB9t5Cnk0s1tAGdMqhXYlZyO7nTJ6/LdNE=;
        h=Date:From:To:Cc:Subject:From;
        b=XPA9KgZT56T3fz10lqIlIWkmtByIzNRJEBOLosHrsjUYcK3dXY/e7Kg/dMYxV0hrT
         WXYax2cwJxGKS865JVkoXs98FRSiMTJRZ5D8vRwzLyP5dxwBDNmN+UTJwzG9/TEOyy
         kwQYkkfG3Ewitejfk34M1rSZzlf9Oyv7SFur3gQk=
Date:   Sat, 29 Dec 2018 14:07:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.13
Message-ID: <20181229130744.GA15102@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.13 kernel.

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

 Makefile                                             |    2=20
 arch/arm/include/asm/pgtable-2level.h                |    2=20
 arch/m68k/include/asm/pgtable_mm.h                   |    4=20
 arch/microblaze/include/asm/pgtable.h                |    2=20
 arch/nds32/include/asm/pgtable.h                     |    2=20
 arch/parisc/include/asm/pgtable.h                    |    2=20
 arch/x86/entry/vdso/Makefile                         |    3=20
 arch/x86/include/asm/msr-index.h                     |    1=20
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c          |    4=20
 arch/x86/kernel/cpu/mtrr/if.c                        |    2=20
 arch/x86/kvm/vmx.c                                   |    2=20
 arch/x86/kvm/x86.c                                   |    4=20
 arch/x86/mm/pat.c                                    |   13 +
 drivers/gpio/gpio-max7301.c                          |   12 -
 drivers/gpio/gpiolib-acpi.c                          |  144 +++++++++++---=
-----
 drivers/gpu/drm/drm_ioctl.c                          |   10 +
 drivers/hv/vmbus_drv.c                               |   20 ++
 drivers/input/mouse/elantech.c                       |   18 ++
 drivers/media/i2c/ov5640.c                           |   17 +-
 drivers/mmc/core/mmc.c                               |   24 +--
 drivers/mmc/host/omap_hsmmc.c                        |   12 +
 drivers/net/usb/hso.c                                |   18 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c          |    9 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c        |   50 ++++++
 drivers/net/wireless/marvell/mwifiex/11n.c           |    5=20
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c |   96 ++++++------
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c      |    3=20
 drivers/net/wireless/realtek/rtlwifi/base.c          |    1=20
 drivers/scsi/sd.c                                    |   23 ++-
 drivers/usb/host/xhci-hub.c                          |    3=20
 drivers/usb/host/xhci.h                              |    4=20
 drivers/usb/serial/option.c                          |   16 +-
 fs/iomap.c                                           |    7=20
 fs/namei.c                                           |    3=20
 fs/proc/proc_sysctl.c                                |   13 -
 fs/ubifs/replay.c                                    |   37 ++++
 include/asm-generic/4level-fixup.h                   |    2=20
 include/asm-generic/5level-fixup.h                   |    2=20
 include/asm-generic/pgtable-nop4d-hack.h             |    2=20
 include/asm-generic/pgtable-nop4d.h                  |    2=20
 include/asm-generic/pgtable-nopmd.h                  |    2=20
 include/asm-generic/pgtable-nopud.h                  |    2=20
 include/asm-generic/pgtable.h                        |   16 ++
 include/linux/math64.h                               |    3=20
 include/linux/mm.h                                   |    8 +
 include/linux/t10-pi.h                               |    9 -
 include/net/xfrm.h                                   |    1=20
 kernel/futex.c                                       |   69 ++++++++-
 kernel/panic.c                                       |    6=20
 kernel/time/posix-timers.c                           |    5=20
 mm/huge_memory.c                                     |   20 +-
 mm/page_alloc.c                                      |   19 ++
 mm/vmscan.c                                          |    6=20
 net/xfrm/xfrm_state.c                                |    8 -
 net/xfrm/xfrm_user.c                                 |    4=20
 55 files changed, 555 insertions(+), 219 deletions(-)

Alistair Strachan (1):
      x86/vdso: Pass --eh-frame-hdr to the linker

Benjamin Tissoires (1):
      Input: elantech - disable elan-i2c for P52 and P72

Brian Norris (1):
      Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

Cfir Cohen (1):
      KVM: Fix UAF in nested posted interrupt processing

Christian Brauner (1):
      Revert "vfs: Allow userns root to call mknod on owned filesystems."

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Colin Ian King (1):
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Dan Williams (1):
      x86/mm: Fix decoy address handling vs 32-bit builds

Dave Chinner (1):
      iomap: Revert "fs/iomap.c: get/put the page in iomap_page_create/rele=
ase()"

Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Eduardo Habkost (1):
      kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs

Emmanuel Grumbach (1):
      iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT to old firmwares

Greg Kroah-Hartman (1):
      Linux 4.19.13

Gustavo A. R. Silva (1):
      drm/ioctl: Fix Spectre v1 vulnerabilities

Hans de Goede (1):
      gpiolib-acpi: Only defer request_irq for GpioInt ACPI event handlers

Hui Peng (1):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Ihab Zhaika (1):
      iwlwifi: add new cards for 9560, 9462, 9461 and killer series

Ivan Delalande (1):
      proc/sysctl: don't return ENOMEM on lookup when a table is unregister=
ing

Jacopo Mondi (1):
      media: ov5640: Fix set format regression

Jens Axboe (1):
      scsi: sd: use mempool for discard special page

J=F6rgen Storvist (4):
      USB: serial: option: add GosunCn ZTE WeLink ME3630
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
      USB: serial: option: add Fibocom NL668 series
      USB: serial: option: add Telit LN940 series

Larry Finger (1):
      rtlwifi: Fix leak of skb when processing C2H_BT_INFO

Martin K. Petersen (1):
      scsi: t10-pi: Return correct ref tag when queue has no integrity prof=
ile

Martin Schwidefsky (3):
      mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
      mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
      mm: introduce mm_[p4d|pud|pmd]_folded

Mathias Krause (1):
      xfrm_user: fix freeing of xfrm states on acquire

Mathias Nyman (1):
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3=
 only

Mikhail Zaslonko (1):
      mm, memory_hotplug: initialize struct pages for the full memory secti=
on

Nicolas Saenz Julienne (1):
      USB: xhci: fix 'broken_suspend' placement in struct xchi_hcd

Oscar Salvador (1):
      mm, page_alloc: fix has_unmovable_pages for HugePages

Peter Xu (1):
      mm: thp: fix flags for pmd migration when split

Reinette Chatre (1):
      x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-lo=
cking sequence

Richard Weinberger (1):
      ubifs: Handle re-linking of inodes correctly while recovery

Roman Gushchin (1):
      mm: don't miss the last page because of round-off error

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers

Thomas Gleixner (2):
      posix-timers: Fix division by zero bug
      futex: Cure exit race

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Ulf Hansson (3):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs
      mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

Wanpeng Li (1):
      KVM: X86: Fix NULL deref in vcpu_scan_ioapic


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwncZ0ACgkQONu9yGCS
aT5tqRAAkVrues4h9YbQEqhsDpp5y2yVB5RPg8fZ85ol6ueBQZP0KiZfwKPRgxjM
wQjecjwc9lxLinH4y7onNpniyrWUfFG2KddahgJNQvCzyFu4K5S2hqmkMRo5TMnl
e0R6Tb5LJ9S6hrz3WKOKaN5qARvT9fjVaBb2DAC3UyLzioC2PIjNQrZCh+0hw7pq
5UU1hiYlun64eleAM0ZaCTXjx5VdVxRyrlxtMrWToM2vg8mE+D7u3mlY32ZdNHT+
HPKFZ1YfLCshdbDpDAtneQCIRUVMeucLi5GQdwp0un/U8pEI4Gtyq3bNRX5yP8hE
bw1tOw5mR2dzsDsU3fXiwd2cRalH0P16LAhWe+inQ0sZW+tFIK+O867LHEUgJEX9
JrMsy3zOIXqXocYyPpm7W5aVtkOHyMVeKgCLekxnTEfQhlnqnEC1zFMCQamXCtc4
dE4FP5viO90+ufD8lybjICK0Bc40CFO/3s3/eZgRvydhLyPM/TxUU3XTvp9Q9gRJ
CoUobtM35mM1YAigI9BjDAHGgAQzy8ZJOH8GC/WnI4RktLNPJzCsricneMvCISJQ
oaFEQ4iLvbHouMRqztE+7zD01+N4bh3Y8IKVQhYRYkUFi7cfhGfE37AHoJjmVc2G
gaTulhftAEMJD4dAd51JLGTunP3oNLipnmmIWqBo+CS2dpv5LXE=
=vc6F
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
