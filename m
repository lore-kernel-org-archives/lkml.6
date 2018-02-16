Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034363AbeBPO1a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:27:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034273AbeBPO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:27:28 -0500
Date: Fri, 16 Feb 2018 14:27:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Message-ID: <20180216142716.GJ5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
 <20180216113901.GC5886@sirena.org.uk>
 <20180216135113.akicejkodhbjpp2w@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline
In-Reply-To: <20180216135113.akicejkodhbjpp2w@earth.universe>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 02:51:13PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 16, 2018 at 11:39:01AM +0000, Mark Brown wrote:

> > We don't have default lines like this for other MFDs...

> Is there a reason not to add them? It looks very useful to me:

Consistency.  It's a lot easier to apply a single rule to everything
than it is to have to individually think through and discuss the
decisions on every individual driver, especially when there will
inevitably be some cases where there are conflicting requirements from
different users.  As you said in the rest of your mail hand configuring
kernels is already a very specialist thing at the best of times.

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqG6kQACgkQJNaLcl1U
h9AoCgf8CQYEgUAvlLn8toKeaZlwqe64eR8eKRYIUVGLT6JyPh9GGPFh3I7JhPgV
fMakHQyW/Vw6OGthmS76ziyoAifgwww89o07qxjoOvJfnuVy2M1/wdaIcCOFfQZN
hcLxYd6NnsoXBbIXuDWPSUWaxEUc9N7uH6fNeZFppv6DjEYaI+bunj/dTCJxvVnC
5Q3R/+dVEoEEdK1Q41N3sjPypgjZc7D8xP+wXcmix9CBN7yZsBmJJMSCnfK214VD
MXv8u0ahaR4SVTq7LeBUeQtFp7cW1y72BeAAZ+uQSb6iPxuE58OlInneT6uLc+B8
MYWeCW5cs79YSTGAQuxomCRerXUAOw==
=qpom
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
