Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeBSNZl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:25:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58226 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeBSNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:25:39 -0500
Date: Mon, 19 Feb 2018 13:25:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Message-ID: <20180219132528.GD32761@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
 <20180216155837.e57lt4dhc7wlryq6@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20180216155837.e57lt4dhc7wlryq6@earth.universe>
X-Cookie: You enjoy the company of other people.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 04:58:37PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 16, 2018 at 03:16:09PM +0000, Mark Brown wrote:

> > It's not just other operating systems, it's also other versions of
> > Linux we have to think about here. The most obvious issue with audio is
> > the clocking where the division between ASoC and clock APIs is not super
> > obvious and could easily change in the future.

> Which does not change my argument. Other handling in Linux is
> basically equal to other operating system. We don't loose anything
> by having a compatible available.

It's bad practice to do it - we need to remember we're designing ABIs
here and try to do the best job we can of them.

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqK0EcACgkQJNaLcl1U
h9DNPAf/XNoLoMTpjX2ygbW/XlY1u8PS5wMLRIFzuGFXu7KLw4lCwX+yc7m8Ct+N
RZn3nss4v71fIUvx9T03/MTLZQfyrnhFNkcMSqrabnryxjZTimWSGpktiv7wqEAA
gayEEtJpBrZCY2/LwgFTMMwyn43clGy6buttIE3gJsOFtfZrQ/h72pFyurS8Jyhx
WhKJ1titVUq1WXchL154tjNLql/yMe4cCaKA3r4Kqe+LKNEDTGv5b6k0xv1V/As6
Q6iJODdeb8vDVqzppUwDRqjxVzIwLgj4uX7DKezPH8dfty00L1HN7U2051F7llr/
NftlkfzL0WiEcrOgTU46wWCxwai8Ag==
=JKIr
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
