Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeA3M2d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:28:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54810 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeA3M2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:28:31 -0500
Date: Tue, 30 Jan 2018 13:28:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mark Brown <broonie@kernel.org>
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
Message-ID: <20180130122829.GA10373@amd>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
 <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <20180130113238.GA10525@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20180130113238.GA10525@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-30 11:32:38, Mark Brown wrote:
> On Tue, Jan 30, 2018 at 09:53:14AM +0100, Pavel Machek wrote:
>=20
> > Well, notice I'm converting existing driver to device tree. And that
> > one already has GPIO dependency. It is possible that more work needs
> > to be done there, but that should not be a reason to delay this. Feel
> > free to help.
>=20
> No, it's a very good reason to delay merging something.  A DT binding is
> an ABI so we need to sort out interface issues and describe things as
> well as we can, with board files it's not an ABI so we can just do any
> old thing that happens to work and while it might not be ideal it
> doesn't really matter since we can change it later if we need to.

Whatever.

Turns out this was GPIO after all.

I believe power-gpio and reset-gpio are equiavalent, with different
polarity. (After all, devices in reset consume less power).

If you prefer one solution over another, let me know...

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpwZO0ACgkQMOfwapXb+vKxBACgsLBvaOHPfqI2SMfxRvcwWOrs
m/sAnREPZZpu8Dv53RkXupfS9xDB7xa+
=VSe0
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
