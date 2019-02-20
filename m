Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BDEC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51832089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656534;
	bh=IUznv9Xguv21hRk6nOIHMLK1UB/qhXcECxboyZFkuK0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pos2lzj4tJ4nZz4rdivxfEBglE8bjuVMHOqxwuN+pocT4KYW8ie130o17BotmFYMw
	 h+G1ip4fwbfVU1OSVq1/sUAl+7tXV/mvMP26NaXrTPfMW3v+N+rmLYsfLd1stmeVmu
	 gRFfF1n2eDdLmQ+qEXhzLGR8W9qtFamI9yXT5kbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBTJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfBTJzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:55:33 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B5F2089F;
        Wed, 20 Feb 2019 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656531;
        bh=IUznv9Xguv21hRk6nOIHMLK1UB/qhXcECxboyZFkuK0=;
        h=Date:From:To:Cc:Subject:From;
        b=hibP/pe1GLeDchZFZLq98XqS3QRGtQePZkjFrI6pt6Gcj1gX49KGOsPjCwSiKBvhQ
         BaPC62whcWFUcK8VCl9d/TM48mY7jNAt1uJOMNzxlTOzcigVP3H3Uf6Mc7gkRVboiu
         62ZlFZap2c/N8UWq+/TArIHNh/cAggXVEyFuoSMA=
Date:   Wed, 20 Feb 2019 10:55:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.159
Message-ID: <20190220095527.GA15084@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.159 kernel.

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

 Documentation/devicetree/bindings/eeprom/eeprom.txt |    5 -
 Makefile                                            |    2=20
 arch/alpha/include/asm/irq.h                        |    6 -
 arch/alpha/mm/fault.c                               |    2=20
 arch/arm/boot/dts/da850-evm.dts                     |    2=20
 arch/arm/boot/dts/da850-lcdk.dts                    |    2=20
 arch/arm/boot/dts/kirkwood-dnskw.dtsi               |    4 -
 arch/arm/include/asm/assembler.h                    |   11 +++
 arch/arm/include/asm/cputype.h                      |    1=20
 arch/arm/include/asm/proc-fns.h                     |   61 ++++++++++++++-=
--
 arch/arm/include/asm/thread_info.h                  |    4 -
 arch/arm/include/asm/uaccess.h                      |   49 ++++++++++++--
 arch/arm/kernel/bugs.c                              |    4 -
 arch/arm/kernel/head-common.S                       |    6 -
 arch/arm/kernel/setup.c                             |   40 +++++++----
 arch/arm/kernel/signal.c                            |   70 ++++++++++-----=
-----
 arch/arm/kernel/smp.c                               |   32 +++++++++
 arch/arm/kernel/sys_oabi-compat.c                   |    8 +-
 arch/arm/lib/copy_from_user.S                       |    6 -
 arch/arm/lib/copy_to_user.S                         |    6 +
 arch/arm/lib/uaccess_with_memcpy.c                  |    3=20
 arch/arm/mach-integrator/impd1.c                    |    6 +
 arch/arm/mm/proc-macros.S                           |   10 ++
 arch/arm/mm/proc-v7-bugs.c                          |   17 ----
 arch/arm/vfp/vfpmodule.c                            |   20 ++---
 arch/x86/events/core.c                              |   14 ++++
 arch/x86/events/intel/core.c                        |    9 ++
 arch/x86/events/perf_event.h                        |   16 ++++
 arch/x86/ia32/ia32_aout.c                           |    6 +
 arch/x86/include/asm/uv/bios.h                      |    8 ++
 arch/x86/kvm/vmx.c                                  |    3=20
 arch/x86/platform/uv/bios_uv.c                      |   23 ++++++
 drivers/acpi/numa.c                                 |    6 -
 drivers/cpufreq/cpufreq.c                           |    7 --
 drivers/firmware/efi/runtime-wrappers.c             |    7 ++
 drivers/gpu/drm/bridge/tc358767.c                   |   41 +++++++++--
 drivers/gpu/drm/i915/i915_gem.c                     |   12 +++
 drivers/input/misc/bma150.c                         |    9 +-
 drivers/input/mouse/elan_i2c_core.c                 |    2=20
 drivers/input/mouse/elantech.c                      |    9 ++
 drivers/md/dm-thin.c                                |   55 ++++++++++++++-
 drivers/misc/eeprom/Kconfig                         |    2=20
 drivers/misc/eeprom/at24.c                          |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c    |   18 +++++
 drivers/net/usb/ch9200.c                            |    9 --
 drivers/net/usb/kaweth.c                            |   18 +----
 drivers/net/usb/smsc95xx.c                          |   12 +--
 drivers/pinctrl/qcom/pinctrl-msm.c                  |   23 +++++-
 drivers/scsi/aic94xx/aic94xx_init.c                 |    8 +-
 drivers/usb/dwc2/hcd.c                              |    1=20
 fs/cifs/file.c                                      |    8 ++
 fs/cifs/smb2file.c                                  |    4 +
 include/linux/perf_event.h                          |    5 +
 include/linux/skbuff.h                              |   16 ++++
 include/net/netfilter/nf_tables.h                   |   29 ++++++++
 include/uapi/linux/if_ether.h                       |    7 ++
 kernel/events/core.c                                |   16 ++++
 kernel/events/ring_buffer.c                         |    2=20
 kernel/signal.c                                     |    7 +-
 kernel/trace/trace_uprobe.c                         |    9 ++
 mm/memory.c                                         |   21 ++++--
 net/core/skbuff.c                                   |   63 ++++++++++++++-=
---
 net/ipv4/netfilter/nft_masq_ipv4.c                  |    8 +-
 net/ipv4/netfilter/nft_redir_ipv4.c                 |    8 +-
 net/ipv6/netfilter/nft_masq_ipv6.c                  |    8 +-
 net/ipv6/netfilter/nft_redir_ipv6.c                 |    8 +-
 net/netfilter/nft_ct.c                              |   10 +-
 net/netfilter/nft_meta.c                            |   42 ++++++------
 net/netfilter/nft_nat.c                             |    8 +-
 net/sched/sch_tbf.c                                 |   10 --
 sound/pci/hda/patch_conexant.c                      |    1=20
 sound/usb/pcm.c                                     |    9 ++
 tools/perf/util/unwind-libdw.c                      |    2=20
 73 files changed, 726 insertions(+), 271 deletions(-)

Adrian Bunk (2):
      dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
      eeprom: at24: add support for 24c2048

Andreas Ziegler (1):
      tracing/uprobes: Fix output for multiple string arguments

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Christian Lamparter (1):
      pinctrl: msm: fix gpio-hog related boot issues

Daniel Axtens (2):
      net: create skb_gso_validate_mac_len()
      bnx2x: disable GSO where gso_size is too big for hardware

Dmitry Torokhov (1):
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-=
573G"

Eric Dumazet (2):
      ch9200: use skb_cow_head() to deal with cloned skbs
      kaweth: use skb_cow_head() to deal with cloned skbs

Eric W. Biederman (1):
      signal: Restore the stop PTRACE_EVENT_EXIT

Greg Kroah-Hartman (2):
      Revert "scsi: aic94xx: fix module loading"
      Linux 4.9.159

Hauke Mehrtens (2):
      uapi/if_ether.h: prevent redefinition of struct ethhdr
      uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define

Hedi Berriche (1):
      x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Hugh Dickins (1):
      mm: stop leaking PageTables

Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning

James Hughes (1):
      smsc95xx: Use skb_cow_head to deal with cloned skbs

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback

John Youn (1):
      usb: dwc2: Remove unnecessary kfree

Jonathan Bakker (1):
      Input: bma150 - register input device after setting private data

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Julien Thierry (9):
      ARM: 8789/1: signal: copy registers using __copy_to_user()
      ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
      ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
      ARM: 8793/1: signal: replace __put_user_error with __put_user
      ARM: 8794/1: uaccess: Prevent speculative use of the current addr_lim=
it
      ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
      ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
      ARM: 8797/1: spectre-v1.1: harden __copy_to_user
      ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Jurica Vukadin (1):
      ALSA: hda - Add quirk for HP EliteBook 840 G5

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Liping Zhang (1):
      netfilter: nf_tables: fix mismatch in big-endian system

Manuel Reinhardt (1):
      ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Milian Wolff (1):
      perf report: Include partial stacks unwound with libdw

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

Peter Ujfalusi (2):
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the sound card name

Ross Lagerwall (1):
      cifs: Limit memory used by lock request calls to a page

Russell King (7):
      ARM: make lookup_processor_type() non-__init
      ARM: split out processor lookup
      ARM: clean up per-processor check_bugs method call
      ARM: add PROC_VTABLE and PROC_TABLE macros
      ARM: spectre-v2: per-CPU vtables to work around big.Little systems
      ARM: ensure that processor vtables is not lost after boot
      ARM: fix the cockup in the previous patch

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Tomi Valkeinen (5):
      drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
      drm/bridge: tc358767: fix single lane configuration
      drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
      drm/bridge: tc358767: reject modes which require too much BW
      drm/bridge: tc358767: fix output H/V syncs

Xiaoyao Li (1):
      kvm: vmx: Fix entry number check for add_atomic_switch_msr()


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxtJA8ACgkQONu9yGCS
aT6OPw//ZYK0HjVPzDuIXmX76mfB79sORicEl56RQjli4h6EB6nu4hmBzylJsywU
qgHPqSUQR/It4RXK5kgE055y0sh5TZLCJlQDr8fVqjHLbBeDilGagusXqmi9VRun
2wmOXEGf4BXYABj+5MzdAQeTiBrSD5IBP0djJD8tURBASHO9Q5iJh4hyimandD0G
m4pPk3qQ4Nb2mMv+lHykLkdaluFEG+DZvZqUbDlSI28rOqi9afGeZ+Gy9znbytmp
7/QMf/YEIGlbAPq5jMohduOhoFZ2j0xZq5n9FO3/Wgmgm2LE4g8jAL4RVcFti7F3
x2DF6/59aff1uDT5dckl/k1fqHdi/9vkZCl6Q+RP5n2+lBLuFYHoME8KtB3XYqFW
5tP+bdCq/vbSPmAw6OydhAuEDmk4u65/K8xEcevOEZTAy7DCr/j5VzNKjKo8XDYi
JCeh7Ui6FiIS52pU4fW/jaCD1uZm3+Kr29gBwqRNwupBGJC5wXQypnYAGLY5zdNA
FJRza+Ir30NfqInATNohmhWcS7vANdGQZXWIxf9+lwY72eykYweUf+qC/z/DachB
mFzfSFa3h6OoNENOaAzXIkAC1+A/yc+QsSU4QMy7XzWok6TjNHdHaKnQhYYSlEsH
IUrhwoAUezOj/lKDUCrIV27r4vAvfO1pSZtLFovFuBeAOrv4LK4=
=118Y
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
