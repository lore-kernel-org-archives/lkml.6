Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeENV0J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:26:09 -0400
Received: from ozlabs.org ([203.11.71.1]:59799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeENV0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:26:07 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 07:26:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Gross <agross@codeaurora.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yossi Mansharoff <yossim@codeaurora.org>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: linux-next: Signed-off-by missing for commit in the qcom tree
Message-ID: <20180515072602.0cbf1a07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YpBrBLM7Jb=unWP66fbhLW3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YpBrBLM7Jb=unWP66fbhLW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Commit

  f1f74f1c01ec ("arm64: dts: qcom: Collapse usb support into one node")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/YpBrBLM7Jb=unWP66fbhLW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5/uoACgkQAVBC80lX
0GwH0Af+NZPZCBt4LnHHw5Q+XqLfFS9ko6ev+HxcyQtdoBZVVelMOyGax7+orxux
hntsVm9sEBsj2aBQetNZs3LL10CD9TVeSWtFFqslns/zmi11uGmOTny8SrX4zycW
0QbVjhBSYy5u1NYN4myLpHNMNvZdk3qt/GyfA8XDDH2YhOR3YPkgC56cTAe/hcfz
P3jy7r556B6UNOiOGxA+gVcRhAxj24hiI5ZY5OWsJBU6gzAIFRsGy+9CfvzNAROu
8axEUU3IsbVRxC5KekW+hAzGxW4r7y6YMLwkFgTcxf0GWPh4Qim2eQyl1nGD5PMt
k4RK+oOPB+fyQQmQBzbibP7F9+0X0g==
=DmXR
-----END PGP SIGNATURE-----

--Sig_/YpBrBLM7Jb=unWP66fbhLW3--
