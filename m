Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521837041; cv=none;
        d=google.com; s=arc-20160816;
        b=qXoT7kU/8R/12//4xfOp75imWKs3EOYJHpfuTN/+1SBaV1Q/80ueDp0F37cj/gK/tk
         RdRptUM5e/BIX2oih3mZ1HOBwdP2jNt/41AVQyaVx81AW2LgK5uwmJzcJ6l/uPydkj7U
         Ih7Elos/DsHVpf6uCdmyV0zq7qFnTShfZTlXPKiEvG/tSgp/pcy9k65N8BGcCZKywMY8
         RoOXR3wrNSQfOYv6NdIRsRSt3G1qMrrz/bO/k7JoFAX+P7sctxjb44yY8XkD3+w9t2ys
         vDrizNxrSmGBzBSzy0XgqPNTxU1ngrgpkvmKBGTYvQDqn1ix190uLR2KbAdqEU7FKV9r
         rlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=LO1D0fNxtVCF1ZcPTF2eOESNeVHSWVJbkd+xIxxmdGI=;
        b=peE5K6CEwp+pZq9aaW43l1p6BVCR2SEqtQOMM6zLh9WkmFGxzIMlKwqOBEvKbl1a4m
         2zC3BsEMWhoUY6mFXjP6p09TqDXsuGpaVSZbvFzRjZh9NbVpwPMObKT47vCeveqlkued
         Y0QGMqajxmEs81mkV2rqTnyhjwcfRwINjytqSNBMNSU34oVrlEJ35cbfU/ynDxvDSBdv
         Tb0m6jNbk0mPKPiYxv8VHrPrLI8D7rHkJZmnHEKofbTsIsfZqLajrU1d5CAUWcK3XvnB
         VaBA/iIjXYinLfzgkvjAOCtsmYH9OAWnfVAFt/zOD+HdElH8NMzwFOtejhp0g/8h/q0y
         hUeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fK7ZvrqV;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fK7ZvrqV;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELto7sGoyaBzuKVGP34+tpsaLmvpLbwyUNu6u2r+obhXQFKazTZy8X0n471yWfdLbCdo1/rWmA==
Date: Fri, 23 Mar 2018 10:30:37 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-kernel@vger.kernel.org,
	Frank Seidel <fseidel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty/nozomi: refactor macros and functions
Message-ID: <20180323203037.2jiv7y3jyxd2v5az@gmail.com>
References: <20180321043430.lbvd4fpswl6cy2gq@gmail.com>
 <20180323152737.GA25972@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqwy3ejb2icsufuc"
Content-Disposition: inline
In-Reply-To: <20180323152737.GA25972@kroah.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520449932103210?=
X-GMAIL-MSGID: =?utf-8?q?1595761797382349391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--eqwy3ejb2icsufuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 04:27:37PM +0100, Greg Kroah-Hartman wrote:
> That's a lot of different things to do all in a single patch.
>=20
> Please break this up into a patch series, doing only one logical "thing"
> per patch.

Sorry about that, I'll spin up a patchset now.

--=20
Cheers,
Joey Pabalinas

--eqwy3ejb2icsufuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlq1Y+0ACgkQruvLfWhy
VBm9jQ/+P/W9r1WHhJUMxd00O+cTmYRO1PbsaZVMmQ32SpyiKugcc1+GVIDYY12U
5fsD3Pqz/BSyM/5csabm0axklXqn2qvHgRCzBweQ8ZjnoZJHH4QGGsD929lbUf7F
se+RN6BzM9E9f+bym1OR9TWUemu19BbvSCMH2fxZTKbqjm5S3tvK2CeY5iNKf9UE
33px9NVqJsAwUaJwrN11fDyB5rai+0yDHIU0mGncGv9Wrlrd1t4KlYfavW4xy6IO
+U+komSvuCe/D+P5j9FahhS7D0szFJQdOw1Ou+uAWiz0nnX+LQ+TmKNz26ajn3V3
v3lG0jXWeU12vcqGthnOIw3Q3tcoFpfuCOHQPal/wBMrA7mUhQuWNGQolRZ2ZDZp
M6F4taL8HsTDGa19UERKeJocCjNjsaRJKL7hcBAo+gOQE2yk4kWuBvQWdmesqOOY
fyU0iMr1VUGFAnTDeUpGbB7HlebigP6Yyv4cTSh0/w4iIcDhEtHP+pnxQaUwBy8e
wXEWd5jBjD4fIoyUPuzcyK2C0o5M3tzgQV/1PlluiqGrP3eudOHBYvk6iNepo5DP
xCSjTfoF9PGb5MKjYKOZEuCeR9Fy6xmeKffGlZwzIBQJiV9AFD5W2WdlEqJFG+fN
G6byvCVA2laUh1zWYdwz0nYKbium5P6OrhWgla7wLQg03mNg674=
=ZeU6
-----END PGP SIGNATURE-----

--eqwy3ejb2icsufuc--
