Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A51C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AA320882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfA3J3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:29:32 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:47869 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfA3J3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:29:32 -0500
X-Greylist: delayed 66919 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 04:29:30 EST
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C75B1200010;
        Wed, 30 Jan 2019 09:29:27 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:29:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
Message-ID: <20190130092927.x65ihy3je5n6324w@flea>
References: <20190130084203.25053-1-wens@csie.org>
 <20190130084203.25053-11-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fkao57vkiawei5pc"
Content-Disposition: inline
In-Reply-To: <20190130084203.25053-11-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fkao57vkiawei5pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
>  			enable-method =3D "psci";
>  			clocks =3D <&ccu CLK_CPUX>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			operating-points-v2 =3D <&cpu_opp_table>;
> +			#cooling-cells =3D <2>;
> +		};
> +	};
> +
> +	cpu_opp_table: opp_table {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp@408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <1000000 1000000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@648000000 {
> +			opp-hz =3D /bits/ 64 <648000000>;
> +			opp-microvolt =3D <1040000 1040000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@816000000 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <1080000 1080000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@912000000 {
> +			opp-hz =3D /bits/ 64 <912000000>;
> +			opp-microvolt =3D <1120000 1120000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@960000000 {
> +			opp-hz =3D /bits/ 64 <960000000>;
> +			opp-microvolt =3D <1160000 1160000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1008000000 {
> +			opp-hz =3D /bits/ 64 <1008000000>;
> +			opp-microvolt =3D <1200000 1200000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1056000000 {
> +			opp-hz =3D /bits/ 64 <1056000000>;
> +			opp-microvolt =3D <1240000 1240000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1104000000 {
> +			opp-hz =3D /bits/ 64 <1104000000>;
> +			opp-microvolt =3D <1260000 1260000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1152000000 {
> +			opp-hz =3D /bits/ 64 <1152000000>;
> +			opp-microvolt =3D <1300000 1300000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */

What is the frequency and voltage that U-Boot sets up?

We've had the issue with the A33 that it's started at 1008MHz, with
the matching voltage, and ramping up the frequency to 1.2GHz on boards
without PMIC support would increase the frequency but not the voltage,
resulting in a brownout.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fkao57vkiawei5pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFFudgAKCRDj7w1vZxhR
xdeCAQDoubN0q581tiwZf/MzwZJNZ0WbAH/O2srVCbUsx9c9AQEAtB7i30h+fWwp
nA69KJX4vmzX1+aSqHYC43rH6+0KYAY=
=lYRw
-----END PGP SIGNATURE-----

--fkao57vkiawei5pc--
