Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeA3Ld1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:33:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeA3LdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:33:25 -0500
Date: Tue, 30 Jan 2018 11:32:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ladislav Michl <ladis@linux-mips.org>, lgirdwood@gmail.com,
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
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Message-ID: <20180130113238.GA10525@sirena.org.uk>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
 <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20180130085314.GA4585@amd>
X-Cookie: Try
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2018 at 09:53:14AM +0100, Pavel Machek wrote:

> Well, notice I'm converting existing driver to device tree. And that
> one already has GPIO dependency. It is possible that more work needs
> to be done there, but that should not be a reason to delay this. Feel
> free to help.

No, it's a very good reason to delay merging something.  A DT binding is
an ABI so we need to sort out interface issues and describe things as
well as we can, with board files it's not an ABI so we can just do any
old thing that happens to work and while it might not be ideal it
doesn't really matter since we can change it later if we need to.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpwV9QACgkQJNaLcl1U
h9AjzAf+MrrqV6SDQoxsxACv09qGVntDjrDp1/5iroH/gHKjWTCPSLlkmJacyyY/
ewMq30TKUotIusAtO/8gWWP6HBgr8TZcPq5BEUWgUNC76b6sO4fqPII90ZUnpW8I
f0wYTe6M5yfTWtO8BXC3vs5x8pJFCp7iypIb3Gacwh3aoYIUauVLZCJ4F+St9Dcy
df4dUX1PM/d4PcFCwxC7gUwFjmELexcOvVM2+BfBzVlvNeqTnKu//WqmrUEEy13s
Q94EmPZXyqrVpb4LaLFz1mSB+yegCxz+4otJh9QNAtARCf5TZo8aptT5o3HQd1xl
+GYlt/Pvh4LNea30lyvyMbjQwLMFnA==
=zGsm
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
