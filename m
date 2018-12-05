Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73442C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F3208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394F3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeLEUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:53:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51118 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:53:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1E16A263BF7
Received: by earth.universe (Postfix, from userid 1000)
        id A5E8A3C08D6; Wed,  5 Dec 2018 21:53:03 +0100 (CET)
Date:   Wed, 5 Dec 2018 21:53:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 11/17] dt-bindings: olpc_battery: Add XO-1.5 battery
Message-ID: <20181205205303.3zx3ap7jfkah7ruw@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-12-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmx6qoxsqzvhfohm"
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-12-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rmx6qoxsqzvhfohm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:23:57PM +0100, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v1:
> - Collected Reviewed-by and Acked-by tags
>=20
>  Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.=
txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> index c8901b3992d9..8d87d6b35a98 100644
> --- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> @@ -2,4 +2,4 @@ OLPC battery
>  ~~~~~~~~~~~~
> =20
>  Required properties:
> -  - compatible : "olpc,xo1-battery"
> +  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"
> --=20
> 2.19.1
>=20

--rmx6qoxsqzvhfohm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIOqwACgkQ2O7X88g7
+ppsMhAAqjiRTWfR/LVjMsfkcZ5JT7Tcsebbmp6IX5H2SJpq1hrvsdgvmNY6zU7x
jo39BY06Oi36yy1kUTdFy5uuQUZNNGK2lIr7PX7eL1pT9BAcevho3EepyYB3XRTV
oz8jyGSXSAVLvyRQDFDlIIyR9JGxJMFEo01rxiT3r1BgD62wAFFdpG3K3FQcCapK
ylw96V9Uo4RdWKkv6dfN9MkHItrIKWNzIAN22AxGDSHkCjY0E7vYNjyZlK1TE/q4
cBz+HOaPqpHJ2S1II0aD/U1bxFE/rBPmmqBWE/HEyQTi4m1Qvt3hHPxvuZpWw2ZD
98fWeaPtu7a9BLy7MPRV6Tj3w2bjSFmhInfCWnfkfWgzrDl/oCExWtNPPezaO6Dl
mdpaROkN6Kuhj0mcbwTgeJAchxto6kqblZQQO6LnE6dmbKp728+ZLgks1EMM/8WS
cXf2s/hPfvrqmltcgWk5Fe6bp+ZNw7fPMHOzfCRjRp0HmQyOGF28TagWfZ94HsVH
tB9oL8adIELEs+lVdjjsYAqeE38TKu8Qhd6VquCj+6S1fHT5gjIcfKH+0z/iEHom
2PHa6VjiCglckFaSsLzyh8ehjPUSYjWZbPOWkPYBhNPivNM54YajuTxSnm3nYvCa
+hF1KixgZ3ZTK4KhYWKQgKHP14GxpCT98OAV2VFKYk4LgM515/g=
=AmUH
-----END PGP SIGNATURE-----

--rmx6qoxsqzvhfohm--
