Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeECXN1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:13:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48108 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECXN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:13:26 -0400
Date: Fri, 4 May 2018 08:13:05 +0900
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: meson-axg: support MAX 80M clock
Message-ID: <20180503231305.GC13402@sirena.org.uk>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-2-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20180503213645.20694-2-yixun.lan@amlogic.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2018 at 09:36:42PM +0000, Yixun Lan wrote:

>  static const struct of_device_id meson_spicc_of_match[] = {
> -	{ .compatible = "amlogic,meson-gx-spicc", },
> -	{ .compatible = "amlogic,meson-axg-spicc", },
> +	{
> +		.compatible	= "amlogic,meson-gx-spicc",
> +		.data		= &meson_spicc_gx_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-spicc",
> +		.data		= &meson_spicc_axg_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, meson_spicc_of_match);

This is changing the DT bindings but there's no update to the DT binding
documentation, please add an update there.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrl4AACgkQJNaLcl1U
h9AKnwf+LmyWjH1qLkM99n8Lnim407HcgCEcI50yVPIY0OymY40AQX8+3KQjyF+4
r3s70Vk5GT3djRgwYciWxX3jq/GeCcjgKa4VZyy+Ia3CGb1yYXJoc/u0OsCUSD3q
kEA9OulskLY7zoW+H13XLq0IpojUPnkVOb23/si9lUpOgGGk9d3srlAbS712EY98
2wetI/a0AMQDAuMpP3KwawAtcKP5CKWpqcpDgWdrZqznQWGgh9DGnS1V6t4YxHYZ
8KBA9AIaW80mRieqvMEj5fUVsO/bGCskNFq9edF0pDUI0T89FR/Qd4e6eMMiOTFp
onn5vzNs+dP+MP2iZyTQ8do6umnn6g==
=2yYe
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
