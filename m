Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEKIiL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:38:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34490 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbeEKIiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:38:10 -0400
Date: Fri, 11 May 2018 10:37:44 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: a64: Update Orange Pi Win/Win
 Plus
Message-ID: <20180511083744.jpzt7m3vbk5epqjj@flea>
References: <20180511030124.9356-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rfiozkxyqo6fkz3s"
Content-Disposition: inline
In-Reply-To: <20180511030124.9356-1-samuel@sholland.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfiozkxyqo6fkz3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, May 10, 2018 at 10:01:23PM -0500, Samuel Holland wrote:
> Enable the following board hardware features:
> - Gigabit Ethernet
> - SDIO Wi-Fi on mmc1
> - SPI flash on spi0
> - Status LED
> - Dual-role micro-USB connection
>=20
> Also provide nodes for the UARTs exposed by the 40-pin GPIO header.
>=20
> A couple of fixes were made:
> - Updating a couple of regulators from the schematic
> - Marking the CPU's power supply as such

All these changes look sane, but you should really split them into
more patches to have one of these changes per patch. We really don't
mind having more patches when it's justified, and this is definitely
the case for both your patches.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rfiozkxyqo6fkz3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr1VlcACgkQ0rTAlCFN
r3StVg/+MT+aKZpB2vOVBS4PjikMAQiimUG2RK8EvJH1yFM6Q1cQPEdQQ1plnxI/
F+dqyAadZsC3lRL1/xV1xcCAxTwHRyyqCB7DsCkAnQGAco/8uO4Gs0UJhP8iVHHb
+/poZ3tc9Y84uAVwnnz+yZW/Y5OfYsZRBG/ZuMIy9dcE4ED3rL8SOObMBDCPjooE
sShrvTx5gpRsNtHuTq6/VeXWoMg1LYWkXltVveUNwvzNIwrmtEWbPu+1dKyO+4x1
XSrPcRvDq8dWcm5oj/uDOzdDb3LSfW+OeXOSFurggHV8v92t5Ih1uMhNHsdaulcA
UwrDi8z6Lk5rH4kwl8H5SF82NOKVC0bM4KU43OulaZgsCuni/vjzNzeepjOeIm3C
1u40OKu5R/p68NNKJFCQsNMve7t7oqnBWfrLExCYdKxtmi+CobywXLs/bD7XvypC
y0jGqduQA7Q+aEIBf/a/jEq8u3AMc252cNbK5ew+W3Ew5HbR119FYWjCXoYfNq7e
VXz/6lO8S/SWP2SVBgfDhivuhIwoRNtDe6XMXPfzoP/VI2pa56bxxxRMTfxfFQrB
D0Iujo11lmudVzwqi7j9JG0FNv9cjqEVZ1hlKolOazIQNJTDW9dzUVED/8kVwIF4
EbY48bFiGBq4phkDpMxTQRxo0jwr+aig3fXOEM+/wUgQXxHa+p4=
=wJBP
-----END PGP SIGNATURE-----

--rfiozkxyqo6fkz3s--
