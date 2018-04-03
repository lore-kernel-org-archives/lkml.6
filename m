Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755322AbeDCIvO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:51:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51509 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeDCIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:51:12 -0400
Date: Tue, 3 Apr 2018 10:51:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 1/2] dt-bindings: mfd: motorola-cpcap: document
 audio-codec
Message-ID: <20180403085110.GC3926@amd>
References: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
 <20180330125824.21418-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20180330125824.21418-2-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 14:58:23, Sebastian Reichel wrote:
> This adds the DT binding for the audio-codec sub-module found
> inside the Motorola CPCAP PMIC.
>=20
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDQH4ACgkQMOfwapXb+vKSOQCeKj1Quv5875wvyDFvvSg7aNWM
DWsAn3Za7+mh+2g18qz/GbmSWCmlug54
=7ytZ
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
