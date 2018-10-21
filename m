Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0026ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634C020658
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAXo3pXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634C020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeJVDm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbeJVDm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:42:28 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4A32083A;
        Sun, 21 Oct 2018 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150027;
        bh=sv/Y108eq/xLiUeAJj6VVEDfsF9PV00K2pQI0ixBsek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAXo3pXGqBOTAUGgUXzgXUNo2Dz2mU+N48ygT0KnH+77ED+q6VeHEeo/w2MfdWhkp
         3aNvYRcSbdqO1AnvPjnQXtsErlBsQt+icAnPNnEjfvWsMlhokicRAy5MZCaeThHvjn
         puZPYP2CDAJOavzIpVCD1v/Tl4qRdkZ8mChqXl5g=
Received: by earth.universe (Postfix, from userid 1000)
        id AEF9A3C0997; Sun, 21 Oct 2018 18:27:29 +0200 (CEST)
Date:   Sun, 21 Oct 2018 18:27:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v5 5/6] dt-bindings: power: Add Spreadtrum SC27XX fuel
 gauge unit documentation
Message-ID: <20181021162729.a6wf2x5a54vtkqha@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <14b947c6195133ed93cf0302b1575c033c4ccf04.1539915051.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjcucz36wvptpzwu"
Content-Disposition: inline
In-Reply-To: <14b947c6195133ed93cf0302b1575c033c4ccf04.1539915051.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bjcucz36wvptpzwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:14PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series PM=
ICs
> fuel gauge unit device, which is used to calculate the battery capacity.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v4:
>  - None.
>=20
> Changes from v3:
>  - Add reviewed tag from Rob.
>=20
> Changes from v2:
>  - Add reviewed tag from Linus.
>=20
> Changes from v1:
>  - Renamed GPIO property.
>  - Use standand battery properties instead of 'sprd,inner-resist' and
>  'sprd,ocv-cap-table'.
>  - Remove battery node's description.
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   52 ++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx=
-fg.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt=
 b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> new file mode 100644
> index 0000000..98a2400
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> @@ -0,0 +1,52 @@
> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
> +
> +Required properties:
> +- compatible: Should be one of the following:
> +  "sprd,sc2720-fgu",
> +  "sprd,sc2721-fgu",
> +  "sprd,sc2723-fgu",
> +  "sprd,sc2730-fgu",
> +  "sprd,sc2731-fgu".
> +- reg: The address offset of fuel gauge unit.
> +- battery-detect-gpios: GPIO for battery detection.
> +- io-channels: Specify the IIO ADC channel to get temperature.
> +- io-channel-names: Should be "bat-temp".
> +- monitored-battery: Phandle of battery characteristics devicetree node.
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +
> +Example:
> +
> +	bat: battery {
> +		compatible =3D "simple-battery";
> +		charge-full-design-microamp-hours =3D <1900000>;
> +		constant-charge-voltage-max-microvolt =3D <4350000>;
> +		ocv-capacity-celsius =3D <20>;
> +		ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>,
> +					<4022000 85>, <3983000 80>, <3949000 75>,
> +					<3917000 70>, <3889000 65>, <3864000 60>,
> +					<3835000 55>, <3805000 50>, <3787000 45>,
> +					<3777000 40>, <3773000 35>, <3770000 30>,
> +					<3765000 25>, <3752000 20>, <3724000 15>,
> +					<3680000 10>, <3605000 5>, <3400000 0>;
> +		......
> +	};
> +
> +	sc2731_pmic: pmic@0 {
> +		compatible =3D "sprd,sc2731";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <26000000>;
> +		interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		fgu@a00 {
> +			compatible =3D "sprd,sc2731-fgu";
> +			reg =3D <0xa00>;
> +			battery-detect-gpios =3D <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> +			io-channels =3D <&pmic_adc 5>;
> +			io-channel-names =3D "bat-temp";
> +			monitored-battery =3D <&bat>;
> +		};
> +	};
> --=20
> 1.7.9.5
>=20

--bjcucz36wvptpzwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMqPEACgkQ2O7X88g7
+poe1xAAjmr4C6QHN0bfOsVqTEesbiF5VMwxknBbssBOO/+gE4deNLdKdcaPnVuD
7pm2JXHd1dnb445SMo3a7DXtVObI9fSB+oSeBlhlgfXLfGwcQwrj9aNxIVDUu2wl
1PqLkqwZG72TMJPDHbhW+0w0grruEN0/wytnPgZzz7JKAVLg3sQsv0uzai8RceDU
huHt9XBRancR7fPWrCNwCk0fTIC0vT80QCEapLUWeGVG0SKUVyAxiOCFFtg0jpJL
N8YlI3Ax3upTY1q1LSBtETy8wNravokVSQsOB4d3+DEz+Zxdm7Yh3WKYe3gRGw4u
2GGUEgbPgvi1O24baFx4J4c805hV8X2sENfFh+fVw0CUfMJrG8VTDHCo2OJZl5Yq
unmtt7mXrSabqTmR/cyoKW1nrs12hriP3YCVgjm8GABnug1x+Zih32AqlUl+DesX
wdxzZ810USb8FmZnRw3QPwpBQBzaY/M7XLDC9iEtGn9vviHJv7xCSxxyUBmnL6uM
1mffLu2G2OPzRWkl7wRoeI/vQ1n6/XYZjaDuFiNDOHqiqzzi9YK4vs/KB/ec4SGm
/ehEym4/rGKnuhUpao2STbeGbjeynhd96XcVZSSGXTzscpoDLbM9srocPXDT+g/6
bqoIGbHFNW61MpEODdlo1coe8NMFsaogyagprhPWA+uU7K4b+Z0=
=6j8X
-----END PGP SIGNATURE-----

--bjcucz36wvptpzwu--
