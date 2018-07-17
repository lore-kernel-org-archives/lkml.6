Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5596ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610C220C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610C220C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGQLWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:22:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbeGQLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:22:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 047C6C19;
        Tue, 17 Jul 2018 10:50:04 +0000 (UTC)
Date:   Tue, 17 Jul 2018 12:50:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.141
Message-ID: <20180717105002.GA16444@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.141 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/kernel-parameters.txt      |    2=20
 Makefile                                 |    2=20
 arch/mips/mm/ioremap.c                   |   37 +-
 arch/x86/Kconfig                         |   11=20
 arch/x86/Kconfig.debug                   |   10=20
 arch/x86/boot/cpuflags.h                 |    2=20
 arch/x86/boot/mkcpustr.c                 |    2=20
 arch/x86/crypto/crc32-pclmul_glue.c      |    2=20
 arch/x86/crypto/crc32c-intel_glue.c      |    2=20
 arch/x86/crypto/crct10dif-pclmul_glue.c  |    2=20
 arch/x86/entry/common.c                  |    1=20
 arch/x86/entry/entry_32.S                |    2=20
 arch/x86/entry/vdso/vdso32-setup.c       |    1=20
 arch/x86/entry/vdso/vdso32/system_call.S |    2=20
 arch/x86/entry/vdso/vma.c                |    3=20
 arch/x86/include/asm/alternative.h       |    6=20
 arch/x86/include/asm/apic.h              |    1=20
 arch/x86/include/asm/arch_hweight.h      |    2=20
 arch/x86/include/asm/atomic.h            |    1=20
 arch/x86/include/asm/atomic64_32.h       |    1=20
 arch/x86/include/asm/cmpxchg.h           |    1=20
 arch/x86/include/asm/cpufeature.h        |  546 +++++---------------------=
-----
 arch/x86/include/asm/cpufeatures.h       |  306 +++++++++++++++++
 arch/x86/include/asm/disabled-features.h |   17=20
 arch/x86/include/asm/fpu/internal.h      |  182 ++++------
 arch/x86/include/asm/irq_work.h          |    2=20
 arch/x86/include/asm/mwait.h             |    2=20
 arch/x86/include/asm/nospec-branch.h     |    2=20
 arch/x86/include/asm/processor.h         |    3=20
 arch/x86/include/asm/required-features.h |    9=20
 arch/x86/include/asm/smap.h              |    2=20
 arch/x86/include/asm/smp.h               |    1=20
 arch/x86/include/asm/thread_info.h       |    2=20
 arch/x86/include/asm/tlbflush.h          |    1=20
 arch/x86/include/asm/uaccess_64.h        |    2=20
 arch/x86/kernel/apic/apic_numachip.c     |    4=20
 arch/x86/kernel/cpu/Makefile             |    2=20
 arch/x86/kernel/cpu/centaur.c            |    4=20
 arch/x86/kernel/cpu/common.c             |   71 +---
 arch/x86/kernel/cpu/cyrix.c              |    1=20
 arch/x86/kernel/cpu/intel.c              |    2=20
 arch/x86/kernel/cpu/intel_cacheinfo.c    |    2=20
 arch/x86/kernel/cpu/match.c              |    2=20
 arch/x86/kernel/cpu/mkcapflags.sh        |    6=20
 arch/x86/kernel/cpu/mtrr/main.c          |    2=20
 arch/x86/kernel/cpu/scattered.c          |   20 -
 arch/x86/kernel/cpu/transmeta.c          |    6=20
 arch/x86/kernel/e820.c                   |    1=20
 arch/x86/kernel/head_32.S                |    2=20
 arch/x86/kernel/head_64.S                |    4=20
 arch/x86/kernel/hpet.c                   |    1=20
 arch/x86/kernel/msr.c                    |    2=20
 arch/x86/kernel/uprobes.c                |    2=20
 arch/x86/kernel/verify_cpu.S             |    2=20
 arch/x86/kernel/vm86_32.c                |    2=20
 arch/x86/kernel/vmlinux.lds.S            |   11=20
 arch/x86/lib/clear_page_64.S             |    2=20
 arch/x86/lib/copy_page_64.S              |    2=20
 arch/x86/lib/copy_user_64.S              |    2=20
 arch/x86/lib/memcpy_64.S                 |    2=20
 arch/x86/lib/memmove_64.S                |    2=20
 arch/x86/lib/memset_64.S                 |    2=20
 arch/x86/lib/retpoline.S                 |    2=20
 arch/x86/mm/setup_nx.c                   |    1=20
 arch/x86/oprofile/op_model_amd.c         |    1=20
 arch/x86/um/asm/barrier.h                |    2=20
 drivers/ata/ahci.c                       |   59 +++
 drivers/ata/libata-core.c                |    3=20
 drivers/block/loop.c                     |   79 ++--
 drivers/block/loop.h                     |    1=20
 drivers/hid/hid-ids.h                    |    3=20
 drivers/hid/usbhid/hid-quirks.c          |    1=20
 drivers/infiniband/Kconfig               |   12=20
 drivers/infiniband/core/Makefile         |    4=20
 drivers/infiniband/hw/cxgb4/mem.c        |    2=20
 drivers/misc/ibmasm/ibmasmfs.c           |   27 -
 drivers/misc/vmw_balloon.c               |    4=20
 drivers/usb/core/quirks.c                |    4=20
 drivers/usb/host/xhci-mem.c              |    2=20
 drivers/usb/misc/yurex.c                 |   23 -
 drivers/usb/serial/ch341.c               |    2=20
 drivers/usb/serial/cp210x.c              |    1=20
 drivers/usb/serial/keyspan_pda.c         |    4=20
 drivers/usb/serial/mos7840.c             |    3=20
 fs/btrfs/disk-io.c                       |    2=20
 fs/inode.c                               |    6=20
 include/linux/libata.h                   |    1=20
 kernel/power/user.c                      |    5=20
 lib/atomic64_test.c                      |    4=20
 net/bridge/netfilter/ebtables.c          |    2=20
 net/ipv4/netfilter/ip_tables.c           |    1=20
 net/ipv6/netfilter/ip6_tables.c          |    1=20
 net/netfilter/nfnetlink_queue.c          |    3=20
 tools/build/Build.include                |    4=20
 94 files changed, 830 insertions(+), 770 deletions(-)

Alexander Kuleshov (1):
      x86/boot: Simplify kernel load address alignment check

Andi Kleen (1):
      x86/headers: Don't include asm/processor.h in asm/atomic.h

Borislav Petkov (11):
      x86/cpufeature: Move some of the scattered feature bits to x86_capabi=
lity
      x86/cpufeature: Cleanup get_cpu_cap()
      x86/cpu: Provide a config option to disable static_cpu_has
      x86/fpu: Add an XSTATE_OP() macro
      x86/fpu: Get rid of xstate_fault()
      x86/cpufeature: Carve out X86_FEATURE_*
      x86/cpufeature: Replace the old static_cpu_has() with safe variant
      x86/cpufeature: Get rid of the non-asm goto variant
      x86/alternatives: Add an auxilary section
      x86/vdso: Use static_cpu_has()
      x86/cpufeature: Speed up cpu_feature_enabled()

Brian Gerst (1):
      x86/alternatives: Discard dynamic check after init

Dan Carpenter (2):
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Dave Hansen (6):
      x86/cpufeature, x86/mm/pkeys: Add protection keys related CPUID defin=
itions
      x86/mm/pkeys: Fix mismerge of protection keys CPUID bits
      x86/cpufeature, x86/mm/pkeys: Fix broken compile-time disabling of pk=
eys
      x86/cpufeature: Update cpufeaure macros
      x86/cpufeature: Make sure DISABLED/REQUIRED macros are updated
      x86/cpufeature: Add helper macro for mask check macros

Eric Dumazet (1):
      netfilter: nf_queue: augment nfqa_cfg_policy

Florian Westphal (1):
      netfilter: x_tables: initialise match/target check parameter struct

Greg Kroah-Hartman (1):
      Linux 4.4.141

Hans de Goede (1):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Jann Horn (2):
      ibmasm: don't write out of bounds in read handler
      USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

Leon Romanovsky (1):
      RDMA/ucm: Mark UCM interface as BROKEN

Linus Torvalds (1):
      Fix up non-directory creation in SGID directories

Nadav Amit (1):
      vmw_balloon: fix inflation with batching

Nico Sneck (1):
      usb: quirks: add delay quirks for Corsair Strafe

Oleg Nesterov (1):
      uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Olli Salonen (1):
      USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Paul Burton (1):
      MIPS: Fix ioremap() RAM check

Paul Menzel (1):
      tools build: fix # escaping in .cmd files for future Make

Steve Wise (1):
      iw_cxgb4: correctly enforce the max reg_mr depth

Tetsuo Handa (2):
      PM / hibernate: Fix oops at snapshot_write()
      loop: remember whether sysfs_create_group() was done

Theodore Ts'o (1):
      loop: add recursion validation to LOOP_CHANGE_FD

Tomasz Kramkowski (1):
      HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter

Yazen Ghannam (1):
      x86/cpu: Add detection of AMD RAS Capabilities


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltNydcACgkQONu9yGCS
aT4FgQ/+OzBlcMuWCAz3mAe8KBOXC0jHx2cMXZjKp42hGHSA49Gw6S5shAJEOI1B
bsgOxq3tu2Bl+E/9Ow/M5z0/oO8UVtP35MsFw+jeV+Rg1BY1DpPYZOgl8riusM2c
nDcWYEafDfooe5+19Ip1TmFyywujHdnMM4UufHPG/qH1c7bqzmxjOn3pjfB5DWi7
wa0EdRho6myg8FcAPnSnDxxHRdRcw05igc09vNgbfC7+Ko0W33ZqHVXNdWU87fBK
GGH4Xf7DG6nkXj1QfJIOXw3DrCJaehgQ9NMJiukMKXKfbXbVmnh37tF2QMiLpU40
h5NH5D4sy9eNXGj+CZ5k4RnJKr3Jeoj2RKS2OZG8+BLc5ZUR4TRuNBJQ88iWGTZx
YniKts9gFpWTdTgB2zgCoQ1qytC3G3j7HWTDewGskrobJtuT8tMqypy77EG0RSUx
sV8zP5us4FD2obxApreFLOSWJIiId7Al+j90SiLRucgkrs0wSFg7egnd+RA0g8F7
8QFOjU/RS8GGEOXf7WtomNm50+5AeQWBN3pJ0ZQDBPovNUOQQarmlAwG4kQ2mGji
T84rJXIAh3nqSlPEltRM/lwqSZDrE4VLJEcQLWayoTlcpODEN9y0sIQbJLm8LOxL
8bvTHi6ExI9W4gKW4aMoP8eVP7Bzzzv/ooblXeJ+LR/hngA69AI=
=beVJ
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
