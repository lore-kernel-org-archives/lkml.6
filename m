Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeBFP2N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:28:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34896 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeBFP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:28:05 -0500
Date: Tue, 6 Feb 2018 15:27:22 +0000
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
Message-ID: <20180206152722.GH5681@sirena.org.uk>
References: <20180129230539.GA18280@amd>
 <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
 <20180205082445.GA18274@amd>
 <20180206121122.GG5681@sirena.org.uk>
 <20180206134906.GA7842@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <20180206134906.GA7842@amd>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2018 at 02:49:06PM +0100, Pavel Machek wrote:
> On Tue 2018-02-06 12:11:22, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem.  This makes it easier for people to identify relevant
> > patches.  Look at what existing commits in the area you're changing are
> > doing and make sure your subject lines visually resemble what they're
> > doing.

> AFAICT this goes to Documentation, not sound.

Even if that were the case you're not following the commonly accepted
practice there either.

> If you have any comments on V1 of this patch, that would be nice, I'd
> like to get that merged once we are finished with the bindings.

It is the middle of the merge window, please be a bit more patient.

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5yVkACgkQJNaLcl1U
h9BLYQf/bR1HqHRo34NPI/6nvu/IfE0LC+RqQRa+t8pQG820McZnSDrQVwdVvrFS
zSz9nAig8CJ0ciiYC59e3ywzjlquDKaB1a5bKytCy+j6d9zbP1NdIzpQLPBo8JDx
i+8oDhTmIfrL8pohU4DdoFPjofIL5pfhI05UoKkQj9+zEaAkb3dFK/yXPgGh4vA6
/8uRdQ3oIRyT/rd2KbEAAffz+X029BhIuNIXDUFPemcfeDRbGKdmCnO57UA1XyXc
z1EFHUTssoi0jtsJ8/P7MyouPXhm3QVeNtU0NefBz/dinI98CtEeCrnm9uyp7dnQ
4PjzGfFdDOzmUnIkyd9IZoHqryOsjw==
=UDk0
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
