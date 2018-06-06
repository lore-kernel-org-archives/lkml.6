Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMvlQ+oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19CCD60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeFFJni (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:43:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40497 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeFFJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:43:37 -0400
X-Google-Smtp-Source: ADUXVKKF3Euwb2YtsE5TSB2OidN2MPsqdTe1Ecc4Zi9HSsuc78q6F+5dAXn8UrseZt0PaF54CmE34g==
Date: Wed, 6 Jun 2018 11:43:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/8] pwm: cros-ec: Switch to SPDX identifier.
Message-ID: <20180606094333.GH11810@ulmo>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-7-enric.balletbo@collabora.com>
 <20180606090848.GF11810@ulmo>
 <32b22e93-d8d3-d20a-f497-723c62d1bd2b@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
In-Reply-To: <32b22e93-d8d3-d20a-f497-723c62d1bd2b@collabora.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 11:21:01AM +0200, Enric Balletbo i Serra wrote:
> Hi Thierry,
>=20
> On 06/06/18 11:08, Thierry Reding wrote:
> > On Tue, Jun 05, 2018 at 07:54:27PM +0200, Enric Balletbo i Serra wrote:
> >> Adopt the SPDX license identifier headers to ease license compliance
> >> management.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >> Changes in v2: None
> >>
> >>  drivers/pwm/pwm-cros-ec.c | 13 ++++---------
> >>  1 file changed, 4 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> >> index 9c13694eaa24..9bf4cde86765 100644
> >> --- a/drivers/pwm/pwm-cros-ec.c
> >> +++ b/drivers/pwm/pwm-cros-ec.c
> >> @@ -1,12 +1,7 @@
> >> -/*
> >> - * Copyright (C) 2016 Google, Inc
> >> - *
> >> - * This program is free software; you can redistribute it and/or modi=
fy it
> >> - * under the terms of the GNU General Public License version 2, as pu=
blished by
> >> - * the Free Software Foundation.
> >> - *
> >> - * Expose a PWM controlled by the ChromeOS EC to the host processor.
> >> - */
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// Expose a PWM controlled by the ChromeOS EC to the host processor.
> >> +//
> >> +// Copyright (C) 2016 Google, Inc.
> >=20
> > This is odd. I understand that for some reason there is an exception for
> > SPDX license identifies to use C++ style comments, but why would you
> > make the whole comment C++ style? Why not just something like the below:
> >=20
>=20
> Seems that there is some kind of controversy between different maintainer=
s. I
> did in that way because I was complained to use the c-style on other patc=
hes,
> and seems, that putting everything as // is Linus Torvalds' preferred sty=
le:
>=20
> https://lkml.org/lkml/2017/11/25/133
>=20
> I don't mind to change if the c-style is preferred by the maintainer (oth=
ers
> prefer the c++ style) but I think that would be good get an agreement bet=
ween
> subsystems maintainers and document properly.

I've read elsewhere that using // for SPDX was supposed to make it stand
out, which is kind of contradicted by the above. However, I interpret
Linus' reply to Mauro as "people tend to do less crazy things with //
than with /* */", so to me it seems that as long you use /* */ sensibly,
there's no reason to avoid it.

No need to resend, though, I can adjust the patch to my own preference
if I decide to do so.

Thierry

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXrMMACgkQ3SOs138+
s6FYcQ/+PJWrm3mSUjMrnZ5Rj3zgZR2kxykZ04vwdb0nM+o9KwqXSa6tbxInWiLw
mjY0K5yoBZ52UGdHnG0AkCwYR3QGYBaVlV1cReAUDqWQ0ga1QEBK697h972nTWyM
h5+Jc20i0NiJd1kN3D4liy9RJJJl1MxL6PaGsVPow+eid0N6CqeeCeUZplfvkxkp
ySjJpO+YfnemF6orK4o5HKKzxsToyXmYIVTtQgVSgO2IHHXaEKcTKmoNfgXPAKEK
vUGR9W2WZpBaGFUx2bhmDufMMpRYAlKTeBfwH7wGAfaT2cnXfZKaTvj4phlToHCX
TLp/Gms97D5hoK+zVGk11LpLfK3k0s3Aa7uT6uz6FLRK0sTV5vqtTXl98roTEh/G
CiU2hGOoBegUSvhXGy2kU9k7rJKXMSG+iJu+VIuZaP0W1jnjtxbtWMjyDklbgGjV
4lMUY7m0ezJddiA/8alRHu7ZKYkjSJXUh/FteOJSz+D2gmXVpgH5ou66ZOVf8n2X
lFAYI5yu253GLmIbJaKLElyugQWha8sWtEvlSiHxbflbiEkq4IXOinbP/JX0HOkv
gNfGnE86tAqUdoaI0enKIfmVkmGMeldP4ZtYTgqv/dXyWrrFKhE2yQuw2KDDfheZ
uwZlzzYlpykj9/XB8nqNP63w/wj6+xMgOdh9BPPmLxAAr85Jchc=
=uQ6D
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
