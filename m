Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A25AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFDF20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hc0WrTMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFDF20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbeFRWFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:05:50 -0400
Received: from ozlabs.org ([203.11.71.1]:39737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754136AbeFRWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:05:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418lXT3DrLz9s37;
        Tue, 19 Jun 2018 08:05:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529359545;
        bh=loyoGL0Yp9PJl1k5CPRY+rVzQlY2N/O+cDIPzPmKSug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hc0WrTMlULwg4wdkyW97ljCfYeOBV+z8Zb1h2qIcrx06eZDOCClIFxiBJ3okJoiZ4
         8qejIuHgRaiFCZNtGz4m26AT7A0s6dOcQBJrZRtW5fn5X7g78Uuy1LEOeo5X2ZlLEu
         gEMFuDjn2Z8HzmLG20vD5hNY5lTRlFpfj2ShB7POqY365IbzeHJOtytP23IcySOi42
         QfRWX9ts+fVtS/oNtFgjRuMItchEnQR5STPwPVgexFIJ3u+k5pSIquUDbF/+4mtMJ3
         R/u/0mlJp1JH6QfDDhKtOWheeWjqyQ6Ft9SFpB8WHSSkYphLrLUfg0IU4bEy2dXyq4
         cZ3hu/2Zk5lmA==
Date:   Tue, 19 Jun 2018 08:05:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        youling257 <youling257@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
Message-ID: <20180619080522.40a20951@canb.auug.org.au>
In-Reply-To: <CAHp75VfPPnqgsHFwfLaUZSYa3i2tUmvWpwgxEAz45q61aU9OGA@mail.gmail.com>
References: <20180617235812.18596-1-youling257@gmail.com>
        <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
        <32076294-07ac-7801-2220-7468e71c275e@redhat.com>
        <CAHp75VfPPnqgsHFwfLaUZSYa3i2tUmvWpwgxEAz45q61aU9OGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=7Rk8ADpmHC12MzCvX2M/I6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=7Rk8ADpmHC12MzCvX2M/I6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 18 Jun 2018 16:59:30 +0300 Andy Shevchenko <andy.shevchenko@gmail.c=
om> wrote:
>
> > youling has indicated to me (off-list) that he does not
> > want to use his real name.
> >
> > He has already provided me with the touchscreen details
> > and dmi strings for this tablet a while ago and I had
> > writing the exact same quirk on my TODO list already.
> >
> > As such I've no doubt that he created this patch and
> > has the rights to Submit it under the GPL license.
> >
> > So I'm going to resubmit this with his S-o-b removed
> > and replaced with mine. Where the intent of my
> > S-o-b is to certify point c. of the certificate
> > of origin, quoting from:
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
developer-s-certificate-of-origin-1-1
> >
> > "c. The contribution was provided directly to me by some other person w=
ho
> > certified (a), (b) or (c) and I have not modified it."
> >
> > This seems better then me re-creating the exact
> > same patch from scratch. =20
>=20
> I guess this will not pass checks Stephen has.
> So, Stephen, how should we proceed?

That's fine.  I amy report it (If I forget this email), but you can
just ignore the report.  My scripted checks obviously can't take this
case into account.

--=20
Cheers,
Stephen Rothwell

--Sig_/=7Rk8ADpmHC12MzCvX2M/I6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoLKIACgkQAVBC80lX
0GwUWAf+IPuTkMyXrUOf76PcmJq6uAcEdoyOa+kwantW3LtEjZG8AuvS2J4ut/Cp
GM8Xn2GSHJ/eLDIKX6qef88jw9zrrVHLIehTcT30LMcz0732jULz4/K7L7450xFb
QG+H+KhNZRfh6FAIWUxZxmUzILOk021jHn/C4BRxclwM9V+Y7jwfwUhKSkEXTyyb
paBSuXEe+gG9RvDe+toJbakMF/8zdTKzyB96YwWy4v6ZzGmtFMmmOuvpacAqjsDZ
AlxzWQ0lvtKS6xK5rgOTy1eF6xASnBxJI8rlBYthdQe00Cgk9AhJ9MfvKZOAJODN
NabV8aqctwOyx7jJEE8Sb8jjy18cTw==
=OcAw
-----END PGP SIGNATURE-----

--Sig_/=7Rk8ADpmHC12MzCvX2M/I6--
