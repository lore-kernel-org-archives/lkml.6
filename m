Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeDOK3C (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 06:29:02 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:7728 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeDOK3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 06:29:00 -0400
Date: Sun, 15 Apr 2018 12:28:51 +0200
From: Alban <albeu@free.fr>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Aban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: Add a driver for the ATH79 USB phy
Message-ID: <20180415122851.1c168d73@tock>
In-Reply-To: <1521931120-31118-1-git-send-email-albeu@free.fr>
References: <1521931120-31118-1-git-send-email-albeu@free.fr>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Cyqi4uvnLRhpCUMWi3OlXdM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cyqi4uvnLRhpCUMWi3OlXdM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Mar 2018 23:38:40 +0100
Alban Bedel <albeu@free.fr> wrote:

> The ATH79 USB phy is very simple, it only have a reset. On some SoC a
> second reset is used to force the phy in suspend mode regardless of the
> USB controller status.
>=20
> This driver is added to the qualcom directory as atheros is now part
> of qualcom and newer SoC of this familly are marketed under the
> qualcom name.

Does this patch need any improvement or will it be applied?

Alban

--Sig_/Cyqi4uvnLRhpCUMWi3OlXdM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa0ylkAAoJEHSUmkuduC28qJYQAKC8vQJLU/W2PMCQUZm2sv9D
7R1iyR6ee6ulRddDwjclinCMiaXM4cItOXQ9d1EoEIaYpQLrgzBIQDhlHEmfNtEX
rmLKVrNG5PsJjjOjBlAQpUtMZaBX6TCw981oFEB1EER8LnFnyeRHHNye84oFljq+
zWq937YmlHoYJKECD6j9Skwjv9/CpY1EtV2lI4PXrEQTkk1wStJ7K/Cc3lTNgHfQ
571hn5Gdb1tzhT/VPhTN8N02jO/DH5jrQCwqAr7sw3lM5HqNnTBBxGoSoktMJeQI
LkgGemov0rpTwtyjtiOtd72+hLQCVtm0GLQ28iXQxZFSqAWVi1o0ad3pC5VGNyVg
EBBLfH39oJhODIqsEwPj1bNV5EEb9AC9paVUnZpVkK2urlAS82SmfvDW1ADwyFo8
85TTIPlht07h1zeM0eUiSnRKBgTCB1Lqgsh90i9qtKG/IoSr5KFGebkoDQpmK1Ak
dVhJVL6pjxzDGfVD6p6CuA65yC+3H/9Ibw5g5Oz82YsxwE1mX16A1/nNKIpAKL8y
Xxu/0lRbmDJByPNsV6A4LW4lQy0wfEYCmETPOPN57DF0Ob3Gy2TVnwWVRVer/gjG
C8ALlEWfEPXQfB7iXxlRrMppGe29DcOrGVOLiZRMkP3dkIvQ6xSAiitkfgnMaOdO
Ux6PhT5S9TayCBcBCuDf
=0wLi
-----END PGP SIGNATURE-----

--Sig_/Cyqi4uvnLRhpCUMWi3OlXdM--
