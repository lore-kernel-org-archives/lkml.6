Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbeE3Wkm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:40:42 -0400
Received: from ozlabs.org ([203.11.71.1]:49567 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753681AbeE3Wkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:40:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 08:40:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20180531084037.2f8b4c1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YcQ0cgYwznQVM=6GoGAqbNd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YcQ0cgYwznQVM=6GoGAqbNd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function '=
wlc_phy_workarounds_nphy_rev7':
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1: warni=
ng: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-=
than=3D]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function '=
wlc_phy_workarounds_nphy_rev3':
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1: warni=
ng: the frame size of 2872 bytes is larger than 2048 bytes [-Wframe-larger-=
than=3D]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function '=
wlc_phy_cal_txiqlo_nphy':
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1: warni=
ng: the frame size of 2432 bytes is larger than 2048 bytes [-Wframe-larger-=
than=3D]
 }
 ^

I have no idea what caused these warnings to appear ... nothing in those
functions looks too bad.

--=20
Cheers,
Stephen Rothwell

--Sig_/YcQ0cgYwznQVM=6GoGAqbNd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPKGUACgkQAVBC80lX
0Gy2dwf9HgIRhN09P6Vpty/a8LE9OoVMtkQLr2QzJ67t1oRtUyMO0+om6ektF/Vt
F50uGrp2TPjjx5b3zwfRC6xZoDslnkhWxkr+/DeyzmpH+/LI/yPY8zKXofXvekbV
i/ltx/VRcHMQXz4dRJO1yTlMAxlhSl4AVJcYi25lOozC1XFLbQHtGYBIHJpP9Bzx
1UgR6S4KPHctj8Rc3C7OjA9MUn93ebmKy2aKYhhmfPszPicDAK6jAM73ZIMoDoC3
zPJXSPh7DLSe8FmHHpwonn2YC6IzHLLunm5PkgHg5Si4QIPKiPL9x2t9yX485reY
O3GASh2D1cXLvN1W4BVYCaIWgm4zLg==
=PQzO
-----END PGP SIGNATURE-----

--Sig_/YcQ0cgYwznQVM=6GoGAqbNd--
