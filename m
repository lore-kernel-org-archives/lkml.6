Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeEVRPn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:15:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEVROw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:14:52 -0400
Date: Tue, 22 May 2018 18:14:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Message-ID: <20180522171431.GF24776@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <20180522165842.233949-1-groeck@google.com>
X-Cookie: I have not yet begun to byte!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 09:58:42AM -0700, Guenter Roeck wrote:

> Both problems have been widely reported. Various attempts were made to
> fix the problem, usually by providing v5 configuration files. However,
> all those attempts result in incomplete ASoC configuration.

This is the first time I've heard that there were still ongoing issues,
it's extremely disappointing - I'm guessing the attempts have all been
at the distro level.  Userspace fixes clearly aren't the thing to do
here, as discussed at the time the original fixes were done this is an
ABI and needs to be treated as such.

None of the systems I have access to have ever used topology so I've had
poor visibility of how this is working in practice, I guess I'm going to
start seeing this stuff next time I upgrade my laptop (unless someone is
making suitable non-x86 laptops by then!).

> Let's implement backward compatibility properly to solve the problem
> for good.

Thanks for doing this.  I'll give this some time for review from the
Intel people - adding Pierre as well since this is a bit of a device
thing.

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsET/YACgkQJNaLcl1U
h9AoYgf/XeNyk5qM/lMQatU+yxf76I8Gs2C2EIg+LnA+QSAVWUTYX4j7aapqK9/7
YlUDReyCF0KlNSU6wXsa5C7pXpJ21iOjNq5eFA1xF/7GQLp6JSWZqOr8aYnCmmQF
SopEfzcqQCZ+U/DcGBXO9wxD0coMa2tPjyAPvcLiQAS/PSN/uvFy9IBBR2wlrRAV
rXMdoeMYojwz/hvfZNYTmkFA9U1tGUzHHK5wSvljMeV9/m0o/9y2gXmQaM/wUR/J
2MBijJblaCn/DW4UoSuq+xMVL2FwOBIemCJQ4iBcOdIPWbJWAokd62LAiwU/9Dxo
ifxJVVmEdC3A7ai66Waq65iac2uW+g==
=s8o9
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
