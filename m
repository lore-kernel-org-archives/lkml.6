Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030187AbeCSQ7a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:59:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40594 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966570AbeCSQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:59:25 -0400
X-Google-Smtp-Source: AG47ELtCoOvczKRiJIIqiK+p+pMk+3kUDIDYzE/BezrdtX/BGEGfXHumAvnWPV2QtTeNIu0F9BPeiQ==
Date: Mon, 19 Mar 2018 17:59:22 +0100
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
Subject: Re: [RESEND PATCH v5 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Message-ID: <20180319165922.GD22770@ulmo>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180216174034.15936-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <20180216174034.15936-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 06:40:32PM +0100, Enric Balletbo i Serra wrote:
> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> request a delay between set the PWM signal and enable the backlight and
> between clear the PWM signal and disable the backlight. Add support for
> the new post-pwm-on-delay-ms and pwm-off-delay-ms proprieties to meet
> the timings.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
> Changes since v4:
>  - Rebased on top of mainline.
>  - Added the acks from Pavel Machek, Daniel thompson and Jingoo Han
> Changes since v3:
>  - Use two named members instead of pwm_delay[] (Daniel and Pavel)
>  - Use msleep instead of usleep_range. (Pavel)
> Changes since v2:
>  - Move the pwm/enable sequence to another patch (Thierry Reding)
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
>  - Move the check of dt property to the parse dt function.
>=20
>  drivers/video/backlight/pwm_bl.c | 19 +++++++++++++++++++
>  include/linux/pwm_backlight.h    |  2 ++
>  2 files changed, 21 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqv7GoACgkQ3SOs138+
s6F9GxAAqXp9JE/VvfuJ/zqbvGh/hLA1/RJzfV05dGFb5pk9QoKYjKgIZSaJ9VyB
rNEnjma8Mbj89T4emlMg+3jMXXBiMGUv9vfDR+XO7GQI1bhGgp7JQUUmYg3d6a/F
CUL3jR0RJWlqChyDgU4VkZJqlfF15t7Vdmu8zrpVaMSmNSSCnlNDYM6EZ7v7Fmct
zWxgfovvsV+E/cCAcJQvUxPL5bZWFlTcoWAbhL+xUyCNmChBKPIgiFMbaYBlBREC
7teXLSnQ2OVD4p0H/SpkMDD2fTAUChpSoUWVWhnxa1Z8NCY0ZikF5srsWr+W25bO
tixRdRPR/1l/1x6/3kKvWO5/mrKxHhMcCHxfe4QY5PgtsDCiFgFwJ/nmN5HPVuYa
+clnAbDcytGfv31fLlnvd4+04CnVFyHjzaSIWjw4kKjmJd6d6rWs+4E4XlVmJtku
s2QMW4bN5GBFqteNRR0zLDz0bbEYjiZtTwOf0bs3bViw8sNh2rw0/KUogfFumI3F
4WYqbapezDnXiHoA7MX349f9z9TVuHvE7fioK+GQW+6wfkTuY5GAmqCxfsO254Uk
E9gtIZ0W9qFlga2mHp0hBUwzLdAhei4x8uZ8bNF6hKSlBLRj4Agn+XOaLzJYJmiZ
DrOaqv0lpcX/1ERM5HDsLjKdj5VaKov1lyjUo4G5JCl59TmDZLo=
=3DKy
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
