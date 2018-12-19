Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C8EC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B050218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeLSTe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:34:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51340 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeLSTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:34:58 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F300C80A87; Wed, 19 Dec 2018 20:34:51 +0100 (CET)
Date:   Wed, 19 Dec 2018 20:34:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20181219193455.GA21159@amd>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20181219162626.12297-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
> +
> +static struct attribute *lp5024_ctrl_bank_attrs[] =3D {
> +	&dev_attr_ctrl_bank_a_mix.attr,
> +	&dev_attr_ctrl_bank_b_mix.attr,
> +	&dev_attr_ctrl_bank_c_mix.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);

=2E..
> +
> +static DEVICE_ATTR_WO(led1_mix);
> +static DEVICE_ATTR_WO(led2_mix);
> +static DEVICE_ATTR_WO(led3_mix);
> +
> +static struct attribute *lp5024_led_independent_attrs[] =3D {
> +	&dev_attr_led1_mix.attr,
> +	&dev_attr_led2_mix.attr,
> +	&dev_attr_led3_mix.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(lp5024_led_independent);

Ok, so you are adding new sysfs files. Are they _really_ neccessary?
We'd like to have uniform interfaces for the leds.

If they are neccessary, we need documentation for them.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwanV8ACgkQMOfwapXb+vJcsgCgoDf6Ygk2LIK09xDjs70WVjLa
F40An31rlizGm0+OPasF2r2CeWK+pGOi
=bOXm
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
