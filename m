Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeDBPXs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:23:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDBPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:23:45 -0400
Date: Mon, 2 Apr 2018 16:23:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH 1/3 v3] ASoC: TSCS42xx: Shorten lines and
 other cleanup
Message-ID: <20180402152335.GQ29239@sirena.org.uk>
References: <20180328150809.GA303@t7-ThinkPad-E560>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XMHqbYJb993HXwLR"
Content-Disposition: inline
In-Reply-To: <20180328150809.GA303@t7-ThinkPad-E560>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMHqbYJb993HXwLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 10:08:22AM -0500, Steven Eckhoff wrote:
> Shorten lines greater than 80 chars
> Add const to struct snd_soc_component_driver

I only seem to have patches 1 and 2 here (and they aren't threaded with
each other which is a bit odd too).  I seem to recall this has been
happening quite a bit with your patches - in general if you're sending
things you should always send the entire series at once, ideally
threaded together.  Sending things separately makes it very error prone
to try to follow which patches go together.

--XMHqbYJb993HXwLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCSvcACgkQJNaLcl1U
h9CVJQf7B/UelqFwB4MvkQ66X4oZe/I8BRXnG6NHdlEwdSBSDFPMwI3JgNz+KgHB
0L94w8+i3bVq8Nk5XR0B02HH//aevPVyIdXmAqGqudIf6UdROWhL+4/fdqsSWGtZ
K4VayAdw69zvIGaWRxUvh4Nt7oumTjzfciTI7ZC3+vTwz0plhT1Cthcu6j6gHgZ0
6E/hn94e4gIJJenbxJXsVQChYmckKqpBGCuWeql7grawRzn6zzROJ1JpLo9RrfTP
Ai5hH5P6DZUDzgZoUJmeJf6nGvQ2jfJUWdEQkvuIYLxGfVtfV/S2cjBAbDngcxxI
4BrrO0XvfAK6fLDqRrbzU4HMPK05UA==
=WSy+
-----END PGP SIGNATURE-----

--XMHqbYJb993HXwLR--
