Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeC0WvH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:51:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36560 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeC0WvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:51:05 -0400
X-Google-Smtp-Source: AIpwx4/xEQtN8sGIbCnFw4eTyBvZRPph8k8jQQ6Mz1/hhLrZpbWiCDVyK00CrWpoFfCSwDm0OYHz/g==
Date: Wed, 28 Mar 2018 00:51:02 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: alexandre.torgue@st.com, benjamin.gaignard@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
Message-ID: <20180327225101.GJ28163@mithrandir>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 11:04:31AM +0100, Fabrice Gasnier wrote:
> This series adds support for capture to stm32-pwm driver.
> Capture is based on DMAs.
> - First two patches are precursor patches
> - Subsequent two patches add support for requesting DMAs to MFD core
> - Next three patches add support for capture to stm32-pwm driver
> - This has been tested on stm32429i-eval board.
>=20
> ---
> Resend v2:
> - Add collected Acks
>=20
> Changes in v2:
> - Abstract DMA handling from child driver: move it to MFD core
> - Rework pwm capture routines to adopt this change
> - Comment on optional dma support, beautify DMAs probe
>=20
> Fabrice Gasnier (8):
>   pwm: stm32: fix, remove unused struct device
>   pwm: stm32: protect common prescaler for all channels
>   dt-bindings: mfd: stm32-timers: add support for dmas
>   mfd: stm32-timers: add support for dmas
>   pwm: stm32: add capture support
>   pwm: stm32: improve capture by tuning counter prescaler
>   pwm: stm32: use input prescaler to improve period capture
>   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
>=20
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
>  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
>  drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
>  drivers/pwm/pwm-stm32.c                            | 276 +++++++++++++++=
+++++-
>  include/linux/mfd/stm32-timers.h                   |  39 +++
>  5 files changed, 547 insertions(+), 6 deletions(-)

I can't apply patches 1-2 and 5-6 since they depend on patches 3-4 for
which I'd need an Acked-by: from Lee if I'm to pick them up. Same goes
for patch 7.

By the looks of it there are minor conflicts with the MFD tree, but no
major ones. Perhaps it'd be better for Lee to pick up 3-4 for v4.17-rc1
and ack patch 7, then I can take the rest after v4.17-rc1?

Thierry

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6ytIACgkQ3SOs138+
s6Fr9g/+KQ2WA9ip9DbgL8elChIvKtWOVCS3lcsNMKOS6GpIQkwMoIFKZyImNd1x
sONlawlZ1mtgMX6MCbtUY/FUR2KZlRcPRWAyNp+c/Ya+XcrYIrVpM8OHvIeENcsB
iImDC5Kroio77hku6KeYtl+oyKDgcQYOgDYGWCDyfvia33/zd66FkvTL8tDzAVQj
8xOn6f6sqKs8qm/YCIXZvD1kJZS32xLN8Cxi33B4IbqOA8lUs0i07ZR9ugHuMdAP
gElgw9The25eEFoM58J3oZTe55aE6RfI/6Ur2v8KVUOVLKU6XPVIupiV/j2C9iWX
icWhZoissyVw9uexTnFYAA91U+w7Yp3B9ZmRY0jK0CXMY6Zf4vpjTDyBlWRFF3ja
d++ud0V+pBHelAipOvEX5myzmR5mUs/nTLmRjWGwSe0poR/VYeLcASm59BZ45zzd
AcXBtlEze8JAGP8e8NLKW30XkxvS6AoynCLDTuJeghq8frH11Ltq7SjF42PAj1wt
rleLcsW2S6TXMxubS7zrG85AOM6RwZglpk5+4rTLKJv1Vaf2u+eElefPj8fMMuBT
GMyjgDPA0zmxxt4ywnmJoHP7RFeJXuGAq4co6ZGTlZYSvpOWs+iCq0E4nHN5euW8
LBRM0ucagBCbA9AizX41eYJZfkhnsz/kYhcKi2oDqM9SCgFhN0E=
=MQsM
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
