Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-840750-1518039303-2-16744978755267562694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518039302; b=lV4kYnczq1pKisyrLLIvMyX6Cv97kFanZlXlnWtcG7jAEaM
    3So9dIegFT2XNxtf3q7HleHs1cpV/jIqr1ubMrb8h9J8vIsNm8MghuNpIJMJ6YlN
    VFJABcyiJLkWXf0e9YcSWmWnH8aNImHAxtDALgtmoTk3xkoW0A5/pia7osNPKrBE
    vcHWVm2Jb2a8emq5onkLutzHHhpDhhmZrmSIhB85Mj4E96L/uZFcvDEkFirI9FXz
    3O2qFfcqVa9mF5fbM0gojfPFCzl1kiLCSEFexHdFpcdvc2GBNVvnujrirpQuD7Bs
    IcL8mSwmVFMueoUPzaX/9PF5Al/OnpVLtlyZbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518039302; bh=yIDFed0++c8FfKuJlWex82Sy8lDULQ4oDndwvxRCayc=; b=l
    F4a+fkvBvenGx8pn9karCUYPep4iXWodueaSqOAOUCSpyHabu4XaC/LtrtTZWBcP
    UF+/vdnhu5BXyP3wnU5uxleQYwfB+mJ1d5ARfXbAxc9Edb4FWK7Emhj+Jl4rPF9v
    j50fzggMor7XpAnvdeFXMdGDaFWO0qKFug5tsWmsgbbJjkZnJ2ERhPxZ5vIggpLG
    VzAVk9p0L+bV4ITswMt9ZKxDPHg+NubrOW7c/ODNoqdcIqEOCjLaXo2Y1lNyPnWT
    B6+wBdylpPC/B22ShoG53vzcrV2Bwt9NjwJGEGY6EDYQ38TALHGvgjpRjVNsZ4nO
    Z8sITQyUaSgm4TUuRZSHg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeBGVfB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:35:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754355AbeBGVfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 16:35:00 -0500
Date: Wed, 7 Feb 2018 15:34:59 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.18
Message-ID: <20180207213459.GA6499@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.18 kernel.

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

 Documentation/admin-guide/kernel-parameters.txt |    2=20
 Documentation/speculation.txt                   |   90 +++
 Makefile                                        |    2=20
 arch/powerpc/Kconfig                            |    1=20
 arch/powerpc/kernel/setup_64.c                  |   38 +
 arch/x86/entry/common.c                         |    9=20
 arch/x86/entry/entry_32.S                       |    3=20
 arch/x86/entry/entry_64.S                       |  130 ----
 arch/x86/entry/syscall_64.c                     |    7=20
 arch/x86/include/asm/asm-prototypes.h           |    4=20
 arch/x86/include/asm/barrier.h                  |   28 +
 arch/x86/include/asm/cpufeature.h               |    7=20
 arch/x86/include/asm/cpufeatures.h              |   22=20
 arch/x86/include/asm/disabled-features.h        |    3=20
 arch/x86/include/asm/fixmap.h                   |    6=20
 arch/x86/include/asm/msr-index.h                |   12=20
 arch/x86/include/asm/msr.h                      |    3=20
 arch/x86/include/asm/nospec-branch.h            |   86 ---
 arch/x86/include/asm/pgtable_32_types.h         |    5=20
 arch/x86/include/asm/processor.h                |    5=20
 arch/x86/include/asm/required-features.h        |    3=20
 arch/x86/include/asm/syscall.h                  |    6=20
 arch/x86/include/asm/thread_info.h              |    3=20
 arch/x86/include/asm/tlbflush.h                 |    2=20
 arch/x86/include/asm/uaccess.h                  |   15=20
 arch/x86/include/asm/uaccess_32.h               |    6=20
 arch/x86/include/asm/uaccess_64.h               |   12=20
 arch/x86/kernel/alternative.c                   |   28 -
 arch/x86/kernel/cpu/bugs.c                      |  134 +++-
 arch/x86/kernel/cpu/common.c                    |   70 ++
 arch/x86/kernel/cpu/intel.c                     |   66 ++
 arch/x86/kernel/cpu/scattered.c                 |    2=20
 arch/x86/kernel/process_64.c                    |    4=20
 arch/x86/kernel/ptrace.c                        |    2=20
 arch/x86/kernel/signal.c                        |    2=20
 arch/x86/kvm/cpuid.c                            |   22=20
 arch/x86/kvm/cpuid.h                            |    1=20
 arch/x86/kvm/emulate.c                          |    9=20
 arch/x86/kvm/svm.c                              |  116 ++++
 arch/x86/kvm/vmx.c                              |  660 ++++++++++++++-----=
-----
 arch/x86/kvm/x86.c                              |    1=20
 arch/x86/lib/Makefile                           |    1=20
 arch/x86/lib/getuser.S                          |   10=20
 arch/x86/lib/retpoline.S                        |   57 ++
 arch/x86/lib/usercopy_32.c                      |    8=20
 arch/x86/mm/tlb.c                               |   33 +
 drivers/auxdisplay/img-ascii-lcd.c              |    4=20
 drivers/fpga/fpga-region.c                      |   13=20
 drivers/iio/accel/kxsd9-i2c.c                   |    3=20
 drivers/iio/adc/qcom-vadc-common.c              |    4=20
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c            |    4=20
 drivers/tty/serial/serial_core.c                |    2=20
 include/linux/fdtable.h                         |    5=20
 include/linux/init.h                            |    9=20
 include/linux/module.h                          |    9=20
 include/linux/nospec.h                          |   72 ++
 kernel/module.c                                 |   11=20
 net/wireless/nl80211.c                          |    9=20
 scripts/faddr2line                              |    8=20
 scripts/mod/modpost.c                           |    9=20
 sound/soc/codecs/pcm512x-spi.c                  |    4=20
 tools/objtool/check.c                           |   89 +--
 tools/objtool/orc_gen.c                         |    5=20
 63 files changed, 1354 insertions(+), 642 deletions(-)

Andi Kleen (1):
      module/retpoline: Warn about missing retpoline in module

Andy Lutomirski (3):
      x86/entry/64: Remove the SYSCALL64 fast path
      x86/entry/64: Push extra regs right away
      x86/asm: Move 'status' from thread_struct to thread_info

Arnd Bergmann (1):
      x86/pti: Mark constant arrays as __initconst

Ashok Raj (1):
      KVM/x86: Add IBPB support

Borislav Petkov (5):
      x86/alternative: Print unadorned pointers
      x86/nospec: Fix header guards names
      x86/bugs: Drop one "mitigation" from dmesg
      x86/retpoline: Simplify vmexit_fill_RSB()
      x86/speculation: Simplify indirect_branch_prediction_barrier()

Colin Ian King (1):
      x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"

Dan Williams (12):
      array_index_nospec: Sanitize speculative array de-references
      x86: Implement array_index_mask_nospec
      x86: Introduce barrier_nospec
      x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
      x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}
      x86/uaccess: Use __uaccess_begin_nospec() and uaccess_try_nospec
      x86/get_user: Use pointer masking to limit speculation
      x86/syscall: Sanitize syscall table de-references under speculation
      vfs, fdtable: Prevent bounds-check bypass via speculative execution
      nl80211: Sanitize array index in parse_txq_params
      x86/spectre: Report get_user mitigation for spectre_v1
      x86/kvm: Update spectre-v1 mitigation

Darren Kenny (1):
      x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

David Woodhouse (10):
      x86/cpufeatures: Add CPUID_7_EDX CPUID leaf
      x86/cpufeatures: Add Intel feature bits for Speculation Control
      x86/cpufeatures: Add AMD feature bits for Speculation Control
      x86/msr: Add definitions for new speculation control MSRs
      x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdo=
wn
      x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 micr=
ocodes
      x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) =
support
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags
      x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
      x86/retpoline: Avoid retpolines for built-in __init functions

Dou Liyang (1):
      x86/spectre: Check CONFIG_RETPOLINE in command line parser

Greg Kroah-Hartman (1):
      Linux 4.14.18

Ian Abbott (1):
      fpga: region: release of_parse_phandle nodes after use

Jesse Chan (3):
      auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICE=
NSE
      pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jim Mattson (1):
      KVM: nVMX: Eliminate vmcs02 pool

Josh Poimboeuf (4):
      objtool: Improve retpoline alternative handling
      objtool: Add support for alternatives at the end of a section
      objtool: Warn on stripped section symbol
      x86/paravirt: Remove 'noreplace-paravirt' cmdline option

KarimAllah Ahmed (5):
      x86/spectre: Simplify spectre_v2 command line parsing
      KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX
      KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
      KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
      KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL

Linus Walleij (1):
      iio: adc/accel: Fix up module licenses

Liu, Changcheng (1):
      scripts/faddr2line: fix CROSS_COMPILE unset error

Mark Rutland (1):
      Documentation: Document array_index_nospec

Michael Ellerman (2):
      powerpc/64s: Wire up cpu_show_meltdown()
      powerpc/64s: Allow control of RFI flush via debugfs

Paolo Bonzini (2):
      KVM: VMX: introduce alloc_loaded_vmcs
      KVM: VMX: make MSR bitmaps per-VCPU

Peter Zijlstra (2):
      KVM: x86: Make indirect calls in emulator speculation safe
      KVM: VMX: Make indirect call speculation safe

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized after successful IRQ change

Thomas Gleixner (1):
      x86/cpu/bugs: Make retpoline module warning conditional

Tim Chen (1):
      x86/speculation: Use Indirect Branch Prediction Barrier in context sw=
itch

Waiman Long (1):
      x86/retpoline: Remove the esp/rsp thunk

William Grant (1):
      x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlp7cQIACgkQONu9yGCS
aT6lKRAAiViPXGhOKOeG7dnwVbzjoDXVCwwLn0QWVo9IJQLULbJOaDJBc8Q0lJXa
2FsLw0l+oJB1vgYntb9LjVcZLBL4RBvGqJyoRxJD5RF91Aex0RWjvn5jwBC33Jt2
EyONAsKtSMSMkNYvkbxZjfsWtmKQdV7cAOhpEDRaQuTpqPoqxJECaW6YXJFUR6l4
Nnm69D6x98RH0NH7LRYQflBtrVhnWZ488JLct/K3PVanjrrge6TfaYuU+ILsJrWG
ijIaky5YvQodVUoh4wQukcWEJkvwC7YOFr6p14hq81Nbts8ltAmV7moP4Q0kPQhb
sRUeaQ97R7Zcm/YNA8BltdsojIGLkondYwMSXxK4pviARap3fTy/qlZjcRIcKwVd
QTYF2ewAyZtTDK/HPyqDG+TdV2GGHihUBcapk2dgteuGRulqA3LjJvj0I57QK/ok
WpGhQfzuYx01qG3bynOqVEbY4RD0znObGjQa0Zx9SmG+BuoD7jiBTY9/ke6HIr/a
CpgHCdSkhA2hik3sprOSEW+dEKB6lL5VZzLDJHy8E7YMdWQcdWXyibn7pxF++Mgy
R6GIa407BfS5oZlKqjvwRxAgxCiNGeQ/8L7WPTrk0hqQfpjjZibYV3hQz3ohr1QZ
G7LKorCKAkLhU9ZotymJo2WqOdKzLbc1p2zfB3ZytH9gkFonXxA=
=4VB7
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
