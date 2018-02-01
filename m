Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeBAPTQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:19:16 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:51499 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBAPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:19:12 -0500
Date: Thu, 1 Feb 2018 16:19:00 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: sun7i: include correct ccu clock header
Message-ID: <20180201151900.2zabioxbq7iehl4v@flea.lan>
References: <1517427086-66480-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ua4szkjsjdssr53l"
Content-Disposition: inline
In-Reply-To: <1517427086-66480-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ua4szkjsjdssr53l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 31, 2018 at 08:31:26PM +0100, Giulio Benetti wrote:
> Include correct clock header sun7i-a20-ccu.h
> instead of sun4i-a20-ccu.h.

You should wrap at 72 characters.

> Including sun4i header instead of sun7i
> prevents using sun7i specific defines.
>=20
> Substitute header inclusion in sun7i-a20.dtsi
> using right one.

This sentence is redundant with the first one.

Dropped the first one, corrected the wrapping and applied, thanks

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ua4szkjsjdssr53l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpzL+MACgkQ0rTAlCFN
r3Sc4hAAlECGKJ/SUR6LiO2qC05GaXbu00fvBLX2hng03QwroK8zdMD7Ot0EKX2V
LI1+CzvHSp0zLkCXT+6Z95qobU8NuhJPveG9CesWcwd8OHMn8wyMgMG1s/5oln3c
qFWGcf5UbLspQRpR59vBRm++zwpf4nHBV8oksfLnLcjgYlRph5MJ3z24n+YaZcO2
uOirMIZLfyCMmQImwXjHW5lIySvhL2dCTsfzhhToYICHt/okjCwHe8tcF817qUsz
9GqKATjnWzVCUWp967XJCq3aKxuFr8fRZfQWIKuete128DXQkSMCwvRLlMhc95oC
HMR78P1wfLb4p69S3mr2Dpr6BPDb3ZzsBSIu/UmwLxUr3zZ3gQbIyGMXGCsEwSNb
2m+FdD0uTYqWJbIhURF8Xe+Rh1sKjcXhlA87WY6ltyba/m2TPkQjTLs4fUpGJuNN
PV+Pxju/11QNx5vsUHsbMtTG9PBRBjYCdqr0t9lLSOlEJf776+avsjagp5HLj1QA
zGCI/7UwnBnsYpZ37XRKzFK8DGHFx7JD4sYKOZqqyzapyIWNzGsVJE2iETEAWxWd
DTAFKYUpjteGfs2qC4seV3N2L5W1DDwlzds+pfLBriiC8kpQlAtAlqVbqnjHhirp
SzbIGYB6GbvfGDdSY2Gru0EAkwYVU9ZmgOo8n5BUqKxcyai6cPA=
=Hdf0
-----END PGP SIGNATURE-----

--ua4szkjsjdssr53l--
