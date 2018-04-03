Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeDCKtt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:49:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54717 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbeDCKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:45 -0400
Date: Tue, 3 Apr 2018 12:49:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv3 7/8] drm/omap: panel-dsi-cm: add rotation support
Message-ID: <20180403104943.GH6758@amd>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-8-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20180330171822.25896-8-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 19:18:21, Sebastian Reichel wrote:
> From: Sebastian Reichel <sre@kernel.org>
>=20
> Add support to inform the DRM subsystem about the orientation
> the display has been mounted to the casing.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

1-5,7: Reviewed-by: Pavel Machek <pavel@ucw.cz>

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXEcACgkQMOfwapXb+vKlTQCfRevNFNSBuOoYVMUdspgwdc5d
8WEAoLN8ENBPzuDDP7p1iXUyzVs/cN2x
=DM+N
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
