Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeEOGmQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:42:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45696 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeEOGmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:42:15 -0400
Date: Tue, 15 May 2018 08:42:04 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: James Kelly <jamespeterkelly@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Skip clk_put for attached clocks when freeing context
Message-ID: <20180515064203.mf5xcso566ktndcx@flea>
References: <20180515005017.46851-1-jamespeterkelly@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jivn7zf2pkxmn24g"
Content-Disposition: inline
In-Reply-To: <20180515005017.46851-1-jamespeterkelly@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jivn7zf2pkxmn24g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 10:50:17AM +1000, James Kelly wrote:
> Capability to attach an existing clk to a MMIO regmap was
> introduced in 4.17rc1.
>=20
> However, when using attached clk, regmap does not do the clk_get.
> Therefore it should not do the clk_put when freeing the MMIO
> regmap context.
>=20
> There does not appear to be any users of attached clocks yet
> so this would be a good time to make this change before anything
> depends on the existing behaviour.
>=20
> Signed-off-by: James Kelly <jamespeterkelly@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jivn7zf2pkxmn24g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr6gSkACgkQ0rTAlCFN
r3T0xRAAk4AO1ReDvqqllDYIWir6wuPv3tvzRn1Bih3WrAeIzIGC6Kn3qf9QscAI
lA1Aec3Jri+62z8sloEfpKXJY9+R0ZdmYN6P8SkuIQtBznumdrkw3e61jnHBnoAU
DUJ/n/xdQL0bUBURh1OoFPQw7CFYXoR31gYRujTpdqzOkRdr3x6lUmafGpAV4m6i
H06ufGG42ueS904CVs4o73lot1+6oiSCMRu+Wz+FHtOF0r0p9dDEU74pv2CjPZ1I
AGrP+MSbWDPsRuQgREoh7wlQoT6smiDa5IfieynMGs3/CbF7egln2QNc0NeQdlXL
eJ2iU+eFFnJQKkM39anGSqcUtAPyhpfJSWfpagopEU4Cc/eAEBlokT7Jq9zd3G4i
wFsxCYdwbTWWgenp5YJ1yzo9nNC3ivDOZ/ohC3mYhaSHg9R7cKEW5XU/+XYvfmq4
UlAopJXUo1oTqsyGjz7RVQA2w+kqDWeW/ltGfHj3vN4lKj0Wpi9NIMR7AoMh6MY8
18NXpuA/3NP9Sb9Vm49l7JzluyxLc2fkAc1i9g7Bfgy7vwIYDhyN+Blyq/GrJEEW
8ygAevvYnNj+tu8Q47WKhxpWmAramzaThdDQPzOgy60yLf2/Lh1lDaEs9Uh6cVf4
Dv8w8yMTN1RvXFihK02B1d1TFEWxCs71eFgA11ybrFqw06+rTSk=
=62YC
-----END PGP SIGNATURE-----

--jivn7zf2pkxmn24g--
