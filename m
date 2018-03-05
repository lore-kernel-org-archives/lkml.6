Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeCEPkv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:40:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeCEPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:40:38 -0500
Date: Mon, 5 Mar 2018 15:40:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicholas Lowell <nlowell@lexmark.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: giving regulator controlling gpios a
 non-empty label when used through the devicetree
Message-ID: <20180305154036.GI8588@sirena.org.uk>
References: <CANnE4YfYihuhAa8TtdzDB+MR2njSwszFRvr2g+h=mcRjD-DiiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline
In-Reply-To: <CANnE4YfYihuhAa8TtdzDB+MR2njSwszFRvr2g+h=mcRjD-DiiQ@mail.gmail.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 11:20:49AM -0500, Nicholas Lowell wrote:

> +++ b/drivers/regulator/gpio-regulator.c
> @@ -196,6 +196,7 @@ of_get_gpio_regulator_config(struct device *dev, stru=
ct
> device_node *np,
>   break;
>   }
>   config->gpios[i].gpio =3D gpio;
> + config->gpios[i].label =3D config->supply_name;
>   if (proplen > 0) {
>   of_property_read_u32_index(np, "gpios-states",
>      i, &ret);
> --=20
> 2.7.4

This patch is completely mangled, please see Documentation/SubmittingPatches
- it looks like tabs have been converted into single spaces and there's
some word wrapping going on.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdZPMACgkQJNaLcl1U
h9Aq0Af+OJP6rRK4V2zckRjVvQ2BFIQjlSnjJTB9mEGlQxmzGkwF08eJWV/ZgJ4N
n5sdvTq7idUITk4kH0C9Hpcnq0fkF/C+SiM/WuMSYww0Kmhd/cF2NytoiGm2MuVW
8aV+NycuT0LJQoRI7BzxnGUl+6GF7hYi/ZZtIkQzAORmfNsPpZ+Z7pci58aYk5WN
qNpT04adJMxHECe/MTtYtHsQA6RqerlwAjDM9eS+EdvYEM2ovgGE/RSK7/CTwN7U
MLFh3mwzL4zzrfDXWFn9f/higmjwCc2KGqH4QVlRMikYs0SPHw/DuvWsxx6w9IsD
aMdLXcfLEMF++3Ag0HBvxFfFMXYxqw==
=p1GB
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
