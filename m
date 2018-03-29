Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeC2I6p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:58:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35740 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeC2I6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:58:41 -0400
X-Google-Smtp-Source: AIpwx4+Vo7Zjb0gB8y7YD0F3UXlCrE+HRNFJekairwcxvi2u/SvxecgMWF1PEdGZ0CXD1YdA5pbM5w==
Date: Thu, 29 Mar 2018 10:58:37 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
Message-ID: <20180329085837.GA16952@ulmo>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
 <20180327225101.GJ28163@mithrandir>
 <20180328100309.yig4d3bmml6jvodz@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20180328100309.yig4d3bmml6jvodz@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 11:03:09AM +0100, Lee Jones wrote:
> On Wed, 28 Mar 2018, Thierry Reding wrote:
>=20
> > On Wed, Feb 14, 2018 at 11:04:31AM +0100, Fabrice Gasnier wrote:
> > > This series adds support for capture to stm32-pwm driver.
> > > Capture is based on DMAs.
> > > - First two patches are precursor patches
> > > - Subsequent two patches add support for requesting DMAs to MFD core
> > > - Next three patches add support for capture to stm32-pwm driver
> > > - This has been tested on stm32429i-eval board.
> > >=20
> > > ---
> > > Resend v2:
> > > - Add collected Acks
> > >=20
> > > Changes in v2:
> > > - Abstract DMA handling from child driver: move it to MFD core
> > > - Rework pwm capture routines to adopt this change
> > > - Comment on optional dma support, beautify DMAs probe
> > >=20
> > > Fabrice Gasnier (8):
> > >   pwm: stm32: fix, remove unused struct device
> > >   pwm: stm32: protect common prescaler for all channels
> > >   dt-bindings: mfd: stm32-timers: add support for dmas
> > >   mfd: stm32-timers: add support for dmas
> > >   pwm: stm32: add capture support
> > >   pwm: stm32: improve capture by tuning counter prescaler
> > >   pwm: stm32: use input prescaler to improve period capture
> > >   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> > >=20
> > >  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
> > >  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
> > >  drivers/mfd/stm32-timers.c                         | 215 +++++++++++=
++++-
> > >  drivers/pwm/pwm-stm32.c                            | 276 +++++++++++=
+++++++++-
> > >  include/linux/mfd/stm32-timers.h                   |  39 +++
> > >  5 files changed, 547 insertions(+), 6 deletions(-)
> >=20
> > I can't apply patches 1-2 and 5-6 since they depend on patches 3-4 for
> > which I'd need an Acked-by: from Lee if I'm to pick them up. Same goes
> > for patch 7.
> >=20
> > By the looks of it there are minor conflicts with the MFD tree, but no
> > major ones. Perhaps it'd be better for Lee to pick up 3-4 for v4.17-rc1
> > and ack patch 7, then I can take the rest after v4.17-rc1?
>=20
> Sounds like a faff.
>=20
> Why don't I just pick them all up (except the ARM patch)?

Fine with me. For all the PWM patches in this series:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq8qroACgkQ3SOs138+
s6FL7Q/+Irm05gCxo3p7ZUuuUD8ishP/EJzMPZ0j0CMLQz/I0L0YIihDwrEJiV3B
CpvOxJYhgAiOt2/99r3E7EdXvtS0BFqbeLmsuoY3vESWyEukfjeC9zDZbZkZ0W2i
+fzbuo9KL4tpBK59NuWKAB8HTj26Zj9qdYv9FON/xN7VyauFRR1HCRJOdFzprjRK
yNkHEBQ7BKQcpA58wOmUgFpCNAuhYro80jtw6FZEUNdEoqxDSFtqQejNyKhz23b2
Yf+op5CG1GTkY6nNKguiZVzpM1UZ4zSSSTdnYZC8lCyaaBZ/mFVk4cS9Bvutswd8
SazFm0pNuziAeSrO5SZ8jnJs17JrbcWa/RBN9Gwlddh7kFiXW/nX7WVW6/yIKTVq
XSWlY+ygUTpttrtsDwtHXDBcC6nKJ02EgpR0eGbk3MJHdkEffN/NwZhWKWcyo9YU
nEBCy2t519nSEtZXGK2uAocXEdAmcgfVXLOo/hRZrxL7HN8ppLL6feu1rwEiLLYL
n0SrDMzYuDY7ZYZX6ioYMM1wan8Na8RMNbOYyZpmdbf9jhotTu4EFGzdFNDo7C8E
DR+pbdCFPJtMPIlnyHgXn3H8y0OVc/CZVH9oVIKrbTyGYZxpuCt+MUmZifaTcMmy
KdeFqpO4RU+/OzQbcfBQjh2Z/AhL9tfzkJmdE05w0wb90nP+yYY=
=uu/R
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
