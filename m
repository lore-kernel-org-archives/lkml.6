Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeCRUSH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:18:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38296 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752711AbeCRUSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:18:01 -0400
Date: Sun, 18 Mar 2018 21:17:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 0/9] Initial Allwinner H6 support
Message-ID: <20180318201744.dw6hnm2vdybaunev@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tmlmlksbckghjpky"
Content-Disposition: inline
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tmlmlksbckghjpky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 10:02:06PM +0800, Icenowy Zheng wrote:
> This patchset adds initial support for the Allwinner H6 SoC.
>=20
> It's quite different from earlier Allwinner SoCs. For example, the
> memory map is refactored, and the CCU is rearranged. It's also the first
> Allwinner SoC with PCI Express interface (although the implementation
> of the PCI Express controller is broken), and the second one with USB
> 3.0 (the first one is A80).
>=20
> This patchset adds the most basical support for it, including the main pin
> controller, the main CCU and the basical device tree.
>=20
> Icenowy Zheng (9):
>   pinctrl: sunxi: refactor irq related register function to have desc
>   pinctrl: sunxi: introduce IRQ bank conversion function
>   pinctrl: sunxi: change irq_bank_base to irq_bank_map
>   pinctrl: sunxi: add support for the Allwinner H6 main pin controller
>   clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
>   dt-bindings: add device tree binding for Allwinner H6 main CCU
>   clk: sunxi-ng: add support for the Allwinner H6 CCU
>   arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
>   arm64: allwinner: h6: add support for Pine H64 board

Applied the !pinctrl patches.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--tmlmlksbckghjpky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlquyWcACgkQ0rTAlCFN
r3R5iQ//bdp8lhaNBuMZFxAbN3vcM/xITs97YdleOWxkVMgmqXdZn9QOwXrR1aMi
he6sdzERuVONxtn9Iku1PCFr+fW8wx+Ew+4j0ZYkqnZQiq0xG4W7U4jI5LfGwfps
R4zuX0Re6pd3rsl0sm92jmrACRZCp1TgWMK9KfEXKG+HzitJFGraBNSw6GV87/FY
g7Ncn3aF68oTcwQY5n3mu3DbmCD9F/UW46Ne1bdpUY0g6faKVuVu7nWreiiZSEO9
+LpVaUO/r0XwH85aMK3x4O3uer+8zeIQYqyHTlF33Ij4BaHRH6wHVwG3qSDsMtwU
ea2Xbogr/KplxSLGsPqfc5GkHXsaWkaMzE1qG+69hM/SEwjloQt+tPsiIZJdsFBG
2t4wojcPNSaBVslx+knVCS1G8++uisTGEs3Dych8wHZ7sSS6EC8OoALmZnEGS/Vc
B3PrAgXYa8PNtgEB6dti8BOs6qKl8fdxsYQZUlrgqPoWDZfTsEFAS/p0tAkZXI2O
fC4oba8JyOqI+hzSfRkn215CfKow4Szu9ixjULhyCUAnJ2UldTYqGXSIoOnOQ0K9
tM4BZlQViWs7z6g/YVhIkmjYAzQAichm5vbYeyfIdXa575AUUwr0GC+daJTE9HU/
LkV0KBwosK1yZPzCc2oH+jBSXQTzuVn4fQ7LQ/Qy7gff2MNvhaY=
=0d+I
-----END PGP SIGNATURE-----

--tmlmlksbckghjpky--
