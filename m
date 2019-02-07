Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87A218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qs5ZP2dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBGItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:49:53 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14251 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:49:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5bf1100000>; Thu, 07 Feb 2019 00:49:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 00:49:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Feb 2019 00:49:51 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb 2019 08:49:51
 +0000
Date:   Thu, 7 Feb 2019 09:49:48 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Stephen Warren <swarren@nvidia.com>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: Re: linux-next: manual merge of the tegra tree with the imx-mxs tree
Message-ID: <20190207084946.GA8741@ulmo>
References: <20190207095142.5ccc4a8a@canb.auug.org.au>
MIME-Version: 1.0
In-Reply-To: <20190207095142.5ccc4a8a@canb.auug.org.au>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549529360; bh=BRVZcpngWdFVGP08flAl2aXvJdbGLO3Yqp8fFgqNaG8=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=qs5ZP2dMJeI4+EM/1+LcmRmXlky6ZYOPumbJBSw8wmCGqSFgi1UeBNOyB/zm64oLG
         FswTL8019EeQsR6Ce8DBXTcisXFlV6PzWBBIN9y/XiAD033cEfGMW/bPW7p3C0b9Zm
         AfOEwFjiGnQcsHYaBVJS4OP4EgPpTPTNv1/Q2Cb80y0hXzXBMAx1eIQLDNhUqqxg1v
         y88+PLOPj7Mqk5De9MVFzyhlAhrNbpCDypSo5uzl358xe8eYQU3VHalMC9MBhzvq1Z
         PNnM3gsEwQ/xrTND/WOx84zTHvzu2WrIUn1p4VK9boTJVHnEaxt0VLNna/dPSeOsTL
         5pkrzylDI6gFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 09:51:42AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the tegra tree got a conflict in:
>=20
>   arch/arm64/configs/defconfig
>=20
> between commit:
>=20
>   9bd01e74c715 ("arm64: defconfig: Add i.MX8MQ boot necessary configs")
>=20
> from the imx-mxs tree and commit:
>=20
>   bc72bed682a9 ("arm64: defconfig: Enable Tegra TCU")
>=20
> from the tegra tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/arm64/configs/defconfig
> index e82bc8cf1253,ad8f3dea0a74..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -323,8 -319,7 +323,9 @@@ CONFIG_SERIAL_MESON_CONSOLE=3D
>   CONFIG_SERIAL_SAMSUNG=3Dy
>   CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
>   CONFIG_SERIAL_TEGRA=3Dy
> + CONFIG_SERIAL_TEGRA_TCU=3Dy
>  +CONFIG_SERIAL_IMX=3Dy
>  +CONFIG_SERIAL_IMX_CONSOLE=3Dy
>   CONFIG_SERIAL_SH_SCI=3Dy
>   CONFIG_SERIAL_MSM=3Dy
>   CONFIG_SERIAL_MSM_CONSOLE=3Dy

Looks good to me.

Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxb8ScACgkQ3SOs138+
s6HRPg/+KwFzYrM5xwqCpacCYlcLCj3NEe9Prg6MfdrCGGN3txJRiGmgNE1RtJRY
MiJY9wLxhEAOD4qZq6OUaP3sL7blkdVegu8ilMlBfcAbk8iECdUk7ttpbcPheSdW
LxjqQ1fPYvIprZEA/hTOfhUAL3T8f6kWDfclVvKu4pQKnkq2XDGIdh1cEjZZwBcJ
Nae+x7Aw7Olr57UAO/XqlVkkSjHDNklOTkkaUvoQvxnNP4o/koUUQWq3vI21cuSl
pnijxr/Ee8efD2Kuu5XNxnO4snnuYjGGrmuXy2VI5Xwu1SfUeMBwbzjRvNhsxgHX
oz44YJlRAa7SNMk15814DL9AgGu4vNbTdOYtWNTKCYrEHL+ap9o/d9dNgHKAqhga
GS/NoN8Bk0xzQK/bnPCcT1DeuE+NGZp10NHnD1eqdDLxv09dsKsdQv5dXQ05OrMp
d1XKKRCtO/3RT1m9+JAjyeVBAodE4xh00sYDpGclYw+x4xISbeF5TOeHJRS6JuXK
CfFhRefxN1jYoJfgf94ZnqfBaRduJMaV2dduWD+cdNPr8EB7qrdSzUPQHZgLTiwN
OeQTNJsDPSrLghJOHkQQBfSBTPptiGnzR4h5jiXDS5UfMXj4MY62o6tfMvy/KOYm
Z8eqc91rTJhrK19v/OYibVenN87nRg0sN/4ZRaqSBPHUJXJRYZI=
=U5z5
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
