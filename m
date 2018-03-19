Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967750AbeCSQ7K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:59:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53403 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967734AbeCSQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:59:01 -0400
X-Google-Smtp-Source: AG47ELvjcFThb2WK+zTrdK390E2W93hzpwz4UPiJmIbY6VTwwUEAZPObl6CYYEtWDbDztTWMf7Dvhg==
Date: Mon, 19 Mar 2018 17:58:57 +0100
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
Subject: Re: [RESEND PATCH v5 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Message-ID: <20180319165857.GC22770@ulmo>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180216174034.15936-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <20180216174034.15936-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 06:40:31PM +0100, Enric Balletbo i Serra wrote:
> Hardware needs a delay between setting an initial (non-zero) PWM and
> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> this delay in milli seconds. Hardware also needs a delay between disabing
> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> is this delay in milli seconds.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
> Based on the original Huang Lin <hl@rock-chips.com> work.
>=20
> Changes since v4:
>  - Rebase on top of mainline.
> Changes since v3:
>  - Replace us for ms.
>  - Add Acked-by: Pavel Machek <pavel@ucw.cz>
> Changes since v2:
>  - Use separate properties (Rob Herring)
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
>=20
>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 +=
+++++
>  1 file changed, 6 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqv7FEACgkQ3SOs138+
s6EmRhAAvQoqOUtOrU9WHdPx2cIEabOUKHd8FRVlipvxdmyWbokiKCtb/Aii2Fb+
Fzb6na2uuhixgnpdouYDA39G10Y6ol1nQFIrr4/QjEgdAuDRkLgpYOcyDTNQAAc2
TXdbndRtdckEWoqIRt285DnKAAk9/L2ya8YUWN5Y9sHGuTwQy6sIEa0UdDmp95hn
GlcFr4M6+zhovrk7K8wg7AwqqH1h8VFlycieoiGJbe7LI08kMh8M6IVGUV9DjVCT
gWeukCAdvlzbf7osoEs1faKmpA+75XGYGrOhaD0/zRdNZ1rxvy5hKxDOYwcq+Rxp
MZnO6RNYGzp8k7y4HTjInunrGx7MWCGejxk5CTf7do7zADb9ppESKDzEaJdlNs6Z
bRA7C9LLKdazQz/EYoDVnFzmOYSjlxsmEQ1Qri3xr9ylnzRy/QJSICsKQOh+OHdo
M4/qoHPszt9yMWJFuZ9rqSZWVwfoQ7nmfqhNgl+lGJ9c6KJNokywL5OCx+ojbZAK
J+cp7cHS1Of4OnRFkkvITGPapN0TU8hLQt7WCL/ZPmsBkfCuEHCzqlIbyAf5UGOF
pJNmlxHJVJwGUC0w9yspywWce5gwfN3iuTI9Dt5Klz0dlidQSzF1HtzPmgYKWCMV
yO8+bJfNDHxDQGm71hVUmTQTsFdPIR1nk6TKnLNyJP4YecNXZ0s=
=oc2Q
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
