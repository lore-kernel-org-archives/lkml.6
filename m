Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeD0KNm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:13:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53581 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757609AbeD0KNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:13:40 -0400
X-Google-Smtp-Source: AB8JxZp2FRaJDQWln4R8UDr2VW+ALZan63+nRbaRkDkGLQ/8Pfx+xN/D9svfBP7qdagvHg6s4X1WJw==
Date: Fri, 27 Apr 2018 12:13:36 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: move various timer bindings to timer/
 directory
Message-ID: <20180427101336.GS30388@ulmo>
References: <20180426212744.28688-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ShzQXCswyqjgWi6k"
Content-Disposition: inline
In-Reply-To: <20180426212744.28688-1-robh@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ShzQXCswyqjgWi6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 04:27:41PM -0500, Rob Herring wrote:
> Bindings are supposed to be organized by device class/function. Move
> bindings for various timers to timer/ binding directory.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/ux500/boards.txt                  =
| 2 +-
>  Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt              =
| 2 +-
>  .../devicetree/bindings/{nios2/timer.txt =3D> timer/altr,timer-1.0.txt} =
  | 0
>  .../bindings/{arm/arch_timer.txt =3D> timer/arm,arch_timer.txt}         =
  | 0
>  .../bindings/{arm/armv7m_systick.txt =3D> timer/arm,armv7m-systick.txt} =
  | 0
>  .../bindings/{arm/global_timer.txt =3D> timer/arm,global_timer.txt}     =
  | 0
>  Documentation/devicetree/bindings/{arm/twd.txt =3D> timer/arm,twd.txt}  =
  | 0
>  .../devicetree/bindings/{powerpc/fsl/gtm.txt =3D> timer/fsl,gtm.txt}    =
  | 0
>  .../bindings/{arm/mrvl/timer.txt =3D> timer/mrvl,mmp-timer.txt}         =
  | 0
>  .../devicetree/bindings/{arm/msm/timer.txt =3D> timer/qcom,msm-timer.txt=
} | 0
>  .../bindings/{arm/spear-timer.txt =3D> timer/st,spear-timer.txt}        =
  | 0
>  .../devicetree/bindings/{c6x/timer64.txt =3D> timer/ti,c64x+timer64.txt}=
  | 0
>  .../devicetree/bindings/{arm/omap/timer.txt =3D> timer/ti,timer.txt}    =
  | 0
>  .../devicetree/bindings/{arm/vt8500 =3D> timer}/via,vt8500-timer.txt    =
  | 0
>  14 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{nios2/timer.txt =3D> timer/alt=
r,timer-1.0.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/arch_timer.txt =3D> timer/=
arm,arch_timer.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/armv7m_systick.txt =3D> ti=
mer/arm,armv7m-systick.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/global_timer.txt =3D> time=
r/arm,global_timer.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/twd.txt =3D> timer/arm,twd=
=2Etxt} (100%)
>  rename Documentation/devicetree/bindings/{powerpc/fsl/gtm.txt =3D> timer=
/fsl,gtm.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/mrvl/timer.txt =3D> timer/=
mrvl,mmp-timer.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/msm/timer.txt =3D> timer/q=
com,msm-timer.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/spear-timer.txt =3D> timer=
/st,spear-timer.txt} (100%)
>  rename Documentation/devicetree/bindings/{c6x/timer64.txt =3D> timer/ti,=
c64x+timer64.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/omap/timer.txt =3D> timer/=
ti,timer.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/vt8500 =3D> timer}/via,vt8=
500-timer.txt (100%)

Acked-by: Thierry Reding <treding@nvidia.com>

--ShzQXCswyqjgWi6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri99AACgkQ3SOs138+
s6FPgA/+KmO8rLO8DeVz4hTVQkSZMT9oBjUgYDb3soPHKT7eZ51YG86cCxit9ldL
j3LYcaW6U8BYN5h93VPG+IF3w9BAaV6oBiB+NxxcPb0vJU94G/vxOCz2qMgVPm5k
XOjfMJ5Ve2T/5EBEFXbTcczqomVZI3B1XMFTkmXDimQVwMVvcD4ZKaLDdTBM2Z2f
6adf2FNcCmKt12NbJwjyp6VaplyIQ9o93InkWKD/lcNSmqIwoODzCYiCdZXNyj+Z
S6suOXT7t+2TUcOBnd2weskRrqZjLV5/o4ziVN5T3XCamwFioIF9/YR4Zy0SzzXb
5a8nv3ucCTV5iFc0sUD8syZKAe5amTmiNTK9dtkeElD0xCIqtyOb3dKGfJgHcDGQ
/CncFgkFD/0ST6OUK4L+JfEN2PGfSO3ABJWaTCDHtbtW1knSAOvbNjzrpNjsknFa
eD7E/BIjyFmJpJRKOtKlMNvWWB20xHwxmb5xWMebkInUEw9jc6FoGdwpD0ayeXuZ
CaKBrgJCByhQFL9UFTrwdsZfU+xM5EYm+WgRmmimGbQnezF+NbgJkJYh8bTMqotY
iPVS55J6CvMUfbGqD22zmOwhLpqNzBl3iHm8lO8edeg+pK2muC70ZvkKgWq4qo00
ghJqLDZPctoRq8U0W683oQzHqt7PGPmnXUnPRj8OhxOU11lnYUo=
=r08i
-----END PGP SIGNATURE-----

--ShzQXCswyqjgWi6k--
