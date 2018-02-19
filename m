Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeBSUfi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:35:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56535 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753593AbeBSUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:35:37 -0500
Date: Mon, 19 Feb 2018 21:35:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: setterm -blank force no longer works after switch to omapdrm
Message-ID: <20180219203519.GA4936@amd>
References: <20180217211927.GC9640@amd>
 <20180219191623.GA2347@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20180219191623.GA2347@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-19 20:16:23, Pavel Machek wrote:
> On Sat 2018-02-17 22:19:27, Pavel Machek wrote:
> > Hi!
> >=20
> > I used to have use omap fb driver, and blanking worked as expected. It
> > no longer works with omap drm driver. (Tested on v4.16-rc1, but I
> > believe it is broken in older versions, too.)
> >=20
> > Can you test it on your hw? Any ideas what could be wrong?
> >=20
> > xset dpms force on/off works as expected.
>=20
> next-20180219 seems to work as expected, too.

=2E..because I did not switch to omap drm driver for my next- kernels,
yet. Oops :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqLNQcACgkQMOfwapXb+vI9SACfZ6vnVIsMUqKMakGVK0nzGESv
DcoAniXQgazlplsYJjTSnggTBlGIbjxZ
=Cy4G
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
