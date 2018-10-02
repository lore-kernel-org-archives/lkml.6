Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7621C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F26206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F26206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbeJBUZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:25:20 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58824 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbeJBUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:25:19 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g7Kvu-0006ZK-FY; Tue, 02 Oct 2018 09:41:50 -0400
Message-ID: <8654bb0845d054bc1c228793168ffa1b1a67943c.camel@surriel.com>
Subject: Re: [PATCH v2 0/7] x86/mm/tlb: make lazy TLB mode even lazier
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com,
        Dave Hansen <dave.hansen@intel.com>
Date:   Tue, 02 Oct 2018 09:41:50 -0400
In-Reply-To: <20181002074421.GQ3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
         <20181002074421.GQ3439@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4/A465V/k7fq5vQrsXR4"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4/A465V/k7fq5vQrsXR4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-02 at 09:44 +0200, Peter Zijlstra wrote:
> On Tue, Sep 25, 2018 at 11:58:37PM -0400, Rik van Riel wrote:
>=20
> > This v2 is "identical" to the version I posted yesterday,
> > except this one is actually against current -tip (not sure
> > what went wrong before), with a number of relevant patches
> > on top:
> > - tip x86/core
> > 	012e77a903d ("x86/nmi: Fix NMI uaccess race against CR3
> > switching")
> > - arm64 tlb/asm-generic (entire branch)
> > - peterz queue mm/tlb
> > 	12b2b80ec6f4 ("x86/mm: Page size aware flush_tlb_mm_range()")
>=20
> If you could please double check:
>=20
>  =20
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=
=3Dx86/mm
>=20
> If 0day comes up green on that, I'll attempt to push it to tip.

That looks good to me.

Thank you!

--=20
All Rights Reversed.

--=-4/A465V/k7fq5vQrsXR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluzdZ4ACgkQznnekoTE
3oPXFQf/VYOExtTpj3on6/kxVzEOxxwip7ae+xgsO7Zznic2i8JzJUoSV7dT38Ch
nG5QB3oI2PG+VkHLQ1IN3fqd0/7W8XmdROXR3TUAX/LwXaXsFWZy/092Q9dc1ghT
WxDvv0c2wuG9W50rkF5osPK5u7bQD+lUiJ8OYFnKyCbnKMoQKi3oEV4MY1hvtiWw
9hN9HwhEe2+l+7Vpt9VvaWXuoxAh7pfWShRYEbl6XvvIhrg9Vf2shTw9lmDFKG4t
fWsNgCXE8SRLdhUIEjIA1IBBSyqdjTvRphctyxCzk7R8udunOgCuDpBWtm7jv03/
QoId/b3+WyrXxOT/Mb5DXqpz45e7Tg==
=nBtV
-----END PGP SIGNATURE-----

--=-4/A465V/k7fq5vQrsXR4--

