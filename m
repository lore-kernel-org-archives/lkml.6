Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeA3Kfm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:35:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50944 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeA3Kfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:35:41 -0500
Date: Tue, 30 Jan 2018 11:35:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        bhumirks@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Message-ID: <20180130103538.GD18104@amd>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
 <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
 <20180130093838.GA15195@lenoch>
 <20180130100023.GB18104@amd>
 <20180130101046.GA16474@lenoch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20180130101046.GA16474@lenoch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-30 11:10:46, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 11:00:23AM +0100, Pavel Machek wrote:
> > On Tue 2018-01-30 10:38:38, Ladislav Michl wrote:
> > > On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijevi=C4=87 wrote:
> > > > Hi,
> > > >=20
> >=20
> > > > > Well, notice I'm converting existing driver to device tree. And t=
hat
> > > > > one already has GPIO dependency. It is possible that more work ne=
eds
> > > > > to be done there, but that should not be a reason to delay this. =
Feel
> > > > > free to help.
> > >=20
> > > Adding DT properties that need to be maintained for compatibility rea=
sons
> > > is a bad idea and very good reason to delay merging unfinished stuff.
> > > And meanwhile it turned out it is not power-gpio :)
> >=20
> > I believe reset-gpios and power-gpios are commonly used like
> > this... and that's what the old code does.
>=20
> Why do you care about old code when introducing new DT property?
> Either it is reset, then lets call it reset-gpios or it is power supply
> and then voltage regulator should be used (VAUX4.OUT is such a regulator
> although it is unclear to me how it is controlled (*)).

power gpio =3D !reset gpio. Difference is only in polarity.

> > You are not helping.
>=20
> The only way I can help here is to resend your patch with "reset-gpios"
> used, which I'm pretty sure you can handle yourself.

Well, you can do that, and then you can argue with the next person who
feels one of the properties has to get his preferred color. Hard part
is not changing code :-(.

									Pavel

> (*) Remark "DAC33 enabled (for example, plug in a headset to the 3.5mm
> AV connector and start music playback from the device)" in schematics
> suggests it is controlled somehow.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpwSnoACgkQMOfwapXb+vJpSACfcoEayAIDb8i+euYVi6ax51do
2ogAoLNW73ZHvDoFKVEHhmR0dufAqXGX
=6iRg
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
