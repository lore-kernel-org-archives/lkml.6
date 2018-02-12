Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeBLLts (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:49:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933898AbeBLLtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:49:47 -0500
Date: Mon, 12 Feb 2018 11:49:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code
 duplication
Message-ID: <20180212114937.GA12976@sirena.org.uk>
References: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
X-Cookie: What UNIVERSE is this, please??
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2018 at 11:10:55PM +0800, Donglin Peng wrote:

> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -349,7 +349,7 @@ static void soc_init_codec_debugfs(struct
> snd_soc_component *component)
>              "ASoC: Failed to create codec register debugfs file\n");

Your patch has been corrupted somewhere (probably in your mail client) -
there's word wrapping here.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqBf1AACgkQJNaLcl1U
h9A0oQf+K1BHGQpmD2u0rbAAgnMVpBk8Bba2D3r8jGR8C7xYj+r2jQnyQfXsBzKb
lThoUQXRQ+VjzEB+/DLtJlAXHzNyNrc2uoucrHnwhEUfDhrynJ/RDBVWbXCj5oHj
4ifpaKfJ4fIQHU1x/fBEnsMl6MvrASNVftcXwhcKRZFVpyMCbxNyE69uXmQMqEOX
98dhL7KtjrhcGYRKtF5JyMBhme1r6UjtTZ6a890f/5SmFCEVbBo3bd2kl1zyHXao
tFWg6b+2yqBYQAW+LFxCuxSaSpMUB4YxW9tY3jqKqz5lXIzpgVl/LSHAa2XAh3ZT
9gmmv4WLEZVjO310uG+K9MmJHZNkDA==
=H/HU
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
