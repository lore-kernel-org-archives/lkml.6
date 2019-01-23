Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25C2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323902;
	bh=OVSZxSUWkIRwgNDsl3AduaYKVHTJnA+3QX53cccp5mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GUKASJiBpeLmW868rc4tBZ6RvisRpgVir0mY8ptk/dAJyA9xOsRuOalaXlptzPQsP
	 D1gJf/8jFIu1LjlanoKG7Lk1cru07oNGjsiA2Ft/i5X6MpIMKrfKu2+l8d+hXwWLgJ
	 9rTwEnB6tpgtiqKnmOZ58NHTDPCQ35qSrxy15umM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfAXJ6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbfAXJ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:13 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49554218D2;
        Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323892;
        bh=OVSZxSUWkIRwgNDsl3AduaYKVHTJnA+3QX53cccp5mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gd9H9yTrdPdaj98sijV/fVBFgS64ffigxVj346XrZnexEWJmgPL8uYZKVbKGQeEQ3
         /rWUJ7d15lIycQ9TwJ76ST+pE9WDRBVI2s/iOURbViDH1AKrgCFxlFi2mHsezb4Pqo
         aUijYM/dxN2cD6bxIcUFdsdm3I/z3d4VI8m9ktYI=
Received: by earth.universe (Postfix, from userid 1000)
        id 587003C08E4; Wed, 23 Jan 2019 21:27:38 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:27:38 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: power: sc27xx: Add one IIO channel to
 read charge voltage
Message-ID: <20190123202738.m6btovysy73i6i3o@earth.universe>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppg2kqqkzwzvt4n3"
Content-Disposition: inline
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppg2kqqkzwzvt4n3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 15, 2019 at 06:32:34PM +0800, Baolin Wang wrote:
> Add one IIO channel named "charge_vol" to read the charge voltage for
> the SC27XX fuel gauge controller.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, patchset is queued to power-supply-next.

-- Sebastian

>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt=
 b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> index fc35ac5..0a5705b 100644
> --- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> @@ -9,8 +9,8 @@ Required properties:
>    "sprd,sc2731-fgu".
>  - reg: The address offset of fuel gauge unit.
>  - battery-detect-gpios: GPIO for battery detection.
> -- io-channels: Specify the IIO ADC channel to get temperature.
> -- io-channel-names: Should be "bat-temp".
> +- io-channels: Specify the IIO ADC channels to get temperature and charg=
e voltage.
> +- io-channel-names: Should be "bat-temp" or "charge-vol".
>  - nvmem-cells: A phandle to the calibration cells provided by eFuse devi=
ce.
>  - nvmem-cell-names: Should be "fgu_calib".
>  - monitored-battery: Phandle of battery characteristics devicetree node.
> @@ -47,8 +47,8 @@ Example:
>  			compatible =3D "sprd,sc2731-fgu";
>  			reg =3D <0xa00>;
>  			battery-detect-gpios =3D <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> -			io-channels =3D <&pmic_adc 5>;
> -			io-channel-names =3D "bat-temp";
> +			io-channels =3D <&pmic_adc 5>, <&pmic_adc 14>;
> +			io-channel-names =3D "bat-temp", "charge-vol";
>  			nvmem-cells =3D <&fgu_calib>;
>  			nvmem-cell-names =3D "fgu_calib";
>  			monitored-battery =3D <&bat>;
> --=20
> 1.7.9.5
>=20

--ppg2kqqkzwzvt4n3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIzjcACgkQ2O7X88g7
+poiSQ//eTUsDovorLNfFNZcdVJl45prcoKfrhJhyu4db1FoCB5UjB3X3mErrTmq
ut2vwv4fY7C/LgLqj+rZA2MyqfWtmHGbRqGP+1TJzRoLgMywCBmCSgwaVM4ZZiKC
woqyp1dRPof9fWCED/SPHs6SQmNF7tkob2qxaE4QioXVq/hhufwGjPrH/Bd7Z7YW
+LCgjnEMVr/fpEAI8hzzuAb1M4JMzFvrOCm6ZP82jdyqxhnGWESRF195Z2tARFab
4xMTHZMH34mGIINsWnvxZXqNsYUMe6/JIIIDKDswK7PE9J+tW4KH1nJth5FCxCEs
dZgMw6nXVY99D3lFqKwdv6/4+/QAV+OB/+Wwko/0zRvWHPagb+Ve2VwRknnHni+b
7ZzXRH2WcJ3Zuu5tXVQIScoXaURB3PDwnKS+9t+MoaTEeEJpCKimfIBU2qxiBhUs
i0Y8Q2Muy8FWa6e8CKw3CpuTHgLx3TMQEJcw0auhIPHH1B5jTMrbnLuHHHqPomC2
PN58Eb3KZm6V+paI/21Lds0O1VVs7nHQbVwR2bgAE3zjFKT6eGc4bqDa/53caW1Z
DE5ClrcPYfqXkVU/uU6r2ugQIxT6wx3l72Bk4kTwiKpKo3xLk4UXQzVnXfyQ7+Gu
FKmstQ4INfKxVopgcxqltjdVqPEQvASQWZdIde/gbYCAtNzKgu8=
=jsuy
-----END PGP SIGNATURE-----

--ppg2kqqkzwzvt4n3--
