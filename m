Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFEC27855
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vIANIUn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFEC27855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeF1TMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:12:21 -0400
Received: from ozlabs.org ([203.11.71.1]:37737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeF1TMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:12:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GqCg6Gyrz9ry1;
        Fri, 29 Jun 2018 05:12:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530213136;
        bh=cCXDW4Tbn1M+2do8hFNjTzCyftVcjIymH8ie3x/lHfI=;
        h=Date:From:To:Cc:Subject:From;
        b=vIANIUn403XyorlkbT0tFgqXpxacnnkPd8XPLIhuNmXgPP/8f6W8a8x8uyMDHulO3
         zq8/GfMeozuEk/vEUJvn8OfU0o+FGzPkmqJTRianodupKxAHgc1zua4HAuinzc+y0D
         UVDN5xObaRvTBRtUESHog5YUFtCC/wDMl3BgBU2kPGLAAJ/TZOAtTMGxDOCP8IN3Vf
         /+AW5TxTUSSXIbQGlZdeJn7uLuFSfW7Omoz0ET8Ggf01DdO5WQbhnKyJEorhBErn8I
         UW+qhr2LDMA/+FWED/AccZBUri3lOPtz59hU8DDhnXpjTLo/Zr39emYsVv6yKV8piy
         rOvodRDPT9V7Q==
Date:   Fri, 29 Jun 2018 05:12:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Signed-off-by missing for commits in the net tree
Message-ID: <20180629051209.0189ce01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sb4XTE35jmrg6xXOuhBtGyK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sb4XTE35jmrg6xXOuhBtGyK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  933e671f8cff ("selftests/net: Fix permissions for fib_tests.sh")

is missing a Signed-off-by from its author.

Commit

  a8d70a054a71 ("net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not =
being esw manager")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/sb4XTE35jmrg6xXOuhBtGyK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1MwkACgkQAVBC80lX
0GzEkAf+KcwkMepgsf2oTSXV4MU/fQdomj3i7PBszu4QdBCw4F74aXeJ/MfI6gEs
s7uCDfqkMPT/eXnQHDRPrTOkRD40Nllfb//MWzIT1pfLvvP9ULlBVN/2LBbeiMNM
704cNVSKPztyJnGr6X8seNVFnBdchfGQ3SHUcKXGBmh9JOMsUh/Nk9bbTq7Jhvtf
IoNdGyUMCgYXgh3oWNbhC5wqCc9G04Szj36sDaJNdERy+M5xYxIzMcuIkwh3d2UQ
jjvcJpBsYXc+ESheO+2CHz4RqTf7eJ6VIpVkWVti915o93DjLxiYyDE7PtK6ymLZ
I/HBwF1yIC1nLYuUm48E2dj9tAji9w==
=uNqj
-----END PGP SIGNATURE-----

--Sig_/sb4XTE35jmrg6xXOuhBtGyK--
