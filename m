Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeBZJNg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:13:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41227 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbeBZJNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:13:33 -0500
Date: Mon, 26 Feb 2018 10:13:21 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: megous@megous.com
Cc: dev@linux-sunxi.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10"
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] drm/sun4i: Enable the output on the pins (tcon0)
Message-ID: <20180226091321.b5dqdlsiq2eyix7c@flea.lan>
References: <20180222161217.23904-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylhjl3eocorbjuhi"
Content-Disposition: inline
In-Reply-To: <20180222161217.23904-1-megous@megous.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ylhjl3eocorbjuhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 05:12:17PM +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> I noticed that with 4.16-rc1 LVDS output on A83T based TBS A711 tablet do=
esn't
> work (there's output but it's garbled). I compared some older patches for=
 LVDS
> support with the mainlined ones and this change is missing from mainline =
Linux.
>=20
> I don't know what the register does exactly and the harcoded register val=
ue
> doesn't inspire much confidence that it will work in a general case, so I=
'm
> sending this RFC.
>=20
> This patch fixes the issue on A83T.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ylhjl3eocorbjuhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqTz7AACgkQ0rTAlCFN
r3TVjg//dYrl1yC5jGjIf+3uTeFAJ0Rx4I4BxbkTmRCc+kBSzFg3DUnM94eam5sv
/GuaRTidKul2nkS+UQdmRHi/V027Cxgg0eQJ06dPldgsDWko4caAh17YYcqxf6qJ
kDBUIy8tNwpycMK4CzShztym3CkY2U6+VYYIvzXVtEiQhkDqJ8cenjH8S6byNG/+
ZvCvRk+ADA+A4Xu7SWU9G3x8tRAVzH1ggSdtH6uFsdjC5x+rqRYpnc0S8QEt6mHi
pGNDjJm4wEXBuxCohgIJZa8QNmXNDXN3GXLlWSKSs6PwpM45t138ZHxIYb5seH/6
klhs8CI6Rsmb1IYHauGV6YOwsifwbmuECgx3hZd7zbGBnEC5DV5e5bQtyA/oCAcK
lqTY7psRAbbl4NTGpynaP+4WzhvcnCw9cDah0sq7vGb8zUf6jbG4b7BraqJBcujm
QnXwvABCW9Af5HiWXgKp2Z8tnxH6JP9JIgMaKlQnCpionvyLoCVBKeCmBzB1Ty0E
cZXfxyl74t4YIE2eksZSVSa2vJh0HjCURXGtI8GDZM84fofk6ACyv9Q2Z/iGlecT
LQBhObVBOhCgBFFmAEoAefdDnUklqEnTSpkQYey+mMPjFHk9Vn2H8G3f1PkAE2bq
UeVEY+CW/8B7hSt9gtBXi5QKDn8JBpdI8Wh+EZnn58L7BkFE2iE=
=wr69
-----END PGP SIGNATURE-----

--ylhjl3eocorbjuhi--
