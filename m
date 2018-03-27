Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeC0W6G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:58:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44883 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeC0W6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:58:01 -0400
X-Google-Smtp-Source: AIpwx4/AC+mXOREqneKqzoV7YOCyAFYfuf1niRbpHOT48qjfLSmhAXKLb7aIWq9yf3Y07w8WC3BHSg==
Date: Wed, 28 Mar 2018 00:57:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        benjamin.gaignard@linaro.org
Subject: Re: [RESEND PATCH 0/3] Add pwm-cells on STM32 LPTimer
Message-ID: <20180327225757.GK28163@mithrandir>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:36:02PM +0100, Fabrice Gasnier wrote:
> Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
> of channel, period and polarity.
>=20
> Fabrice Gasnier (1):
>   ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743
>=20
> Gerald Baeza (2):
>   dt-bindings: pwm-stm32-lp: add #pwm-cells
>   pwm: stm32: LPTimer: use 3 cells xlate
>=20
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
>  arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
>  drivers/pwm/pwm-stm32-lp.c                             | 2 ++
>  3 files changed, 10 insertions(+)

Applied patches 1 and 2, thanks.

Thierry

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6zHUACgkQ3SOs138+
s6Ewuw/+Pvzqzm3HeKqw5SBFJCQzapVxLd5mXoopTKym8rM19GYk3fyNQmTOPdqc
zRNtxBolzGPAZzPtyLtW9p9W85j6C9SVbaXDsANMY+s/bNetjZ5j/YI6MaGd0MPO
As7akyi+NBWmar645OFXeYGyT7v5mVAg+0Yp3h8KMg7mBgpdnAmi2QmdPHGrtSK5
pumEVCXztIpWRm+TXilUh0xNuex9WvHRINH9uLIiORmsBH0zCrSFU9H/nOH84t8a
hxwJCKSDGNRpeSOV4ZCdmlYDYiG7nP7IN0AN2FSIyJgmdHrfakNkyqZTyZ0g/cF+
Jl0xdBw8BnNzKEQob4j95ypdaE2SirIOGSNSKhHv2BcDW/fdfH9wyb44V2QLEckH
wGwH/eeuuCP2gu6uij5ZmGvQX9vRn1LXnQyobDHV4bgp1Nuwgus1DeM2EBY0aPrG
N03kcr+SNbjf7gpwft+0pEFoTmsA5oQtOPoRvSDmRjh+Zd0LwcFTtt6TBhkAvX9x
zRGtTe8QmHEj+iwoONSpcjTVJYw6oSC96y8u/t8H6WiiRVUxF5cOnyeQOXNkrDin
on4e+KwOUmqdxS4Nm/6f9nLefsBNNBJd5OmXm4eJ7bSbB8t8lxcUQIsR3O4uVZBn
3nTDkumEWxOYHefz2zYLYba2kudNOuDdKvt7IhQhxh2HlRcP/6A=
=7nCY
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--
