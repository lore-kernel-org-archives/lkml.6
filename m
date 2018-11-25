Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD01C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236D120868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236D120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeKYUlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:41:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58959 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeKYUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:41:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5911A808D4; Sun, 25 Nov 2018 10:50:29 +0100 (CET)
Date:   Sun, 25 Nov 2018 10:50:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/16] x86/microcode/AMD: Improve container verification
Message-ID: <20181125095031.GA24909@amd>
References: <20181107170218.7596-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20181107170218.7596-1-bp@alien8.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-07 18:02:02, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>=20
> Hi all,
>=20
> this is work which got started by Maciej a while ago. I have finally had
> the time to redo all the ideas properly, split it in self-contained,
> logical chunks and test it.
>=20
> Reveiew and comments are appreciated.

Unfortunately, this is not too useful cover letter. It does not tell
us what the goals if the series are, for example :-(.
								Pavel

> Thx.
>=20
> Borislav Petkov (11):
>   x86/microcode/AMD: Move verify_patch_size() up in the file
>   x86/microcode/AMD: Clean up per-family patch size checks
>   x86/microcode/AMD: Cleanup verify_patch_size() more
>   x86/microcode/AMD: Concentrate patch verification
>   x86/microcode/AMD: Simplify patch family detection
>   x86/microcode/AMD: Move patch family check to verify_patch()
>   x86/microcode/AMD: Move chipset-specific check into verify_patch()
>   x86/microcode/AMD: Change verify_patch()'s return value
>   x86/microcode/AMD: Convert early parser to the new verification routines
>   x86/microcode/AMD: Fix container size's type
>   x86/microcode/AMD: Update copyright
>=20
> Maciej S. Szmigiero (5):
>   x86/microcode/AMD: Subtract SECTION_HDR_SIZE from file leftover length
>   x86/microcode/AMD: Add microcode container verification
>   x86/microcode/AMD: Check microcode container data in the late loader
>   x86/microcode/AMD: Convert CPU equivalence table variable into a struct
>   x86/microcode/AMD: Check the equivalence table size when scanning it
>=20
>  arch/x86/kernel/cpu/microcode/amd.c | 469 ++++++++++++++++++----------
>  1 file changed, 307 insertions(+), 162 deletions(-)
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv6cGcACgkQMOfwapXb+vIHtACcCm+nFF9keEIe7XzIA6FybqiN
63wAn36HSGj86urP2YsnS5W6Nb2RXxY5
=/RcZ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
