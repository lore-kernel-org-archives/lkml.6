Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DB8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8F520825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FuVHwztr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8F520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeKFIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:31:14 -0500
Received: from ozlabs.org ([203.11.71.1]:60791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeKFIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:31:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ppJz23Fxz9sDT;
        Tue,  6 Nov 2018 10:09:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541459347;
        bh=GUde6oy4tmXv9oEx6/XOE9t0yoVfmW2XqCxpStFRlEg=;
        h=Date:From:To:Cc:Subject:From;
        b=FuVHwztr7AJ9tHpFcjjNLQCH2ykaP/LLOyZRTEItfooOMN0b87Su9oo5nYD5EjAH7
         fa9cMlfREduK+KfbATaLlp60Cm4FVYeFMW7Wo+bGuG4LN/PwM/+oWzyy7zk+2kggRF
         b/jI8E/SQSR2lvscjtbicIX1zvujWdpV/KIVfARbdfpvzY6RTvkMLH7fifdre/rIXs
         rC1bEQGHpHkfQknwu6EmzdVqqfm1WhmqtYdIs4GCiqL6oYyU3mGJzxU853EcmgtKQJ
         TYWb3jW0YeNGwayw+dSnkQdt+cMdXVOTTjiTA0jUu6DqW7Zl54I2UGEVgkiQtj3Ubz
         e4aq6aaGBtA9w==
Date:   Tue, 6 Nov 2018 10:08:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the xtensa tree
Message-ID: <20181106100856.0c9bdf3a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8ip2TZ7k0p9UtH711kLDPvP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8ip2TZ7k0p9UtH711kLDPvP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Max,

Commit

  12e90ddd8dbf ("Revert "xtensa: xtfpga: implement platform DMA address hel=
pers"")

is missing a Signed-off-by from its author and committer.

Reverts are commits too.

--=20
Cheers,
Stephen Rothwell

--Sig_/8ip2TZ7k0p9UtH711kLDPvP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvgzYgACgkQAVBC80lX
0GwH/Af8DQfoy1kPx9obxVKiyfCXo5OmtnKOf6v0Xt1c+Tyn6JlkqOTgsqRbChoK
Z0IE1jMYBkVVA7U5jVRoP0ajGorVAA3g95p6c4YLQ4tk7eoh+vjpMIyDxsJv20Ck
uLWd/2uGv8Cl9vBOjAw/w591V5qGtCFf+xcDvwgi/65ZQyDnq8lxxeDFqWuTxopZ
agnesdK5k4/Rs1Cywfua1SdcIybdCSCVvE4oDaDI26xsDNk4JXz9tfySfOa1OSdy
7CyY52XOC2Zgat1czmwwLvZjdWTD3JF6bHpBxSygEHKvFLEwZkuRk/24+IVlWIRt
MwSBAy95Fzq9Zj1u/ZSfiBZxabmoOA==
=y9iF
-----END PGP SIGNATURE-----

--Sig_/8ip2TZ7k0p9UtH711kLDPvP--
