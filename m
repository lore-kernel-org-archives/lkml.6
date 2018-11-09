Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E152C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F186520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F186520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKJILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:11:19 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:58062 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:11:18 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9A35172CBF9;
        Sat, 10 Nov 2018 01:28:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8E7D77CD1FF; Sat, 10 Nov 2018 01:28:39 +0300 (MSK)
Date:   Sat, 10 Nov 2018 01:28:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] riscv: define syscall_get_arch()
Message-ID: <20181109222839.GB2054@altlinux.org>
Mail-Followup-To: David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20181109031303.GA20906@altlinux.org>
 <20181109031712.GL21511@altlinux.org>
 <CAEn-LTpbzdpeWv8wqo_ptBw2t3Ypzzp0JcB+TGMG4NZbEGBnkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <CAEn-LTpbzdpeWv8wqo_ptBw2t3Ypzzp0JcB+TGMG4NZbEGBnkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 07:59:13AM +0100, David Abdurachmanov wrote:
> On Fri, Nov 9, 2018 at 4:17 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> >
> > syscall_get_arch() is required to be implemented on all architectures
> > that use tracehook_report_syscall_entry() in order to extend
> > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>=20
> I have posted audit support patch for RISC-V in October. Pending review.
> It defines both AUDIT_ARCH_RISCV32 and AUDIT_ARCH_RISCV64.
>=20
> See thread: http://lists.infradead.org/pipermail/linux-riscv/2018-October=
/001933.html

I'll take your version of RISC-V related change of include/uapi/linux/audit=
=2Eh
to this series, thanks!

P.S. It would be great if you replied to me as well.


--=20
ldv

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb5goXAAoJEAVFT+BVnCUIjBAP/RryYu/a/aHNZcoZXIOFxfXE
02HB/UcnCDdFjXcibkWZz79BRfjsi5GwRYqsFqA+xnGT2/yXP0lw8Onl39rUHQg1
dX9qIy0u9hFwf43eQqTRHoX4v1+k/l5c97Zoejzj/3sMYW2RVzp7zNdYaYLlwkVl
w0tO1ant3BmWvU5zGAASeOlBr0js28afy/5tHYQs6pJ7x6SjeVYSEDvLIhh50R2s
OMNivE9N0NQpDJqRmptrpcsWUnS/EcCGii/SWIjILjO7mHA+krjhURnN0T8zBEKJ
LMg50l7N8v+l3RXL3jZd5qX9pF+g9C5RApFAJqeFqUd0TGypKQEuvw7CnJH2qNpv
3sgdlKlueiB8YdyFXYq2iMq+dSS9xSW+Jo5jsxYARToBFO2fI4CZUoEWux6NIpZ5
9N+hli3P8Q1K0Fl2skEikclyeIE61+2f9n3n73qWLOyp0H4qn6ZjNeDGP0Vsp1c5
KT2p07b1UV+XvY04qPMXyuft/FUeGYRiVLqu2okTxjaIx7QLqAp0HDbugUHGGNRx
8ClhF55ByoNDPvbX8WvmXhHtCK8BhMABxL+iRQl26nzQbKdsuFq8ulAr3Kb+NWsu
etwtV96eA+snnob1tLTq/fwj5wq1PQAbrJdnFsb/6TxcspM5ia8VmjuVuFeW/Ofj
S3kY9ZU0UqCUkTNXF6oQ
=GUwG
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
