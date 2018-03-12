Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbeCLSDh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:03:37 -0400
Received: from anholt.net ([50.246.234.109]:57740 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeCLSDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:03:36 -0400
From: Eric Anholt <eric@anholt.net>
To: Matheus Castello <matheus@castello.eng.br>, stefan.wahren@i2se.com
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v4 2/3] pinctrl: bcm2835: Add support for generic pinctrl binding
In-Reply-To: <1520615640-9153-3-git-send-email-matheus@castello.eng.br>
References: <483687035.384686.1520596004410@email.1und1.de> <1520615640-9153-1-git-send-email-matheus@castello.eng.br> <1520615640-9153-3-git-send-email-matheus@castello.eng.br>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 12 Mar 2018 11:03:33 -0700
Message-ID: <87h8plxjbe.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Matheus Castello <matheus@castello.eng.br> writes:

> To keep driver up to date we add generic pinctrl binding support, which covers
> the features used in this driver and has additional node properties that this
> SoC has compatibility, so enabling future implementations of these properties
> without the need to create new node properties in the device trees.
>
> The logic of this change maintain the old brcm legacy binding support in order
> to keep the ABI stable.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

2-3 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqmwPUACgkQtdYpNtH8
nui7oA/7BSwZ7qOWiwCgJLj0lE13Ym7zgzizCgHnadNzkNGHGlKrcTLcZQjwH4L3
IFztyPWlGrjg/Sx9MiRLJDLtGU/Pq8MJsYeYXC3bEqS29DythwSW1wU5OZj0fxrR
2kevNt/hPhuPTPihh4XsofEK4XvK93KMQmtbQu210UaLf9uxNp35OgiPuDdYAsoQ
/kgHrU1rENU87VW3mqZY/RQ0CBn+KL7V6Uv9N3PgwvoLskpXFggHdWl51lRq/Xyt
TgxjkeZVByvTWbSvW+PDGG/KGznc+9GK1Ddg/NpS2mTKa0zYQLTbJgdBrhkzIpnG
6Q7Shzic/i4Uus6KZZkQH7jjLZAmmbZA3yi3JuAgUzzZYiyZ4tFz5JXbFkFvRtRY
Mn/qW4Dd54VyaiuWxFN4rI5OmraIGNpo+yp2/LRVY3iQIw3WXHfdD+2ExGwH2phL
rrUwe2hvJXrq/dK1wawkTGa+4xBzfEGt9ZVX6U80YTVkdAQQykzr5AMqADusjCbo
fgEueKOuRefkbL8kL7fN+YD4ceT8doLv2BY9BpOjUbqmkv0MWN6r54SoNy+FCBDZ
b4eKZ0DqmXGpzrT6XiOYBWoJnHIgIUlW1mV0EzoHZBYkJzN/vpSp5qzgkCqUfNCu
jK5/9VHNqlQybWQy/fSnmq0LR/fMpG9lp3h36gLgoMvH5/ACTMU=
=V9Wi
-----END PGP SIGNATURE-----
--=-=-=--
