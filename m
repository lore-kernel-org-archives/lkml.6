Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCXWfX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:35:23 -0400
Received: from sauhun.de ([88.99.104.3]:44444 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeCXWfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:35:21 -0400
Date: Sat, 24 Mar 2018 23:35:18 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 01/11] i2c: Export of_i2c_get_board_info()
Message-ID: <20180324223518.g5jsi5zvoxa75psy@ninjato>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-2-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c5y2fzlvsrcqsj2d"
Content-Disposition: inline
In-Reply-To: <20180323110020.19080-2-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c5y2fzlvsrcqsj2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

> - rebase on v4.15-rc1

This code has changed a little meanwhile. Please check my for-next
branch. Some changes are identical, some similar.

> -	info.archdata = &dev_ad;

Why did you drop this?

Regards,

   Wolfram


--c5y2fzlvsrcqsj2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq20qIACgkQFA3kzBSg
KbYuOQ//Q55O04/Ag8K+cDd7xM96TrhMguQI2QChKgKVFjYNQl9gjofsCr6+Z1NZ
DTd8xi+J7vNUYQZyh5gJRzqQ31PaDH1CLKUKY1xvg5GEP80MyV3+cUYvz28mNgYS
nfnbwUj2KFZcl/GdVLNg8zf3N2YOpJALkZeg/91IQQ1CPq1a4ZyO4Az2RLuJ5UMx
gZGEPPacNHNV5VdBaOrUWYtP2TFHzaeiPrXLj1LwaHcOSrmDRoyBaXSnDTR305ow
fB9P2lpxx/ETe3wHMk0h7UlC467qd4Im/6Rf0yM3IjOfxEXG5KZ8BsmEgLpzaa3Q
hl/KivRMz63F+rtyniyTvFyySRplp4Yge5cX17RhnGIEGseW2MOgWCMzymm41apF
01niaIDW4wQC4xqO9HunLEGCky9xZOxf8K3S3KiErX9XyRkphrG8DHXFkGhfg0Dk
HNjVl9vONd/Y5pTf0gPBEkObcTUusvOGmm9HGhbbP3wHzyu2gHToCoQFV0f4yiwH
VFKxE4WJkauSE/omX0xp6nNjdm0wA1oHUjvmwMj6pKS18Vni70yDRdWiWhh41T0f
k4ldm6iupWPrjaFcVaJ+MgB5BE03ismMpGstvSV9+DDB7FTAQzXr4TECEpTgJlDC
eS9G+JnJzaX1vBesKWIpvNFG1gEJKR6sEjVM0UXQVwbLH7W7Fbs=
=A+ZD
-----END PGP SIGNATURE-----

--c5y2fzlvsrcqsj2d--
