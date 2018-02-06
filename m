Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeBFMMN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:12:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44834 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeBFMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:12:04 -0500
Date: Tue, 6 Feb 2018 12:11:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
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
Message-ID: <20180206121122.GG5681@sirena.org.uk>
References: <20180129230539.GA18280@amd>
 <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
 <20180205082445.GA18274@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <20180205082445.GA18274@amd>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 09:24:45AM +0100, Pavel Machek wrote:
>=20
> This adds device tree bindings for tlv320dac33.c.
>=20
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5m2oACgkQJNaLcl1U
h9Datwf8DbN2OG/oXkRkBSiyTjVMbDEQm2sKcGxkBccOy5G4+2/fs5wkr2KUAYli
PZ6s8SkNhLpmMtRWkY7vGvrdgvF7/riwABqymOPrvAYGfQUjJhaAiacY7s/8RlSs
1tdAaVyPcvxGYmvWj1dkq9bVa42+qNC714vMBkumXxTFyPj8TPsBdUjmOlkdeZlB
Hb/SkaF4N6Y0biYpWAvHwDXIANSbrEm9wEyXMGUmqG1YaXpEo7l17+cdh0ROx49A
AGXM5d/Lklx32FAG2FV3Xa3PaIjzfssWFb7TEZoTseglVDY0AJtl9KKZRaxv03iX
JzDm4NfPMmohk8cPRb3is032/+VXjw==
=rGJM
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
