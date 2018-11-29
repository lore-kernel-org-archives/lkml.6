Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA4AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C9A20832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C9A20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeK2M7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:59:48 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49662 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2M7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:59:47 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBYl-0008Us-8R; Wed, 28 Nov 2018 20:56:07 -0500
Message-ID: <0af334ceeb51df7e8bfcd0cfc83ca6372a946cc6.camel@surriel.com>
Subject: Re: [PATCH 06/29] x86/fpu: Update comment for __raw_xsave_addr()
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 28 Nov 2018 20:56:07 -0500
In-Reply-To: <20181128222035.2996-7-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-7-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oDO3NDjZKUhcaC7mJhWX"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oDO3NDjZKUhcaC7mJhWX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
> The comment above __raw_xsave_addr() claims that the function does
> not
> work for compacted buffers and was introduced in commit
>   b8b9b6ba9dec3("x86/fpu: Allow setting of XSAVE state")

...

> Based on that the function works for compacted buffers as long as the
> CPU supports it and this what we care about.
>=20
> Remove the "Note:" which is not accurate.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-oDO3NDjZKUhcaC7mJhWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/RzcACgkQznnekoTE
3oON1QgArCdNQ7ZVHG/mL7IsEU9Y6iXUBSw4lo5bZtaKc7CMudoPLcJs0oAhKA2y
Kki3INtas1TKI6tytXu30NSyCDKlILpzaKMkyWSVQIWaj6u0IP/Oxo5dmM8wLQgU
3Tkm6Jeq2e2YZ8iMsUQZDgqjs4L6f68sw7ETmoCvJB3VyNkPcffwz4eI2Cfdyfx/
vQ56eHTQuWdR+6V7gQW+y6Roj22S9rkXe7muAyTnuu/oY0nGxBiTqTij/+FwvSMI
XqP4pKBNz2WQtWCd4Q8E08Gxj0rByHd2v/N+GyzD1UMvEcYB0u0S8FNQ7mfHc+aU
mvqNF8A5xIE9hj51D8sp4USiwpmlnQ==
=ePOz
-----END PGP SIGNATURE-----

--=-oDO3NDjZKUhcaC7mJhWX--

