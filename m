Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeDDOrF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:47:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDDOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:47:03 -0400
Date: Wed, 4 Apr 2018 15:46:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ladislav Michl <ladis@linux-mips.org>,
        Colin King <colin.king@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Message-ID: <20180404144622.GE7691@sirena.org.uk>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
 <20180404102425.cwj7vzvrvi2obcoi@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <20180404102425.cwj7vzvrvi2obcoi@mwanda>
X-Cookie: An idle mind is worth two in the bush.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2018 at 01:24:26PM +0300, Dan Carpenter wrote:

> Trivial patches should just be trivial instead of evolving into a thread
> that lasts for days.

Indeed, and it's usually easier to just send a further trivial patch
rather than just talk about it.

> Why is "buff += 8;" indented too far?  And why does every line end in a
> space character?  And I think about it for 10 minutes and then delete my
> patch because it's too much hassle to deal with for something small.

The other option is to just send it and not worry too much about it
getting applied or not.

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrE5T0ACgkQJNaLcl1U
h9B76wf/aaCZ6Rv8dYbsjZdyld31M/xsNOwpdFiEgAF2iOsClaidV7P1z7rFYUJx
iPeJbZ9x03hp2DU3fpn3ReDLpA8pZoqrhgZNebMOs+ye1guK6Gp/PiKbyusvZ9E+
81c8S8U6e0UjXP8ZlAD5PYTyJcOL7REXwHeUdbUF8nvGmhEF9nwqumCsqUp8Jb5M
g6rVjbdH4ab2P4zrWjAkjfKGLbbPaIHPMjz9BlTghpSqAg4FKCSjounsT0aulvR2
/qwQrzfzuHQ3SabW9AuugF6DR2b8V2cdM/d+E58OGf9twS77rgc4uUez0paCij/i
3foKesQaDPJMMpSzPbed+KPM/Fg7rg==
=Yp6y
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
