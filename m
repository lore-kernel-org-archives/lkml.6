Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC390C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9EF2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9EF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIELyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:54:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35314 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeIELyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:54:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7C8A20789; Wed,  5 Sep 2018 09:25:30 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id BA04920787;
        Wed,  5 Sep 2018 09:25:20 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:25:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, hdegoede@redhat.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <20180905072519.wx4wgdklinyysad6@flea>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6745kah5qjzlfyb"
Content-Disposition: inline
In-Reply-To: <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6745kah5qjzlfyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 08:26:22AM -0600, Jens Axboe wrote:
> On 9/3/18 4:01 AM, Corentin Labbe wrote:
> > This patchset add support for allwinner R40 AHCI controller.
> >=20
> > The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> > on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> > by this serie, so no regression should come with it.
> >=20
> > Patchs 1-7 should go via the ata tree
> > Patchs 8,9 should go via the sunxi tree
>=20
> Applied 1-7 for 4.20, thanks everyone.

Applied 8 and 9, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a6745kah5qjzlfyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPhN4ACgkQ0rTAlCFN
r3Ry7g//bEl0ixbL05/u0O/rl+o7lYAP4RAA81+H0Rjl+nimlCgoEyy9+VUpwOzC
MZ6QiukAUOP/973rVXjV/6aiHFBdJvlpkMde/NgTXlJ2t6hfRfSGvT/Ldtpm/y5z
3OH9q24TWc/ITnWIQWh3FpSkJst+hS+aqdw3Ec3nUjIngdcdjjdwndXFx9EfuT2l
52WN01oOVpC3w2NFfkj02viu9rMTjoBg+u4rqh/aLtTrr33Poy9wpiorje8FDOfU
x4lRwHQb6GLDDGG6TBui7ZNwTCi56bInFRqB0i8p86sBCK+Xb9o+BlTqP5elSS7c
PQI6nBfbSicY6QVgOKWv30inFIGvqWkqRBup9JjKh3gu3iVZ8Y0Qdp6dBwvN6RWh
mjOJBiHACiLks39ycZV8jxurvu/dS0SKwEJPnFewbrkGaTnssUdzMpjXjIraOQBP
fE0+m16W3gM/rgbRQ7QIndU0bF5glAzauGrM3EqY7318f/nwnnyuQWtu0eoH3q2L
6acZtQMyAhaRiC9lgPGSmQrERMm9aIeoMYIpp0zmSZhTgDQNwalmvMgcjtmAXUGD
rwCMHLdR9vf1JLgVVjDKeHAdP9hOA1Ew45V+CI2qMmEKV+28zpBBS2lcEsNqGgeE
fuwNKUNz1oYIg5Ob3QNTnLCghrphIVc29ZF40uu7ewT7r4VCwPg=
=vSRP
-----END PGP SIGNATURE-----

--a6745kah5qjzlfyb--
