Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E122077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E122077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbeIGQED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:04:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39340 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbeIGQED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:04:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0C6BB20726; Fri,  7 Sep 2018 13:23:32 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id D3E402071D;
        Fri,  7 Sep 2018 13:23:31 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:23:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: Re: [PATCH v2 0/6] drm/sun4i: Support color dithering for LCD panels
Message-ID: <20180907112331.wjml25rfkyabvwwt@flea>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ovgveniivb2j72j"
Content-Disposition: inline
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ovgveniivb2j72j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 12:19:42PM +0800, Chen-Yu Tsai wrote:
>=20
> Hi,
>=20
> This is v2 of my sun4i-drm LCD color dithering series. v1 was from back
> in April [1]. Most of the driver code is unchanged.
>=20
> Changes since v1:
>=20
>   - Explicitly list properties from the simple-panel binding that apply
>     to the Bananapi 7" panel
>=20
>   - Moved an incorrectly squashed change from patch 3 to patch 1, where
>     it belongs

Applied the first three patches, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3ovgveniivb2j72j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSX7IACgkQ0rTAlCFN
r3Ra6Q/+PzbW6bvBRNqHKh7wxc6gIuUb/nNG0RKX8ACK4XoPw93zbi5MS9YDZR5v
CdOKmhXUhsfLkrYfbI4fNecoreEOcvS+LlngIOgcfVHOB2dTt0F/WpPMdmqxU6aK
V//F8db2pbkSmjG6R7ShG6AHNlC5NRiSBA1NWKae/BuqxrBd0zYcsKy2IXlWx2CZ
YrW81zJvBzQHkV8ghK0+Zm+zxZfqPnCLj0hwa+PMSHX0px+UAW2FZjj2NlVX2tKz
83trNrY+ICVoGjlULFJSXR5scGtPlHMIWxmJ05Zoqo/a+M5x2vr9zxbgc4IaX9xk
HQRrctOHnU4s4YBL48hxXvyGDMshDJkzFecHFJuLWsOudqkSQfAYegFqBetdmZzx
T5bdL/u1sDR6kLgEWUkhhCtez7szCPF/EJMT+MezKHP1uCM2J/o4k0HXWZzpz9ex
ijXmKey5rd+2SQI7UQQeokngITaLYYPcBzP95rPE1aBE9RBrXaTPaYAcGIht06nA
jISsykxv7B+pUrLIMJn4Xq9DA4lGGMu8bWediqOqGofeTuBCOzmqKdHNDzAVBZri
gdlPVLT/2+1AqvXCidjJ0ShT22oXGFZIXEdYNpeLce/1aZg4Ym/rHkw12TsRAXbn
+VS/Bmqj3nUbtNLBC4GdImZKxajPl4vWqY5/DOIOFlNz6zBOun8=
=TShe
-----END PGP SIGNATURE-----

--3ovgveniivb2j72j--
