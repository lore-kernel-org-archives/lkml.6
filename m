Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032055AbeBPNpC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:45:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39152 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031757AbeBPNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:45:00 -0500
Date: Fri, 16 Feb 2018 13:44:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Message-ID: <20180216134448.GI5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
Content-Disposition: inline
In-Reply-To: <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 02:25:38PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 16, 2018 at 11:30:08AM +0000, Mark Brown wrote:

> > Why are we adding a separate DT node with no content for this?  This is
> > a single chip, we already know that the CODEC part is there from the DT
> > telling us that the chip is there and what we decide is part of the
> > CODEC is going to depend on what the OS running on the system is doing.

> While it looks empty in the DT binding file, it's actually not empty
> once some standard properties are added to support audio-graph-card.

This tells me you're missing something in the binding defining the DAIs
and...

> A real world example looks like this:

> &cpcap {
>     audio-codec {
>         compatible = "motorola,cpcap-audio-codec";
>         #sound-dai-cells = <1>;

...that still doesn't require a compatible here.

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqG4E8ACgkQJNaLcl1U
h9CoJgf+LIay/5PWe9tXRh61EWZrotiZ87n1Ft3lMMPcxe1Kl7IA3tsqk8G9b+75
fekReJwFH1Ten4fd3pkfbFX5ZeO94u/j/yVi+27rKIUayvf6AHVq52pfX3fSOXOD
IekSQ+or/HHhD+5SwNnuKUKOVU1enOdAPoYzQr+nX6GYQZuRZqN+R6qF6M6wZloS
gTrY6dCY7KS3QqBSoJMqO9oM+TOeUgOfRHXZerFtTlJT3kU8UoKfDJ4iwINh4+cU
Iabj37f2ba0XQMH/a1suQWnKAK+K+1AKjq6XOsEWCBgttgGh9KZat2pB9UnAgGke
OaoaBbmsEeuc6Y1d0TKHkX9oEss4yg==
=HXQj
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
