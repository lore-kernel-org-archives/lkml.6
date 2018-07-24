Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164EAECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30B520875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30B520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbeGXOAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:00:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59537 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388297AbeGXOA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:00:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C36EA2093A; Tue, 24 Jul 2018 14:54:06 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9166020756;
        Tue, 24 Jul 2018 14:53:56 +0200 (CEST)
Date:   Tue, 24 Jul 2018 14:53:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     stevenvandenbrandenstift@gmail.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] sun4i: dts: add gpu node to sun4i-a10 platform
Message-ID: <20180724125357.g7dddqwjouwv2dnj@flea>
References: <20180723160954.14115-1-stevenvandenbrandenstift@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nhgclqhun6yotmsy"
Content-Disposition: inline
In-Reply-To: <20180723160954.14115-1-stevenvandenbrandenstift@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhgclqhun6yotmsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 06:09:54PM +0200, stevenvandenbrandenstift@gmail.co=
m wrote:
> From: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>
>=20
> Add mali gpu node to sun4i a10 platforms.
> Tested with offscreen rendering with lima mesa (freedesktop gitlab)
>=20
> Signed-off-by: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>

Applied (while slighly changing your commit title, the prefix should
be "ARM: dts: sun4i: ..")

Thanks!
Maxime
--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nhgclqhun6yotmsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXIWQACgkQ0rTAlCFN
r3RoVQ//cKcHuxcfdpqlLhIhlcQaF1M9s9HWJ9GmB/dOLW1LWKMd+tdSMgdVG0iY
VrG47xQDhNjAnYoJzRaEFZqtSqLX5QsbvXhCk29AUoXbo2f6wYvq+nr7cj74PJoj
N587uwjoqFBK/MTb/n2C0r0bZRWLMbcbe2iE6pu+kmQQsUS5eB0t7LShT5AtIBIo
9ZN03BAzo1OyihjRGiqdf9z5ZcNI5ChkPjBQoedBm+S+urHydl1Odi5wgp2vDsby
gcQc5+6RfHSYO7pCA3us5j7/t35YLR9xwQIgY7ep6HzfKz96oQ+AX1PSOmvGSrHU
VjhsrcbLmVySHEnYBikLN35E6QbTc4JDgB0PbjXZWgZ9luwubPSY/oR+9aS2C4Rd
I1RBuKZRhIm02rRIwF5diBpFBv5PoZNXLnGNvTPsxow/pVGKz2FQKUA1FHBP7c1V
kgw7t9StPPAv4J7Stwk3U+E73QBrGoZHIOdwFyEGjll1JCh4BTIL9YhvAM8Ihh9+
YEu2Yo1UbkMTEA1PImIC8qwFLQY1RacD76YIp2iPsqbKp1aaNzzAjFn8w5LZck92
MFFtRzm0sZPj1WKViEIbmCa/SLcCf7ZFyurnuspdTDiAzM500bWlVu2YemCP+fDy
JWJ/QCjzUQwCKVjGCggaHhIDg5+p4GITkt9EMgLmUM4CuZSwUBo=
=b4HL
-----END PGP SIGNATURE-----

--nhgclqhun6yotmsy--
