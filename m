Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeBEKq6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:46:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:43157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeBEKqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:46:49 -0500
Date: Mon, 5 Feb 2018 11:45:39 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org,
        linux-kbuild@vger.kernel.org, tony@atomide.com, vgupta@synopsys.com,
        linus.walleij@linaro.org, Palmer Dabbelt <palmer@sifive.com>,
        sboyd@codeaurora.org, mina86@mina86.com, tfiga@chromium.org,
        paulus@ozlabs.org, yamada.masahiro@socionext.com, paul.burton@mips.com,
        npiggin@gmail.com, Albert Ou <albert@sifive.com>, will.deacon@arm.com,
        linux-riscv@lists.infradead.org, egtvedt@samfundet.no,
        mgorman@techsingularity.net, hch@lst.de, m.szyprowski@samsung.com
Subject: Re: [PATCH 06/20] riscv: Remove ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 select
Message-ID: <20180205104539.iod5anzzl3axlfbh@latitude>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-7-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vrtyjdsgeszxgxij"
Content-Disposition: inline
In-Reply-To: <20180205012146.23981-7-ulfalizer@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:eYoa+Vxxler6+M1BOyWlfLj0gAWOXVeSTFUCmpq2sWsphuBEWDp
 xTa22WRMbtAAQ+4Y49r3ZKhrrrP6a/znyK/E66Y1GP8FpwhUjChjd8Z14RtRVnTaZW3dGeo
 xDPSmdppUutF8M3aoUO8SNi1nMnkPaJnso9QcyUZMRFzeVinjfvivoo4QoPPc9YYSuWLMd6
 zYIFsqRAnhckweaSVE4+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Cy5GkkpOIM=:hGspf0iJnUDWkOYLv61Ws7
 2dWI0UQjNOeGm6v5DxEst22dBK/5PwERXLdJNGDoJxSCALadqF2sShIujwSzJXewpE6RqZipx
 g9GbMwTEDp1HMH2u6boG0ALfHl/nkULLNZ/ZqLDGu12Q4TTTcmClTCQLmE3B0SXjMtZupe1Dt
 9rPEfx7+i4ymQCGs/vx2anMNJIXI1hx1RYoTRAL3h75syVLBKR3J/HvTPNNBcdsBPaLUiefWu
 YW/+QdXPBJy9sfXWV2DRG1k8vBy5GhpvAVGodwigFju/ZaQPAPWVebFzBRXeA2vTr+hVSDg55
 pdnxl7dMxmTbTyZ4iDfyi3Ll/Q5kXOK4oA+Zq1faf6PN+zrwUKSuNs3v4s53f8Cxalgk9Xa06
 FQ/uAfHZDTVGjddRfLyLKCbCyJgdM+2RaKL0Jul/M/GIzWb+tstBQGXJEKDwvl9RDEMCNjcrH
 s81v6QiDO1oPAfUOlCyoTpUQ/mMgR3Xg7qfndJBf8otFY5pRw6rtouIrqnqHO7SfCoTLnBigE
 5H2kzJ2okbO+SCjx5gaNdHrJMPzicEGpLHqS+/CkNzdzuj56JlStWG3tqxJkpRbLDBf5qB+X5
 1Ll53Urx4NuS2H3Pj63TbFj0XYrNt/METfPLr21bOWfsJUAiWc8Pb4crLJrhPQPJ3QMbwnc7x
 lvcPmYQTWm1NWKOho48GTXHeW65TTgc+41+EGkmRGUsHPH/5yvGwt0yfbCoPy0CDDufQqPnIF
 rwOvTZ5V9tLNJvPljo28v2e4saZmV3suRCuHpslNIJegk7sCPk9aG6mJSXJkURmkYDX/1V8zy
 7/1jIVutPA0NskXQU76f7lo3wtHjA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vrtyjdsgeszxgxij
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 02:21:18AM +0100, Ulf Magnusson wrote:
> The ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE symbol was removed in
> commit 51a021244b9d ("atomic64: no need for
> CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE").
>=20
> Remove the ARCH_HAS_ATOMIC64_DEC_IS_POSITIVE select from RISCV.
>=20
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefin=
ed.py
> script.
>=20
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/riscv/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Looks good.

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b6722c246d9c..ff69c77b9e78 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -8,7 +8,6 @@ config RISCV
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_IRQ
> -	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_WANT_FRAME_POINTERS
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK

--vrtyjdsgeszxgxij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaeDXKAAoJEAgwRJqO81/bUwoP/0qILyd+UJyYbCilYtjkWYhk
Yr4m0DkVOB95w38CY4H9yMUHPBOC0c1+hjNnxNioFfcO+9yFTmvk1XYKtDqEosze
NnOu1DAgnqygv/dUhT181YaJX6UxNZnn2iBhg2s9V86RtMa9YLhU0NiQCaMJgxoL
uUlzS7sC94dgIS1jTGoA+I5AS93vB6Jvv3hB2CJ9vWlFpXa/ZZljKf/yFzb4KJPA
w7wlno4ZyqjaNVTGmwgrXIYf3u+pFV/oyKzm6T7p2K/2fxPbGBA+hFUPj13svlrj
cdz9+k85HntVkCA8nDW3JhAaGCZ1585VeZknWNzCq/JdhVa+vHBbWxIjYHmIWKF1
xAnIgO6WaV1hIWOyY2y+svPB4k/r0QOYYbSDFpPAkw6gRW67l1Os/xZocPZWEsUn
YYW1wP1u8ElLjg5xq3bkNee7SkHDsIhiWeJ5JbIxhYvQ2k/GVqE10gVEIcqc4JOC
eDrOh/27aJmarhWXToP7gh2hLEngNCIxa8Q+RSas9g7csmj5Z/wG5lDAYgWk4cn3
XkyEEff/+64sfz96Cw9SrYCfh4JF8qSs5tayHEZJl8noZmYTUjVuMCSNuWl7NPZ8
wURnAYSkcmM/+YOPaevfeM8xndkno9U9VdYiVjPHB6UYWxU9tEAdIoO9KPRb0lvu
saidDobTPbKald+IBF6N
=FD86
-----END PGP SIGNATURE-----

--vrtyjdsgeszxgxij--
