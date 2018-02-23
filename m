Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeBWMo6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:44:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36542 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWMo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:44:56 -0500
Date: Fri, 23 Feb 2018 13:44:52 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Message-ID: <20180223124452.ynnjb5qjk5pd26ak@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
 <20180216113901.GC5886@sirena.org.uk>
 <20180216135113.akicejkodhbjpp2w@earth.universe>
 <20180216142716.GJ5886@sirena.org.uk>
 <20180223080714.GC1584@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpsgc4x7ipusovwo"
Content-Disposition: inline
In-Reply-To: <20180223080714.GC1584@amd>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wpsgc4x7ipusovwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2018 at 09:07:14AM +0100, Pavel Machek wrote:
> On Fri 2018-02-16 14:27:16, Mark Brown wrote:
> > On Fri, Feb 16, 2018 at 02:51:13PM +0100, Sebastian Reichel wrote:
> > > On Fri, Feb 16, 2018 at 11:39:01AM +0000, Mark Brown wrote:
> >=20
> > > > We don't have default lines like this for other MFDs...
> >=20
> > > Is there a reason not to add them? It looks very useful to me:
> >=20
> > Consistency.  It's a lot easier to apply a single rule to everything
> > than it is to have to individually think through and discuss the
> > decisions on every individual driver, especially when there will
> > inevitably be some cases where there are conflicting requirements from
> > different users.  As you said in the rest of your mail hand configuring
> > kernels is already a very specialist thing at the best of times.
>=20
> Yes, so please don't make it any harder than it needs to be. Having to
> enable (by hand) more than one option per chip is annoying and error-pron=
e.

I will drop this and instead provide a new patch, which converts all
codecs depending on MFD_XYZ to have "default MFD_XYZ". This means,
that there will be consistency and we can discuss this with a bigger
audience without blocking the actual driver patches.

-- Sebastian

--wpsgc4x7ipusovwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqQDMEACgkQ2O7X88g7
+prAVg//cB/A9n4vvGyW66zzbG7U3BePFxjPCsEgDqNzDr2vS7KsVPEbM1uNxHjC
8U9NPoWy7cZrFlM17GCs9ya4sjaOrYhJ5AFLIpeJIZ5+SpoHUc6YncyV8jfzVLQi
+79PGrqIUn2YTaFH7lLS8dmNj9vbj1oN4SIYqPp2F1r4Kj1xtduxQe8XqBx5fYky
Bls3Rk0c0tr0E9hcGqUErf2LJAOjwuolXHHcWzucoI7TWuZaccNCw68jcaUx99+v
6WL3CuVJLFBj/fv84KG6ClrbsOv8gDQkZl3VlCO+hxFSCo3zAjWhfonzSsyPjTGi
DvKL4rxSfj+ARRiwOa8yBYjo18xkOk0qLSROkkNsY7excWSKZbAHlzcDX0m439qj
pIntn0/Pqd5mUBIU33OK1GzOJUtpqSzT/KW2cgNmX/bTVYW3c0i+FK4xi2qlaoFg
OSxZmHb6ll6SiuLtFISe1Zxj4iOuVw+JtodCfw/x2zpZ/wRJtZZVQB/yph5BKm/w
NWEhgLcas32wa9nZCBl8FV+rGw/e/QjkSPOd5NGRyH6wY0KwMgZdN6OP2enzf4oo
JAQTAlpiU+WRijmNAPCswmFHKpeCDefv8iiBipLH5Rz2YHe0L3u8KOzdlxP5QU3u
z+UBGR6R1s6ugBHFgKP0AGWonVieKVdrQppnVfeZp1kRfbTHWOc=
=DuQB
-----END PGP SIGNATURE-----

--wpsgc4x7ipusovwo--
