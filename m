Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeB1IZD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:25:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53257 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeB1IZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:25:01 -0500
Date: Wed, 28 Feb 2018 09:24:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 0/3] Allwinner sunxi message box support
Message-ID: <20180228082459.o3juhfiml3logxwl@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l5qwo2fdtjbsha76"
Content-Disposition: inline
In-Reply-To: <20180228022714.30068-1-samuel@sholland.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5qwo2fdtjbsha76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2018 at 08:27:11PM -0600, Samuel Holland wrote:
> This series adds support for the "hardware message box" in recent
> Allwinner sunxi SoCs, used for communication with the ARISC management
> processor (the platform's equivalent of the ARM SCP). The end goal is to
> use the arm_scpi driver as a client, communicating with firmware running
> on the ARISC CPU.
>=20
> This driver has been tested with the base arm_scpi driver (which sends
> the SCPI_CMD_SCPI_CAPABILITIES command at probe time) and an in-progress
> firmware application running on the ARISC CPU. Because no firmware for
> the other end of the mailbox is complete at the moment, I have not
> included changes to the SoC device trees.

This is not directly related to this series, but what is your end goal
with regard to SCPI? What features do you expect to have there?

I'm asking because last time we discussed this, SCPI wasn't able to
abstract all the features the PMIC provides, and thus Linux needed to
still be able to access it.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--l5qwo2fdtjbsha76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqWZ1oACgkQ0rTAlCFN
r3Qy7A/+IGSgQNPTUq4XWgyjAJhuxUVY2GW8iI8zule2aDwpKGounNqogxC7RZjC
yeJNM6YFiXkS1Fr8YLBSuPb4jbgJUvXOmjfrZ4/W+LCdxFNnrDDjO9mX9hSaIU8T
dkTCc0qAZPeIg1BmuYxdjcf6DZv/Mo1h28WxGb1mgiUP6+peRivwzuMv/MJA1Ffy
RuWQOhL5k1lbM9AbevFfvfqRebIj7dQYZoi+ilI3bzAk4Bg6AgiMJbIR8LHoRKBJ
yD08TVdkI2wtWm8OdPjbWKra0OzuSORa+0HuW6JZf6FbJz51cWcXa+W4zj6vGMCk
FDG5E8DZDfJpBaERxqp+Kn7+T/wgvk/EVk0lOFrCubm9MkS9sVEaaMcxY92fAolA
KOkVtuKzndMwE7YOTxMUhAfKRQuq7S02czQh7GIOF43ZXSeDN1RHku2/1PrEUo45
RhEB1xywRpfgMM4YJGljUJzSVVoipfFEQXKOG/36khINQun6LCl37r+dyZzBP+ky
qJFAZaO1LYSDPqrK4zku8idEglw155oo4zWdYAk0Psjv3tzTrRGh9pRUYnLmmgQE
SQvkJbqiuPOy2XKEt/BFjfhmImD2Z89IVg7gOILOZ5dQMvvRGVxil2ahefofkU73
AH0GRgk3x0PbUtU10xhY4p57dpDZ2zAD3AfbvjzChvuA6g+u8xM=
=MbDU
-----END PGP SIGNATURE-----

--l5qwo2fdtjbsha76--
