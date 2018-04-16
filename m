Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeDPQwS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:52:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:52:17 -0400
Date: Mon, 16 Apr 2018 17:52:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 2/3] ASoC: topology: Add missing clock gating
 parameter when parsing hw_configs
Message-ID: <20180416165206.GE20726@sirena.org.uk>
References: <20180404041939.23317-1-k.marinushkin@gmail.com>
 <20180404041939.23317-3-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <20180404041939.23317-3-k.marinushkin@gmail.com>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2018 at 06:19:38AM +0200, Kirill Marinushkin wrote:

> +		/* clock gating */
> +		if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
> +			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
> +		else if (hw_config->clock_gated ==
> +			 SND_SOC_TPLG_DAI_CLK_GATE_CONT)
> +			link->dai_fmt |= SND_SOC_DAIFMT_CONT;

I'll apply this but the above would be better written as a switch
statement - could you please send an incremental patch changing it?

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrU1LUACgkQJNaLcl1U
h9AJHwf/VRXvj6wUgqNsOgl9BTNAgjrI542w0m0iTZLOCRoDi8215Dyu7VLL4eyX
URweWYD0bpeXfGYGwAiEFZu5hQzWUOBwCInt29HoCNuEo9pwLySKZ1F0QHy9HFuQ
jOoxHUHz8sa0iOiqw8w78pAlrNfOqF9FRkG92+By6ub8ygIfcM5N07AcS4ObNCHB
Kdux0S0jyg1mztoaOQygdf1cta1WipWf+UphdGT9HgoCP++a8AWJ1kMzcxvCarIC
/jmYmiG1spafa7wVYD8laLKmd2d8mquIDlwDe0pF9N4WkNbE7pfgbOoaU2/6CXOz
LGtvCxqxqDkwHwa/cBd/4bUKlcPF+g==
=ll/R
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
