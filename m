Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD220820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jfBRFtYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502522AbeKWThg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:37:36 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:19978 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbeKWThf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:37:35 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D9DED4948B;
        Fri, 23 Nov 2018 09:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received; s=
        mail20150812; t=1542963252; bh=/qEzz/vRpkmR3pfXFHCZlCbnNSowd6ELG
        UjJ9QRQZcM=; b=jfBRFtYpkuKmT1mvs090dXVrwgyHckIX0Mmk7TkH0YpkwUeiK
        fA9Lnp7BaHWuDcz/xhYtYDWlHdi+UNPAiWGpiLa+XJypgufUst38JwV8AYlgSMM2
        mChk98hEsexBOEPgIqcstnoW7b288RIplkL4XW8wDvyQJTn4Mjgzc9QdJTfjB+i4
        4NY/qvvdcOCmg9Taxx6vhUjun4Iuzw+1CNyXeXbM18xVqjXdGo75BJoeNXRKc2hs
        C8Vf0oytBtHhWpPdvyMaVyoNe/sG+EM1+WpfokhVnUn/i01xRPXjyftLbNrM6pxv
        sV8iL0p9bRjiTcCdWqGc02Pf53kToyzfptE6g==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id wwsdJYl1Mz3q; Fri, 23 Nov 2018 09:54:12 +0100 (CET)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.9.139
Date:   Fri, 23 Nov 2018 09:55:47 +0100
Message-ID: <1668382.GpLhWH2QsV@siriux>
In-Reply-To: <20181123074731.GA12130@kroah.com>
References: <20181123074731.GA12130@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart257168056.38cRpU25dN"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart257168056.38cRpU25dN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 23. November 2018, 08:47:31 schrieb Greg KH:
> I'm announcing the release of the 4.9.139 kernel.
>=20
> All users of the 4.9 kernel series must upgrade.
>=20
> The updated 4.9.y git tree can be found at:
> =09git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.=
git
> linux-4.9.y and can be browsed at the normal kernel.org git web brows=
er:
> =09http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.gi=
t;a=3Dsummary
>=20
> thanks,
>=20
> greg k-h
>=20
Just *in case* this was an oversight: STIBP is still active in 4.9.139.=


Not that I would mind because for my modest Core i3 that I mainly use f=
or=20
office-work I don't see *any* difference in performance compared to 4.9=
.136=20
(no STIBP).

So long!

Rainer Fiebig

> ------------
>=20
>  .gitignore                                |    1
>  Kbuild                                    |   25 ----
>  Makefile                                  |   27 +++-
>  arch/arm/include/asm/assembler.h          |   12 ++
>  arch/arm/include/asm/barrier.h            |   32 +++++
>  arch/arm/include/asm/bugs.h               |    6 -
>  arch/arm/include/asm/cp15.h               |    3
>  arch/arm/include/asm/cputype.h            |    8 +
>  arch/arm/include/asm/kvm_asm.h            |    2
>  arch/arm/include/asm/kvm_host.h           |   14 ++
>  arch/arm/include/asm/kvm_mmu.h            |   23 +++
>  arch/arm/include/asm/proc-fns.h           |    4
>  arch/arm/include/asm/system_misc.h        |   15 ++
>  arch/arm/include/asm/thread_info.h        |    4
>  arch/arm/include/asm/uaccess.h            |   26 +++-
>  arch/arm/kernel/Makefile                  |    1
>  arch/arm/kernel/bugs.c                    |   18 +++
>  arch/arm/kernel/entry-common.S            |   18 +--
>  arch/arm/kernel/entry-header.S            |   25 ++++
>  arch/arm/kernel/signal.c                  |   55 +++++----
>  arch/arm/kernel/smp.c                     |    4
>  arch/arm/kernel/suspend.c                 |    2
>  arch/arm/kernel/sys_oabi-compat.c         |    8 -
>  arch/arm/kvm/hyp/hyp-entry.S              |  112 ++++++++++++++++++-=

>  arch/arm/lib/copy_from_user.S             |    9 +
>  arch/arm/mm/Kconfig                       |   23 +++
>  arch/arm/mm/Makefile                      |    2
>  arch/arm/mm/fault.c                       |    3
>  arch/arm/mm/proc-macros.S                 |    3
>  arch/arm/mm/proc-v7-2level.S              |    6 -
>  arch/arm/mm/proc-v7-bugs.c                |  174
> ++++++++++++++++++++++++++++++ arch/arm/mm/proc-v7.S                 =
    |=20
> 154 +++++++++++++++++++++----- arch/arm/vfp/vfpmodule.c              =
    |=20
>  17 +-
>  arch/arm64/crypto/sha1-ce-core.S          |    6 -
>  arch/arm64/crypto/sha1-ce-glue.c          |   11 -
>  arch/arm64/crypto/sha2-ce-core.S          |    6 -
>  arch/arm64/crypto/sha2-ce-glue.c          |   13 --
>  arch/arm64/include/asm/efi.h              |    3
>  arch/arm64/include/asm/uaccess.h          |    4
>  arch/ia64/kernel/Makefile                 |   26 ----
>  arch/x86/Makefile                         |   39 +++++-
>  arch/x86/boot/string.c                    |    9 +
>  arch/x86/crypto/aes_ctrby8_avx-x86_64.S   |    7 -
>  drivers/firmware/efi/libstub/Makefile     |   26 ++--
>  drivers/firmware/efi/libstub/arm64-stub.c |   10 +
>  drivers/net/ethernet/broadcom/tg3.c       |   18 ++-
>  drivers/net/usb/smsc95xx.c                |    7 +
>  drivers/xen/Makefile                      |    3
>  include/linux/kbuild.h                    |    6 -
>  include/linux/module.h                    |    4
>  net/core/dev.c                            |    4
>  net/core/flow_dissector.c                 |    4
>  net/ipv4/inet_fragment.c                  |   28 ++--
>  net/ipv4/ip_tunnel_core.c                 |    2
>  net/ipv6/route.c                          |    7 -
>  net/sctp/socket.c                         |   26 ----
>  scripts/Kbuild.include                    |   18 ++-
>  scripts/Makefile.build                    |    8 +
>  scripts/Makefile.extrawarn                |    1
>  scripts/Makefile.host                     |    6 -
>  scripts/Makefile.lib                      |   31 +++++
>  scripts/mod/Makefile                      |   28 ----
>  62 files changed, 901 insertions(+), 296 deletions(-)
>=20
> Ard Biesheuvel (5):
>       crypto: arm64/sha - avoid non-standard inline asm tricks
>       efi/libstub/arm64: Use hidden attribute for struct screen_info
> reference efi/libstub/arm64: Force 'hidden' visibility for section ma=
rkers
> efi/libstub: Preserve .debug sections after absolute relocation check=

> efi/libstub/arm64: Set -fpie when building the EFI stub
>=20
> Arnd Bergmann (2):
>       modules: mark __inittest/__exittest as __maybe_unused
>       Kbuild: use -fshort-wchar globally
>=20
> Behan Webster (2):
>       kbuild: Add better clang cross build support
>       kbuild: use -Oz instead of -Os when using clang
>=20
> David Ahern (1):
>       ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF
>=20
> Eric Dumazet (2):
>       net-gro: reset skb->pkt_type in napi_reuse_skb()
>       inet: frags: better deal with smp races
>=20
> Frieder Schrempf (1):
>       usbnet: smsc95xx: disable carrier check while suspending
>=20
> Greg Kroah-Hartman (1):
>       Linux 4.9.139
>=20
> Jeroen Hofstee (1):
>       kbuild: fix asm-offset generation to work with clang
>=20
> Marc Zyngier (2):
>       ARM: KVM: invalidate BTB on guest exit for Cortex-A12/A17
>       ARM: KVM: invalidate icache on guest exit for Cortex-A15
>=20
> Mark Charlebois (1):
>       kbuild, LLVMLinux: Add -Werror to cc-option to support clang
>=20
> Mark Rutland (1):
>       arm64: uaccess: suppress spurious clang warning
>=20
> Masahiro Yamada (2):
>       kbuild: consolidate redundant sed script ASM offset generation
>       kbuild: drop -Wno-unkanown-warning-option from clang options
>=20
> Matthias Kaehlcke (8):
>       kbuild: Consolidate header generation from ASM offset informati=
on
>       x86/kbuild: Use cc-option to enable -falign-{jumps/loops}
>       kbuild: Add __cc-option macro
>       x86/build: Use __cc-option for boot code compiler options
>       x86/build: Specify stack alignment for clang
>       kbuild: clang: Disable 'address-of-packed-member' warning
>       x86/build: Fix stack alignment for CLang
>       x86/build: Use cc-option to validate stack alignment parameter
>=20
> Michael Davidson (3):
>       kbuild: clang: add -no-integrated-as to KBUILD_[AC]FLAGS
>       crypto, x86: aesni - fix token pasting for clang
>       x86/boot: #undef memcpy() et al in string.c
>=20
> Russell King (22):
>       ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs
>       ARM: bugs: prepare processor bug infrastructure
>       ARM: bugs: hook processor bug checking into SMP and suspend pat=
hs
>       ARM: bugs: add support for per-processor bug checking
>       ARM: spectre: add Kconfig symbol for CPUs vulnerable to Spectre=

>       ARM: spectre-v2: harden branch predictor on context switches
>       ARM: spectre-v2: add Cortex A8 and A15 validation of the IBE bi=
t
>       ARM: spectre-v2: harden user aborts in kernel space
>       ARM: spectre-v2: add firmware based hardening
>       ARM: spectre-v2: warn about incorrect context switching functio=
ns
>       ARM: spectre-v2: KVM: invalidate icache on guest exit for Brahm=
a B15
>       ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
>       ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1
>       ARM: spectre-v1: add speculation barrier (csdb) macros
>       ARM: spectre-v1: add array_index_mask_nospec() implementation
>       ARM: spectre-v1: fix syscall entry
>       ARM: signal: copy registers using __copy_from_user()
>       ARM: vfp: use __copy_from_user() when restoring VFP state
>       ARM: oabi-compat: copy semops using __copy_from_user()
>       ARM: use __inttype() in get_user()
>       ARM: spectre-v1: use get_user() for __get_user()
>       ARM: spectre-v1: mitigate user accesses
>=20
> Sabrina Dubroca (1):
>       ip_tunnel: don't force DF when MTU is locked
>=20
> Siva Reddy Kallam (1):
>       tg3: Add PHY reset for 5717/5719/5720 in change ring and flow c=
ontrol
> paths
>=20
> Vin=C3=ADcius Tinti (1):
>       kbuild: Add support to generate LLVM assembly files
>=20
> Xin Long (1):
>       sctp: not allow to set asoc prsctp_enable by sockopt
>=20
> =EB=B0=B0=EC=84=9D=EC=A7=84 (1):
>       flow_dissector: do not dissect l4 ports for fragments

=2D-=20
The truth always turns out to be simpler than you thought.
Richard Feynman
--nextPart257168056.38cRpU25dN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAlv3wJMACgkQ8OH3JiWK
+PU3/A//c+9ZkXymU9NhGYGk+BTWcihlDNIo7u0xYuLp08/44exisGxv7uz+u+ia
r7GuY3YL2EWYbVspMmvG0DLCRJSIGWj5ZupdDbTD3fV7WGmSJL36wR7thA84VQQG
kVt+mOEB50wXcrpSSEtZLfoXrg1dZ2st2SSxaBNIzPf4Q5yaH6KxfHmG2B+jlQar
KfK0zqhvBKr6xVLvIcPG/Bp7O9RryGH68mHpJ8J4yGcGaytdBOyKyV2By8PQy+Qz
RuBQtjbuuXVYAE4MailzW/NU+76qeeK/DWUu8Jq3ob1wLs7kfFNruxALb6KY9Qn0
EtcukXSnoW0lSDSuCSQC0khorELQt2jaXAPSmRaU7Gldi14j0MYCU+j79l+gKjro
zdEW2sU0XVagaf/geYry3e0eMO47z8xDCnEH0zRfo7bUqvlpcfLsk4lett+MhM0c
B/SCHSWf3lvK23NUyPX60v8Z0KQzugAIfijJp+VGFvxSu1GYl8UR6LkzjpYQpn9C
vxA9a2ihjcakQ2OHGCNMwgrN/iDqAXEiBvIyAcJKdaiVqVqAQdsBqe5FLTG/0ERT
eg2XkjGQ69AKR7y8K12BkcOONcfgtxHDKLcyl02noVsNpB+e/IZs+YL5u2AhcwSD
G6ApkkDJUf72Qdm1JVl2jToIMulqaIMFCxaJMc5KSd+Ts7IMODk=
=f2bg
-----END PGP SIGNATURE-----

--nextPart257168056.38cRpU25dN--

