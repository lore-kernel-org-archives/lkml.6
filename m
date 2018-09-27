Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3BEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2761A2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2761A2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeI0NC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:02:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeI0NC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:02:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 81A282610C7
Received: by earth.universe (Postfix, from userid 1000)
        id 089B73C0892; Thu, 27 Sep 2018 08:45:39 +0200 (CEST)
Date:   Thu, 27 Sep 2018 08:45:39 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh@kernel.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v2] dt-bindings: input: pwm-vibrator: correct pwms in
 example
Message-ID: <20180927064538.i2omgznbtc473azt@earth.universe>
References: <20180927004858.32529-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltl6bamnt433u7ig"
Content-Disposition: inline
In-Reply-To: <20180927004858.32529-1-masneyb@onstation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltl6bamnt433u7ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 26, 2018 at 08:48:58PM -0400, Brian Masney wrote:
> In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
> and pwm9 is the enable pin. The pwms on the vibrator node has these two
> values swapped so this patch corrects it.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>
> Changes since v1:
> - Swapped the pwms values instead of the pwm-names values since enable
>   is required and direction is optional. Based on feedback from
>   Rob Herring.
>=20
>  Documentation/devicetree/bindings/input/pwm-vibrator.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/D=
ocumentation/devicetree/bindings/input/pwm-vibrator.txt
> index 09145d18491d..88c775a3fe21 100644
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> @@ -58,8 +58,8 @@ Example from Motorola Droid 4:
> =20
>  	vibrator {
>  		compatible =3D "pwm-vibrator";
> -		pwms =3D <&pwm8 0 1000000000 0>,
> -		       <&pwm9 0 1000000000 0>;
> +		pwms =3D <&pwm9 0 1000000000 0>,
> +                       <&pwm8 0 1000000000 0>;
>  		pwm-names =3D "enable", "direction";
>  		direction-duty-cycle-ns =3D <1000000000>;
>  	};

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

 -- Sebastian

--ltl6bamnt433u7ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlusfJIACgkQ2O7X88g7
+prMEQ//V1+b8d+LMKId888ISnvHlOyKkQUYNw01wVPPnL5Mq6L36GRyxHYVIeNM
Fh3wJ1bJgvFBteUcnmf0sIZGVtHY2UYLjMWeq/21HLho33LH0SxNADAnjsFXKpfB
binP67E7Q50NXPPCJqoNUIGWAY0pcMY1lZG2gQpgpxSNOQErcw6K+Y2xToUvAaz1
+vhhaxiv/f69Jm4+7+w8IMpTliwvflAyOaFp3QOJjoFppSNKlO/fS6owdtTtoou1
n6twlYbOUKKL+gO1YHMbpZdBEhCmk/nmk6r5jewJ2WuvcS95SF5Pl3Gv5xTZII3W
Hj/omVkY1QA454Ch1SzjIIQCEVmtN2P+X8J6evI1BubisVAqiWwZJYjPnjDgRzNm
f5ZQGPBxuPs+yzdU2YksXaZoqI+GO155H2jkYO6me90W06gyVHdma9ip7e0o0F+W
Mta91zYwI3s02wbs4lltoop5Co5Z1CqZt+LDqIKcnJxafJPOk+4+D4+4G9MjKDh8
1bXRNc5vpV4bgrT+OL05LnLVGLT4s6zMIPTi9HvV0WQjBnXTdi1W49Pbak5+SiJ2
BXOAvbffPW7/C+Q6QBWGPVxqGJnb2KkE5tAT4bBagF5k3DswCov+tUxI3mQD3gop
1dbOuUL1g7HgGvCZNl1raaQqICM+tJa+z6l4/sujFEs3GWCedIw=
=JKan
-----END PGP SIGNATURE-----

--ltl6bamnt433u7ig--
