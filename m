Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeCEScF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeCEScE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:32:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8230C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 5 Mar 2018 18:31:58 +0000
From: James Hogan <jhogan@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 8/8] MIPS: jz4740: Drop old platform reset code
Message-ID: <20180305183157.GI4197@saruman>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-8-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20171230135108.6834-8-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2017 at 02:51:08PM +0100, Paul Cercueil wrote:
> This work is now performed by the watchdog driver directly.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdjR0ACgkQbAtpk944
dnrXCBAAqbAXly/TPoIHI8GzFZRLzM/t1VZBJR1y4DsyrFdylavt8+0ayRLf+zOc
SRG94UZftjLHUuxuqsmyHzq3KMrbh/xrPvE2l4UJf+kBgclRr+R84rsWjf2FSywk
4+Vik/HNRXMslNVla5tGHLRLG65Wzj5FW6AFeY1ib+VLh4rUi9eQFx6rtBuDq3f5
JX/AMHEdjybSisqaRcxlIir9rl6vxF/hziqc7XicOjF7tuq5NSxwUolhr7zeXYvH
u6WR0L89GjOOK92fWO3t5wxUo2ELC5YWRdFg45PwgxS7xfrcfM4rLTRtlkArc2WC
BYF+RHGT8G3seocfafYzrFGBzNfP6QE5Z+e0aGpLdVCn9TGt2JKYssYVsBcHZ+M3
nEoWwHUYyt/lfTnFbFpBo6iOYK5d5ULvoGTDLFVghe87xQp58/JSSSyhqrGBIMvH
FHYVuELdKCqiy3khn+uSIBTkUkzjXEsp1QcSC3PBoGKjkPIMKizKNfYBktGKdGld
DecC0Hza2Si/SAHddh72Ew5zxSKbfgwgblDjnsWEEmpt26NoFhKI1S3RFmmBOcq5
Uhf1Lv/TqbEuVL75lckhqo5Ux9BDyrYSSDq9d/fY9ud2U6VFIArOEoKmf5Dasx4G
qaXQWtR+7/BWjhUD9CK2WTpF+Mc0s1aNxEFRe5kH56BcUAPpbAo=
=IUUM
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
