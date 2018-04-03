Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbeDCKta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:49:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54695 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbeDCKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:28 -0400
Date: Tue, 3 Apr 2018 12:49:26 +0200
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
Subject: Re: [PATCHv3 5/8] dt-bindings: panel: common: document orientation
 property
Message-ID: <20180403104926.GF6758@amd>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +- rotation: Display rotation in degrees counter clockwise (0,90,180,270).
> +  The following values are possible:
> +
> +    0 =3D The top side of the panel matches the top side of the
> +        device's casing (default).

This is still ambiguous for devices such as N900 and Droid4, which can
be used in two modes.

"For phone-like devices that can be used in two orientations, top side
is the one that is pointing up in keyboard-closed, portrait mode."

?


Best regards,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXDYACgkQMOfwapXb+vLX3gCgt1iOxeD5HLwc7yVkCQChYjuq
kboAni7iZkwiEX7Tz4CnM7H9jmmALplR
=3/kQ
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
