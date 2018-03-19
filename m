Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967437AbeCSRAM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:00:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37219 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966743AbeCSQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:58:32 -0400
X-Google-Smtp-Source: AG47ELsGOHL01+3j7iz8SBSjCLdOjbTkJ8vEip5rwfDE7S0UajJM3gy0Cunle9OkiDvzTXs3J7cIGw==
Date: Mon, 19 Mar 2018 17:58:29 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [RESEND PATCH v5 1/5] pwm-backlight: enable/disable the PWM
 before/after LCD enable toggle.
Message-ID: <20180319165829.GB22770@ulmo>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20180216174034.15936-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 06:40:30PM +0100, Enric Balletbo i Serra wrote:
> Before this patch the enable signal was set before the PWM signal and
> vice-versa on power off. This sequence is wrong, at least, it is on
> the different panels datasheets that I checked, so I inverted the sequence
> to follow the specs.
>=20
> For reference the following panels have the mentioned sequence:
>   - N133HSE-EA1 (Innolux)
>   - N116BGE (Innolux)
>   - N156BGE-L21 (Innolux)
>   - B101EAN0 (Auo)
>   - B101AW03 (Auo)
>   - LTN101NT05 (Samsung)
>   - CLAA101WA01A (Chunghwa)
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
> Changes since v4:
>  - Rebase on top of mainline.
>  - Add the acks from Daniel Thompson and Jingoo Han.
> Changes since v3:
>  - List the part numbers for the panel checked (Daniel Thompson)
> Changes since v2:
>  - Add this as a separate patch (Thierry Reding)
> Changes since v1:
>  - None
>=20
>  drivers/video/backlight/pwm_bl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

I'm surprised that panels even care about this. Do you see actual
breakage if these are the other way around?

Anyway, this seems to me as legit as the other way around, so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqv7DUACgkQ3SOs138+
s6FtSA/+J4+ctso+elhrUgaQEp71DttppYWGb10uYQS8GV16ZtVU2367zWt+9WNF
u0VGLmrwwvqFpvxDAQ8YYE07758CbkdWb5qonRmdN4pLOi3aNw7ywHS5ysljyPfi
Wv6tw2RaNGVCPcRH9MNwK903y8flOVLgz83CsnBtIWvM9nnSRp8IlQrzh/GIPb92
FdrrG1cDpwzgMvD+gnXH2TBvMTM8MH4qIpYSixkim4QNZ61LDHJ9CBcc+DLpiCjX
Qb31E6SemW+S4sdAq+dpgRH3e+/CCxyHcLkQWfBpsLd1aGA2AWgDhI2OdIVqLai7
QFE8eiJMqra0hV7MYF2IvYjMzJcUp4+JkPXA5slo0wW+CuJ7Vs4oDF1gHzLjsMmR
lpHUvIKoDddEaGwk7BCaiTDaDz4YPcdzcreBdwstD05faxDkPxycuEmwRpS0HvSB
q6Vaiuh3DaCBnkQFy3dlSSrWJ/f3B2x9g4rD1f2vv887tB3IP1lBna9sr7u9WJzD
95K0baI/rbXmRrGh/K+bT2zxmSUjlTOM407n1IG/ig8+06/J6Y4bOCvcHBqUGG8Y
R/8xqTSKtfutsDJBn7CrN0hZladFG0b5csW3ZMW0BYuqyyYWklHI95eAgoRS3xH8
QZADh2oGyMr4Ja12GTl8ynvGkO5k+aKDrze0CXwbkeTyL+tOvDU=
=6Ehc
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
