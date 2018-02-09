Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBIPsV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:48:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:40577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeBIPsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:48:17 -0500
Date: Fri, 9 Feb 2018 16:48:08 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180209154807.xkfarpxzpieznfsh@latitude>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="blzswmp6chmlj3mw"
Content-Disposition: inline
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:G5R2X5idfNoNBkojBV2YHVacumuQjakVYWmVi73SZ+USLjgwHrM
 MbS1tZ9kGRqrPCfA8NfdEht8oW7c3H4EOfvEAVPdkiBxGMpFJh/gHcFKYNoZX+pMKVGcM1o
 0YQUZHwUkpPMuvsD44CX5r+yaUL15LWVOUhJOnMma43mRwOFNMhZSXXhN9xrc+MR1h6NpsV
 arW1iCGoXnQqaldeANBXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I6YR967hINA=:m9o2/x9qRuDnKT7yq3rglS
 sssaf/AJj4+hXbi5B7uvzsAPHFIkxbI97QJMWF1Kn4lpQV43KfJBEOk/qiQM8mmJCgSLZLbKm
 e1V+Ob1X4VlKmz+tK/z5sHladPvHeh5tZnecGCXi7Ipr/I94EOeViNqQyqeweW/g6q1IhysdI
 JcKAcH9CLxzRhXvNXFURcWHyiifaenVgEDO/5/LxGcxTKITpfbRbLiKUymSsB6DtITbxGoslp
 8Wt7bBaovklUt2LEFlGWneGUXD1Kx1TWVDG051SZ5Lqv0UUDhUC2Wlz5ODRBoR8EsxlH8a+CL
 YpXmMQiwCdPfwph7dveE83ZxEtTyoTOc72Z1OTlxnLQuYlCTmnGWPaQ3b9QDd4noRWUa8NbGc
 1k3dxkpoFNdskNJ6fs0U1ATjo3G9cL/VgUK/vIA6f/eAGkzsrUfny9Za2SD+4FeSOQJbO25bH
 l0o9nx5Qqfj+2gn06QCG3dq5rUP84NHRj390xSctnbq4XrFIIjgvDbPUDexWrMRCD0YzzciVT
 LwweVRKtFZ8zu7DRrgmXSIIp95pdau9QYC/BLOZNJJgV98upr/DXrxCczTTJvgnP216/ybODe
 U8CI7TFSO/kjDDhkD+OZ2Qwjk4J6tTHboLM3qyCiNkjjpVq4O5uNRmnOHb5hxXJGaKuHiY5H3
 ga6wFpavxNo15CIsgdi9DBz9fbm1uW1NCM9GSBV7Bz3o4ad6BtGAGKo1AC9W79AroUtOcjdQR
 Gp/iR50RhjFNvd+FqoeAUPfxBjp3t3jIQitzB57U95rXWEMRPG5yvmM+Q0kUU8ksmfx9B/vMw
 xrqNbLnbSRvxixA0PJpWEwXVv9ePA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--blzswmp6chmlj3mw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 01:07:29PM +0100, Jonathan Neusch=C3=A4fer wrote:
> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
>=20
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
>=20
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> <---

Ooops, I just noticed that I broke the separator here. This should be a
normal --- line, obviously.


Jonathan Neusch=C3=A4fer

--blzswmp6chmlj3mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJafcKwAAoJEAgwRJqO81/bYKIQALAd9vMfeRv6ofuyS2/g+wEE
ZSTvxxfogE+fHJuTxz1eFHlfisMX74qVW7kmjtB01oHhugVkElI4f22vCB+q83+D
J5dCcxB+QtwoDNURRN3VD2S7dr9oaCmKz2cFSEXBUiM1Kzol1B2W/rmPOPGk6hOv
Sz8zIfgkGFL/CUqXA7OIqlhccl3vpmg3xTDeVFbMz9L0/m35UzkwHyp3BZ5KhIcJ
R2EN9+n2ApKmkYgc0ZiiM65TgvKlkXMd3HQQFml86v9naRzaVPgR0Ft+h9s4uDjE
XhBx96TSi7Zjg4R6a7UfNyoH/watS2L8oiGPt5z+tgqK8zoV3rbwRL/xmoEIWha6
vVg1ALrb0Ww5d9/XHHWeebG5s8R5dAtA6HGiO6I8mPCGo5Toc+8kvOjQ28/Se6p3
L9thxpC62pem4aPzlkUPUPn/GV5QHdBz/Lfu9lkjOa9Vx2wgvxkz3WLM4cAVJIna
h+pfccA/qYHu/BdrU8E5GXJiC3PV+QAbfII18FF9sJSi+PS8wjvb+5pq59eXWxsC
ENQ9MmxNYstjahGgC4YgeK44zix/i90CGOUkZGTKIN1w/iRF9aKlDAPMbbg/5ptT
jDka6KhlH/UCPkHT2JPgL/E0i3sGodOJkXOS5GV8yE8WWrCmN0n6tDfLW0E0CuAC
DVcUna8tarsDfOLtlByd
=EsLr
-----END PGP SIGNATURE-----

--blzswmp6chmlj3mw--
