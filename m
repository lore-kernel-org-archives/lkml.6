Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA6AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847BC2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545000119;
	bh=m7KgBWpXJ9aOqYO8rRDHWzYjt1/4qNWQ4rbiT2gofys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=za3SwzX/85a/fsGK7TylMD2tWd3DLQjMUyT7G8Kfxs0cqpYL2/lvEpYIPdG8Y/R2h
	 OyYYzIiT1ZlB2WkYMyi6ZF5ESEn/7VZZD4GqUkDfvg80kRsYAJvKNRsKU0T3xTHNhp
	 rCzKUVdwm6HQfcvz564Uo9mx9NrmzUP9zmTXf9tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeLPWl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbeLPWl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:41:56 -0500
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C484206BA;
        Sun, 16 Dec 2018 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545000114;
        bh=m7KgBWpXJ9aOqYO8rRDHWzYjt1/4qNWQ4rbiT2gofys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNaaesG0gActvPiUiny2bli3fIjRenc3ccwh9NLNVisGLkUVLJrvlqe06Jjb0LDs4
         USs/YkwZc+UblO9EoD/zH5SZ2DZw+mH9ppsWrKPYje1RHftpjUuWKTXnCeyFymXape
         jaZPt6rUA1qJ4sPB5Vk3MQlUSRMYRiOQ/KxKHRCQ=
Received: by earth.universe (Postfix, from userid 1000)
        id A4A983C08E5; Sun, 16 Dec 2018 23:41:51 +0100 (CET)
Date:   Sun, 16 Dec 2018 23:41:51 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] Input: atmel_mxt_ts: Document optional voltage
 regulators
Message-ID: <20181216224151.h2kmm56a7yxolc2o@earth.universe>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
 <20181214151214.5391-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7k22atdafibz2k5h"
Content-Disposition: inline
In-Reply-To: <20181214151214.5391-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7k22atdafibz2k5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2018 at 04:12:14PM +0100, Pawe=C5=82 Chmiel wrote:
> Document new optional voltage regulators, which can be used
> to power down/up touchscreen.
>=20
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
> Changes from v1:
>   - Added reviewed-by
> ---
>  .../devicetree/bindings/input/atmel,maxtouch.txt          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b=
/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> index c88919480d37..17930ecadad3 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> @@ -31,6 +31,12 @@ Optional properties for main touchpad device:
> =20
>  - reset-gpios: GPIO specifier for the touchscreen's reset pin (active lo=
w)
> =20
> +- avdd-supply: Analog power supply. It powers up the analog channel block
> +    of the controller to detect the touches.
> +
> +- vdd-supply: Digital power supply. It powers up the digital block
> +    of the controller to enable i2c communication.
> +
>  Example:
> =20
>  	touch@4b {
> @@ -38,4 +44,6 @@ Example:
>  		reg =3D <0x4b>;
>  		interrupt-parent =3D <&gpio>;
>  		interrupts =3D <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
> +		avdd-supply =3D <&atsp_reg>;
> +		vdd-supply =3D <&tsp_reg>;
>  	};
> --=20
> 2.17.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--7k22atdafibz2k5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwW1KwACgkQ2O7X88g7
+povFw//QnuluuI9Fs8O+0wOzbZNRmJz+ZafrZSrnt02dgdbdUIkK81lZDigjIoD
MJ4Ai26L3iXAZhHbIWtKQskAJ6AQKirU8pdQ3zdZfeKO7zlChJ8lrnfKCbuUfJ3C
WKiYjvY75ceEwn3RuoNBZ/77WKWxofgSWF67pRoQP43gm800TdIxusBQFonvf5wK
CGLAYRJGzIA74IIg0Y893C1AicrfBoW27AjFvRwF+JdT5c9n4WF7O5lwBbxBh5bK
Zye4XIBg9y9IYBnOGnFkw3BU4k6+YzLfN2qwfGzGoCOjFD4VmOLZF4OUtTd4RUsx
CfwsqU9/FeSQ4mLS92P4pCc6yLpsOOlhOlEfAaIQLcobj+AtJvw9YfX+4gWkY1R9
22FScGbtBeVtOmLEzyN+MD062Gcgh6xof4cX7dtlQNX0yVBoMmANWke/cghT3qHD
GBiMFRZnd3lbvPh1N0xa4PXw3E/CDsFxcHnKi4axceVsc6JWOto3I6i5arVnYqG9
f2OGHa+Cbbb4hukGBCyNhHwEG2p7ICFRL+bGI9SERpd7huDc1mifgPZpR/ZTaAJc
Fn9D981jzE1rkY53wsHbyX01Uhc3oxlH9gxagVK9R5sP4SwdBh4dRjxO4wwMTjDu
oxfDqLOpKADchDWkHw9hP6fCiIJJBysw+nw8ZH2Zi4CtzmdWzZA=
=v+dr
-----END PGP SIGNATURE-----

--7k22atdafibz2k5h--
