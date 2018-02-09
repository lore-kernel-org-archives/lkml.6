Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBIMGy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:06:54 -0500
Received: from anholt.net ([50.246.234.109]:51238 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeBIMGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:06:53 -0500
From: Eric Anholt <eric@anholt.net>
To: Tuomas Tynkkynen <tuomas@tuxera.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable serial console on RPi 3
In-Reply-To: <20180207005309.14365-1-tuomas@tuxera.com>
References: <20180207005309.14365-1-tuomas@tuxera.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 09 Feb 2018 11:12:45 +0000
Message-ID: <87fu6aa02a.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Tuomas Tynkkynen <tuomas@tuxera.com> writes:

> The Raspberry Pi 3 uses the 8250-based auxilary UART of the BCM2837 SoC
> as the primary serial console of the board, so enable it in the
> multiplatform defconfig.
>
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

I'm planning on putting this in -next once rc1 shows up, unless people
really want it in -fixes.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlp9gi0ACgkQtdYpNtH8
nuiraQ/+MdikkFU38G3v9Z5o7tk/dDoD8ypEMGTjIKRZZMbRnTigUqOPOOCMQhs/
ihMhC9lwxc8geL3Qd5PJcgJsSKwwiR8gyYbLrLoRGaQDzs0Mge0LvbVQR3t37Bfv
ANScJqoE88cVuDVtvPgi/BmRIgnNLrpqu2dprlxN3erYEGFC2dibNnUOpPvWMfP1
PSfR9KKE8E0vLvPPKJq/qUmJyQ8vdau8eqol42ZI8e1QlH8Yrp5kwW9p4gpqMWTb
5/Ttg48G0VS2GCmMd7taS36ijF0BNFUu/oSH8e4CX0zvzIuRYDe/vNYsOWGlWJHv
ATFZe+SOYgRvXik6jiCUQDqucWi2L7eKceXym3G3LXDfjth3LwwK3jfuQ7QSxBqy
zX10lndJqun8dFs2I+oH5zGe0tV7kO5RZCfVFb8oqFVrPAsbwYFGzBwxtTdjiOyg
ciGGvOa8FzPtVoBZqL56JGgyRCfYBuw2ZwFl7J+GaYVBRxWWB5NI1BivpL0Tw9eq
WiRj1OarYCP9dEhm1qERsyvYKhpuEOReXjcv7jY+QTKHkDsxUAXO5XFUOmhb2gNF
+vJEsX+oWhU2fQb2GsJpXZUASwk3LnLYA0dDfPHS2B6yCIS8aZ1V6R6UbY0JHCS4
7IxgdL7tcDaMdRxQLllLiFluiTlyxuFPzRXSEtKcghhv7a9lvN8=
=73Ce
-----END PGP SIGNATURE-----
--=-=-=--
