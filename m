Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932517AbeCLQTE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:19:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56386 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932379AbeCLQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:19:03 -0400
Date: Mon, 12 Mar 2018 09:18:59 -0700
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] ASoC: max9759: Add Amplifier Driver
Message-ID: <20180312161859.GE2186@sirena.org.uk>
References: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
 <1520679916-13517-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <1520679916-13517-3-git-send-email-narmstrong@baylibre.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 10, 2018 at 12:05:16PM +0100, Neil Armstrong wrote:

> @@ -0,0 +1,207 @@
> +// SPDX-Licence-Identifier: GPL-2.0
> +/*
> + * MAX9759 Amplifier Driver
> + *

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmqHIACgkQJNaLcl1U
h9BB8gf+MK7q3rkBhDvD1Mpkt7kP0NukrappIT4pEZVF6wcsM8+ictNoKPEH+2cu
opb8q3DHXpcHnOqw+M/jySHHRS8FIq7NiTxOWeuORUyfomL92clVi2X4gUeTKYLZ
1PWmr3UVvD7/DuZVEPVr4MatYIeu4A6dZ9IoFBzad2fJy6yhMt3HD/643CkModIV
OoPiTOuHOD+Cmx51gv7p+mgVCV42NCO+6yfUv3JWGx52PpkKWMK3wU5guLZUl9rR
tGAY1h6/oBgvJYRv0i7pRrtW8LxgCiX9a3x1WjAlSo1kjPwsbyV9sW+hZCZ2aDoH
jALpOnVJ3GIy0uF0bavDYwCz+Y+iKw==
=um86
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
