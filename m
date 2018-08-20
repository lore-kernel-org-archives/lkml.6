Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40809C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AE721581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AE721581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHTQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:12:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40345 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeHTQM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:12:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9198B20703; Mon, 20 Aug 2018 14:57:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id A3E6420DEE;
        Mon, 20 Aug 2018 14:56:45 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:56:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Tuomas Tynkkynen <tuomas@tuxera.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: sunxi: Don't use cd-inverted in
 sun8i-r40-bananapi-m2-ultra
Message-ID: <20180820125646.z5lsdczc5maf7vyu@flea>
References: <20180807232554.16825-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t2lseczjazydlsib"
Content-Disposition: inline
In-Reply-To: <20180807232554.16825-1-tuomas@tuxera.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t2lseczjazydlsib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 02:25:53AM +0300, Tuomas Tynkkynen wrote:
> Another user of cd-inverted seems to have crept in. Switch it away from
> cd-inverted to be consistent with other sunxi boards.
>=20
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Queued for 4.20, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--t2lseczjazydlsib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6uo0ACgkQ0rTAlCFN
r3TiHw/9EzjEe8Oida7uxehd3cudPL4GqPV/kN8/JMBpzZ9Sc1gBcLMzutQ3pgwM
f5QLKCvim+Qu1CjX/OsT2QVOFTX251GWhyhOR7CNZCN+VrNdrLXcfOUFbyT/8CLa
/KToXG+T4pJi8S4Yk8qbAZN1SLI8w9f3laLhEBdNZ8IRdFavVQ9vUPblNWdazYyH
aCHCNUjI9rsZNZKeebB4TRUXCZDZdHmcpqX/uR19rx+vOFUH3d6hLvZhp9UzSHn4
g48QbTsjJ3dbXRwGo9O11Aa8Fu3wk3D9pfkDCVeJ4sRffp/aDpl5BE1BVzliFMWP
unuD5YufvbzCG5HWrV0e8DS8X8OHgIXYH5NewO0dg8EArDF3iVCev9w0fOQulfB0
SIvZ6DmDkRbG3tu0wZdoczQStsiQp9BSgbHaORkwSXJl7e7XTsCVnV20jiVfQaSb
Np/KXXtwAaYOPwfftutmkU5se9v3mYM9cMENtAZZ1an6xEQVTg3Sn8QupP3NYcdn
koB7RDHd8cC+Nrz128ty3XAfn+o15gs7ctAHJsuwRC1AgObQwE2InO66gTQBpyMz
dlRMoRpCDLuUmmgBLcRcB4idR1rnbv9tJIWWsu9mqztsB0W/WZBUbGodwiuoVIxx
/QGvFpqB43n7LYPzTPM2QFCYMrpVHjMJZunOE2yswgEkWbPIjO0=
=2dWH
-----END PGP SIGNATURE-----

--t2lseczjazydlsib--
