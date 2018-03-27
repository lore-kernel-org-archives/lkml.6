Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeC0W67 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:58:59 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45087 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbeC0W6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:58:54 -0400
X-Google-Smtp-Source: AIpwx49vrzp3FsYRi+tNutrS5QKU5H+yXxYhTlniDGtksqZaQfpOgpvAkymx3gn3vaixJ80n6Dfsuw==
Date: Wed, 28 Mar 2018 00:58:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: alexandre.torgue@st.com, benjamin.gaignard@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
Message-ID: <20180327225850.GL28163@mithrandir>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
 <20180327225101.GJ28163@mithrandir>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <20180327225101.GJ28163@mithrandir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 12:51:02AM +0200, Thierry Reding wrote:
> On Wed, Feb 14, 2018 at 11:04:31AM +0100, Fabrice Gasnier wrote:
> > This series adds support for capture to stm32-pwm driver.
> > Capture is based on DMAs.
> > - First two patches are precursor patches
> > - Subsequent two patches add support for requesting DMAs to MFD core
> > - Next three patches add support for capture to stm32-pwm driver
> > - This has been tested on stm32429i-eval board.
> >=20
> > ---
> > Resend v2:
> > - Add collected Acks
> >=20
> > Changes in v2:
> > - Abstract DMA handling from child driver: move it to MFD core
> > - Rework pwm capture routines to adopt this change
> > - Comment on optional dma support, beautify DMAs probe
> >=20
> > Fabrice Gasnier (8):
> >   pwm: stm32: fix, remove unused struct device
> >   pwm: stm32: protect common prescaler for all channels
> >   dt-bindings: mfd: stm32-timers: add support for dmas
> >   mfd: stm32-timers: add support for dmas
> >   pwm: stm32: add capture support
> >   pwm: stm32: improve capture by tuning counter prescaler
> >   pwm: stm32: use input prescaler to improve period capture
> >   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> >=20
> >  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
> >  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
> >  drivers/mfd/stm32-timers.c                         | 215 +++++++++++++=
++-
> >  drivers/pwm/pwm-stm32.c                            | 276 +++++++++++++=
+++++++-
> >  include/linux/mfd/stm32-timers.h                   |  39 +++
> >  5 files changed, 547 insertions(+), 6 deletions(-)
>=20
> I can't apply patches 1-2 and 5-6 since they depend on patches 3-4 for
> which I'd need an Acked-by: from Lee if I'm to pick them up. Same goes
> for patch 7.
>=20
> By the looks of it there are minor conflicts with the MFD tree, but no
> major ones. Perhaps it'd be better for Lee to pick up 3-4 for v4.17-rc1
> and ack patch 7, then I can take the rest after v4.17-rc1?

I can pick up 1-2 which are separate from the capture changes and have
no dependencies.

Thierry

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6zKoACgkQ3SOs138+
s6EqRRAAkRwgzcvLainnfSdNnmcvpZVYCBjxD2dFw2SXH1nPlNmTiJZmmOhlbCWZ
emhJp9l/fPtH19nl6rLZVIekik1r1+zlCinpggQ/zD0BFXOIDbfDvFl45d+Tz67a
LzDJcwHn/IYXFqCCRTSa1pAiGTPY1w6t3KcvKwIUH46bwYwZjyWMGJiTsxrKmVlj
mJi1c105dcuLGz+XYy/l9fOOiByz6buM/tKXtyKkW+9r9XaA9ZjXMJGPfUiVdfvP
8Gfptk4hDy/IX71w/PxNK7pXPCwEN8MV7qSlHtccfK0YYb6n7/aV0nLwXxV5umQO
gdIyvx50FwJ/0incSayoGyAzdSLdrkto4myTnhJ8a1rFtva1IjIhCHgH56Q9JACC
mNfFEmgZM9WJvIfXLfmoA5KUD3Tp7UOiXuet2a7tkg/L75JdwydBUCkZ6iKfFR1X
+nrV3yOF1P1aI4QnX2dBj3e8EhQ0ZUzph0tUESKnULcYU/oKtMhzvSogqH7A/rtw
CXgF2bsrWqXBFE072AEm72M+1nZGUp7yvWY6BBVxS6ETRNhpoaqhsG0oVQq9FBvQ
JSgZBIJFK7lDDt1vrN3sigjM5blbfJANeDArtVbJG/mwL90/54+Dsg3DcSntDC9+
P41nbABA5fE0InTfrp5Ca917GWX6oo4f39x4xVeIaxZ8UUiqAv8=
=BvON
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
