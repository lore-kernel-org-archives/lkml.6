Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBFNtS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:49:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48898 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFNtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:49:09 -0500
Date: Tue, 6 Feb 2018 14:49:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, bhumirks@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: [PATCHv3] tlv320dac33: Add device tree bindings
Message-ID: <20180206134906.GA7842@amd>
References: <20180129230539.GA18280@amd>
 <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
 <20180205082445.GA18274@amd>
 <20180206121122.GG5681@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20180206121122.GG5681@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-02-06 12:11:22, Mark Brown wrote:
> On Mon, Feb 05, 2018 at 09:24:45AM +0100, Pavel Machek wrote:
> >=20
> > This adds device tree bindings for tlv320dac33.c.
> >=20
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

AFAICT this goes to Documentation, not sound.

If you have any comments on V1 of this patch, that would be nice, I'd
like to get that merged once we are finished with the bindings.

										Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp5slIACgkQMOfwapXb+vIvUwCfUV8JSd8q8E0t1v7SdOp2YPyf
saMAmwSdavlVObBh6cBIakBw624gecjf
=OTjr
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
