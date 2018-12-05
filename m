Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC3CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BEC20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BEC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeLEV4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:56:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51520 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEV4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:56:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DF34526A028
Received: by earth.universe (Postfix, from userid 1000)
        id 7ED013C08D6; Wed,  5 Dec 2018 22:56:24 +0100 (CET)
Date:   Wed, 5 Dec 2018 22:56:24 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 3/7] power: supply: bq24190_charger: add of_match for
 usb-otg-vbus regulator
Message-ID: <20181205215624.gyvfuj77givf7kp6@earth.universe>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhn2t7rc6fbpxv2l"
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-4-masneyb@onstation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qhn2t7rc6fbpxv2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 08:11:45PM -0400, Brian Masney wrote:
> From: Jonathan Marek <jonathan@marek.ca>
>=20
> This patch adds an of_match for the usb-otg-vbus regulator to
> bq24190_charger.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 44d3aff32885..9e7f3e33458a 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -577,6 +577,7 @@ static const struct regulator_ops bq24190_vbus_ops =
=3D {
> =20
>  static const struct regulator_desc bq24190_vbus_desc =3D {
>  	.name =3D "usb_otg_vbus",
> +	.of_match =3D "usb-otg-vbus",
>  	.type =3D REGULATOR_VOLTAGE,
>  	.owner =3D THIS_MODULE,
>  	.ops =3D &bq24190_vbus_ops,
> --=20
> 2.17.2
>=20

--qhn2t7rc6fbpxv2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwISYgACgkQ2O7X88g7
+podGw//XYTuTWwcY1PVw5xHr+UgRZpye06oGqCwAneRo08uj+G+3Sh6qZ+8hTIu
Ee7Vs2Hf/x6LmdlOWWI5J+7BYzlfCCYeBUKtBIVDupk1m4BtT1Nf5pMTlWugA4fy
/JzDPd1FMkzDQdAheS/24/EuQKaU/c+9rYlGpF8aaFyDb77FLZ8t47Jm8FC8qMzW
srIA5ZM6Rd1wYC8AkqtvGG5MJN9cMwbBjhCff5qxC61duwWNx8b/WMZZ0F85OCT4
kt6lMuACLt9dz3U93eMZgJMugHAGzFdn7NQOpOEbJZ6EHWz6NnKOWuXhppyBb60j
2dgMKLQwqv2Or/QwMoqEJQR18tCrcSFPsk1YJF3UuQ8cy9EkKyHqbvF9apSxpZOC
89Cbv4rPxVdq0YY7WpwDYpWCQFxED2+vUEWLoXU5obScgogcqbvo5fJtKldJZCDy
rPJ1OKYQXP45lz/pn+5fUSb3bwkIu+DNg+RmsE0rcb72+6yLFYLyyUrHI4tXdQYk
1vRcx5D0IBytIrB8mbfqYcy/6fSiJBZDoEQFmFTGwmgNHaDmKP32NwsqfSRoxFgU
9afubfPNr/5fhDRUBmSQd0qzooWgt5G2sk6Pv6msuJWNTuR41xivQ/BSkzt//Fmq
PyIcLNRscDkO63r4mGsJfufRPP7/jw0gpdP9v0Oz5WnnkGsdSdk=
=tknY
-----END PGP SIGNATURE-----

--qhn2t7rc6fbpxv2l--
