Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbeCLBPV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 21:15:21 -0400
Received: from ozlabs.org ([103.22.144.67]:46707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932417AbeCLBPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 21:15:20 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 12 Mar 2018 12:14:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the clk tree
Message-ID: <20180312121445.6319623a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wIJ/jNckJAPIgX5A3MZWPfD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wIJ/jNckJAPIgX5A3MZWPfD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

there is a string of commits

  3830681d354f ("dt-bindings: Document STM32MP1 Reset Clock Controller (RCC=
) bindings")
to
  b91dacd1b912 ("clk: stm32mp1: add Debug clocks")
and
  b96385a1947c ("clk: migrate the count of orphaned clocks at init")

that are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/wIJ/jNckJAPIgX5A3MZWPfD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlql1IUACgkQAVBC80lX
0Gzk6Af/Y9kWAV6ezYVpHrBNV3Yxws23LRCsdI2kA4ptDGh1EJg3mle6RJ2M1Lok
vx6WZeuvyk7g3Oq/YiljrME9DdTQwWfUV0ruxz5/3SB91DV3rJW5TQrKqrca5nQ/
PqbXr64m9a8LuJk6kpMnNxn6vvSeFodBmbE+q7PKgeTDamaBfskKUCrXOaHbwAzA
xN4XQfjIIGlpkWvrBMPlV4YGF3uhyXrvDLhaj0J29tI6igoYTGdJwZ25ZQt+xIxp
5e1ISyBaidd1P8u5U3JtoC1siyqMi116I4y+7rJE6eOzTA5/8MQUojL3SHB7516f
XLs0zWX+1eKQi78KHP23VuhgXjqF/Q==
=TSvl
-----END PGP SIGNATURE-----

--Sig_/wIJ/jNckJAPIgX5A3MZWPfD--
