Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935812AbeCHPOw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:14:52 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34344 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeCHPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:14:49 -0500
X-Google-Smtp-Source: AG47ELtsbpRPxic6xWB2txb1Hy15Xr4o9o9PsixT5E+aIWKXqOTmPFh5turpBuHoijpQ/hvS2HNzMQ==
Date: Thu, 8 Mar 2018 16:14:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] ARM: dts: tegra: apalis-tk1: activate pwm pin muxing
 for pwm3
Message-ID: <20180308151444.GD13814@ulmo>
References: <20180210013806.28496-1-marcel@ziswiler.com>
 <20180210013806.28496-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20180210013806.28496-3-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2018 at 02:38:02AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Activate PWM pin muxing for Apalis PWM3. Note that the same PWM3 is
> already active on pu6 being Apalis BKL1_PWM as well. Therefore exporting
> that one for raw sysfs access will fail and one has to revert to using
> the pwm backlight.
>=20
> Downstream commit 668ddb921800 ("apalis-tk1: activate pwm pin muxing for
> pwm3").

That line is rather meaningless without knowing what exactly
"downstream" is. I've removed that line.

Thierry

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhU2QACgkQ3SOs138+
s6F4/g//aegrx5okEY5hxiGSgLoAC8/pDkHsiMA3jH4jz16P/0NUy3yWAFLql19q
bUtIn6cXXY5qREFM2IbcXgZDK0pYoMuoPiVn331pPSic0rWqv1K8SJL+GdHthQtf
we2gdOwZEhUYvf2i3aXWdImBZ92lSSGcOgJXU7dXZ9iWiNkIxLm3j4oQMdWURgaO
FYsD6zmcV0xw/7OILQ9z4Yt3ukMLJEyvUSA2XZV020QZIFTW8Ppdd5HtfW3MJ/8k
WSnB/O850OZuvf/niZ+fFWkgUp1++UbRhI8U0aIASOvzAq0CPKQ3l5XPoPr4T0aF
P60jL09uvN4WtNlAebgSfZZh7GQSpy1tqxK9RT3yMgyccJC1KVRjPW1REHeMC/Op
9S5xT5hIDCTKt+i9yQ5lbr1+Ly4Vr4D0gE2Pf/FcfW9RS2ASfn7e5MhogepDGgjC
GYrgRGuGjNIrioh4o+OpV9CuRVV5dIV6zjqqk8hdHYhIstXUnlNz4L5cH1Vd7OW0
qWpl+5AfMmgH9qeBoqyXRbZJcnTvCbZAHHSjdJX+fGtP8fQwa5yCnPK+pvhDNh7B
f6ZO1kkwBRtEBN3qHKHCZPDGK8Cx8kDcVVu+SODv9t04d5abkzbtfVY2oJTKebEk
ajE0HT68Ssp0L5mKzDn2vfXDkcYXGneQN9uGFvD4dqhRfUPmI7E=
=mb8a
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
