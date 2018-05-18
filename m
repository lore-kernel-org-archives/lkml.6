Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeERWFY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:05:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35851 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbeERWFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:05:20 -0400
X-Google-Smtp-Source: AB8JxZrP7CF2Ns07qWAJEs2MNKWmw+g9QpK4UOTemFfvpQyGkkhwA4Ac/TobQ4THC11h346a+TPzKA==
Date: Sat, 19 May 2018 00:05:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, rdunlap@infradead.org, sfr@canb.auug.org.au,
        gerald.baeza@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: stm32: initialize raw local variables
Message-ID: <20180518220517.GD28123@ulmo>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 05:24:04PM +0200, Fabrice Gasnier wrote:
> This removes build warning when COMPILE_TEST=3Dy and MFD_STM32_TIMERS=3Dn
> in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
> 'raw_dty' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Lee,

I assume you'll pick this up into your branch where you applied the
initial patches along with 1/2 in this series?

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr/Th0ACgkQ3SOs138+
s6GinQ/+I1AYeroFcpvzzR4/KC9jYBJU5YKHtMnx/tR7Z0PDeRXTPUc12k53T97H
lFMvHZ5V0sucs33IbCxncT7NZ+mcg5YJDbhj89Q4m3f2HGGOzRgygXHFWrhsL7Ys
OMGCFZALjxHTOyNSNJNwNATW1LZxD8Nexm5wdVwOUIfcuSpL0Sww5Ha9m0Q7M03X
Tut6UkRWViTdauLqLA82GrX+EGoyMlwlhqZvIQkAvwSSQQ3tBLGkXvUah8asHGPe
SLlONoEW5Uh3pjzqLlpGBpakr7xKCaFV+sQpHh4Fjhz1HQ/lzOPYoc+j5HidE1Pk
mgL3i18XNYWFoZvEM9d0eUkdzRN5MYnl2Av6FNWzIRZHB6QerE0U1Xv0A1EyDutk
QBK1OFOB8G6n7TqEDhUmbRgWcXLG1IRQwX714RNBwnnqHr/EPCi3o1VOFPhTtQYD
e6QyhdOXKvSCLk55IW0wcQrlxI8qX8UBJqBZaATBPxOEFt6IAzsRCHcqoceDHdnk
FvCLCK1O7q2HUGFIRO/LpWmXtgFZEqZrnmKbN60TFcQcaHNixW5/W3u1t7LT8Fdm
zcQRcik7akpjD91mHn2o4znnxTSdMoDy9FhOrWz6MwFZwQvErdoLC6GVukOz77ty
0CLJ61ipHOj8T2o/Y0ZCmym7xn2HqEdE4NBs2JLiVkWIy4vGVEo=
=+UwI
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
