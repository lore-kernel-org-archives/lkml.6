Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeCLIqp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:46:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46344 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbeCLIq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:46:29 -0400
Date: Mon, 12 Mar 2018 09:46:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: reference tablet design: Enable PMIC
 power supplies
Message-ID: <20180312084627.ls4xxmvlkhqwf4ok@flea>
References: <20180312042116.18513-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwvjdl4ckgypkzyy"
Content-Disposition: inline
In-Reply-To: <20180312042116.18513-1-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xwvjdl4ckgypkzyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 12:21:16PM +0800, Chen-Yu Tsai wrote:
> The A23/A33 reference tablet design has a DC barrel tied to the ACIN
> of the PMIC. And being a tablet, it has a Li-Po battery.
>=20
> Enable both power supplies in the device tree.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--xwvjdl4ckgypkzyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqmPmIACgkQ0rTAlCFN
r3RwTA//XBukw4ORdIh0GRVunSFleqUlE4h+LlLne9vgtmfSR2FFcfvBow9n3oEF
4p3rUR/8QQcy/cQtZPleS+m6/jR7EnjJLOIS78oEt18TR4j1k56lrxQJTyqLO6aR
3j9HojqFovbWremFtR+oEyuUlG9MjtHnT6DW6lnsoC/SyHCur8ppTdMBc6qyiUPv
Bu63KIa9HSDy9sE9DsIfPn7JAYuGAvG1TaA9KHTXza1hzWPwpuo0jaClmWjxN3V4
26O5snim7cRczCHc6+FglN1uGhE2GXltSI4ip0B0zb2XLB/Spg4qsGxt8g07uQUu
rQahzUXhlMn3E3XUgG421C1VIz31dwHlou9ZDyV9w5+5ue8HZNjxfmrEtupFy+Ri
p75d+jHxORJYZ7t97RJnfy2nF1rcNK3rnwQtIq2/QSOLjqDu8pH4lGZxL3a5+dxQ
C15hMteHI68rnJM654cjRJcsuwAlFNhfJsIgK9br2ML9qdG9znkZ2oD6fNeFCSi0
SjFJDCWdk2E167l8n4IUJjQJ9TDKMy1amemo2HQ2KhnOzqleqJNjYlMvYNYmv+ya
WKQ7yRyNeqIYSWEOPyf5gLGebzBuAVfuRxv6GB8c6DjWKk3A9tmxueCFMXEQIsRW
PP7d5JeUMAdJEdM8Fv9QEXm1xE/Oc7j/wsulFIiZO/rK3v328+s=
=C+QD
-----END PGP SIGNATURE-----

--xwvjdl4ckgypkzyy--
