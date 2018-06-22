Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEB5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6C023F3A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6C023F3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeFVI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:56:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52456 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFVI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:56:22 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41Bsqm6kwGz1qwC5;
        Fri, 22 Jun 2018 10:56:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41Bsqm5RRYz1r3lb;
        Fri, 22 Jun 2018 10:56:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MIPmv5cR5Xyd; Fri, 22 Jun 2018 10:56:19 +0200 (CEST)
X-Auth-Info: K+reR86bJPxDHCTyNlJSinVblTW52nDj2zDA1CUTplQ=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 22 Jun 2018 10:56:19 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:56:05 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] display: panel: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20180622105605.3018453c@jawa>
In-Reply-To: <20180529150528.22136-1-lukma@denx.de>
References: <20180412143715.6828-1-lukma@denx.de>
        <20180529150528.22136-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ve=Gn5zIf4rJpd+mqZ9Yc51"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ve=Gn5zIf4rJpd+mqZ9Yc51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

> This commit adds support for KOE's 5.7" display.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2:
> - Add Reviewed-by tag

Could you apply this patch to your tree?

Thanks in advance,
=C5=81ukasz

>=20
> ---
>  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42
> ++++++++++++++++++++++
> drivers/gpu/drm/panel/panel-simple.c               | 26
> ++++++++++++++ 2 files changed, 68 insertions(+) create mode 100644
> Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> new file mode 100644 index 000000000000..be7ac666807b --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> @@ -0,0 +1,42 @@ +Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x
> 240) TFT LCD panel +
> +Required properties:
> +- compatible: should be "koe,tx14d24vm1bpa"
> +- backlight: phandle of the backlight device attached to the panel
> +- power-supply: single regulator to provide the supply voltage
> +
> +Required nodes:
> +- port: Parallel port mapping to connect this display
> +
> +This panel needs single power supply voltage. Its backlight is
> conntrolled +via PWM signal.
> +
> +Example:
> +--------
> +
> +Example device-tree definition when connected to iMX53 based board
> +
> +	lcd_panel: lcd-panel {
> +		compatible =3D "koe,tx14d24vm1bpa";
> +		backlight =3D <&backlight_lcd>;
> +		power-supply =3D <&reg_3v3>;
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint =3D <&lcd_display_out>;
> +			};
> +		};
> +	};
> +
> +Then one needs to extend the dispX node:
> +
> +	lcd_display: disp1 {
> +
> +		port@1 {
> +			reg =3D <1>;
> +
> +			lcd_display_out: endpoint {
> +				remote-endpoint =3D <&lcd_panel_in>;
> +			};
> +		};
> +	};
> diff --git a/drivers/gpu/drm/panel/panel-simple.c
> b/drivers/gpu/drm/panel/panel-simple.c index
> d9984bdb5bb5..103b43ce7dee 100644 ---
> a/drivers/gpu/drm/panel/panel-simple.c +++
> b/drivers/gpu/drm/panel/panel-simple.c @@ -1268,6 +1268,29 @@ static
> const struct panel_desc innolux_zj070na_01p =3D { },
>  };
> =20
> +static const struct display_timing koe_tx14d24vm1bpa_timing =3D {
> +	.pixelclock =3D { 5580000, 5850000, 6200000 },
> +	.hactive =3D { 320, 320, 320 },
> +	.hfront_porch =3D { 30, 30, 30 },
> +	.hback_porch =3D { 30, 30, 30 },
> +	.hsync_len =3D { 1, 5, 17 },
> +	.vactive =3D { 240, 240, 240 },
> +	.vfront_porch =3D { 6, 6, 6 },
> +	.vback_porch =3D { 5, 5, 5 },
> +	.vsync_len =3D { 1, 2, 11 },
> +	.flags =3D DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc koe_tx14d24vm1bpa =3D {
> +	.timings =3D &koe_tx14d24vm1bpa_timing,
> +	.num_timings =3D 1,
> +	.bpc =3D 6,
> +	.size =3D {
> +		.width =3D 115,
> +		.height =3D 86,
> +	},
> +};
> +
>  static const struct display_timing koe_tx31d200vm0baa_timing =3D {
>  	.pixelclock =3D { 39600000, 43200000, 48000000 },
>  	.hactive =3D { 1280, 1280, 1280 },
> @@ -2204,6 +2227,9 @@ static const struct of_device_id
> platform_of_match[] =3D { .compatible =3D "innolux,zj070na-01p",
>  		.data =3D &innolux_zj070na_01p,
>  	}, {
> +		.compatible =3D "koe,tx14d24vm1bpa",
> +		.data =3D &koe_tx14d24vm1bpa,
> +	}, {
>  		.compatible =3D "koe,tx31d200vm0baa",
>  		.data =3D &koe_tx31d200vm0baa,
>  	}, {




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/ve=Gn5zIf4rJpd+mqZ9Yc51
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlssuaUACgkQAR8vZIA0
zr1B8AgAgQ9gEpUy+yOfpgwF+O5MBD9fJkSXUwJf34Eae3SXVeUjdkRXi5794FBV
8HaqddGXris9dLQk1I3mbKlgAu0bUctJB73e88ZECaXeOtR+H7teAwkDEJhGkG88
PZGRvA5Sf7z8efPfJzXLCjLYWje/6cP12162xQKuS+lDl0qKC+0kl1RMtWA4S9uC
S+gSN8doTyjg4SGrukKIsN734zHYpqo7GAkEgc3jMRcn63kFBbEMAg3dngOXpuN7
aGUuHi7AjwOSK+J6EdB06BC53hiFWkRkZMtZCwFbKjmoast3YRhDeaBwj2ey5/2F
m/C91SMvdIJhN7YAcDWQZ+QzeM3TCA==
=CQCq
-----END PGP SIGNATURE-----

--Sig_/ve=Gn5zIf4rJpd+mqZ9Yc51--
