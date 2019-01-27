Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC227C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B351D217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Yj+uyimP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfA0Dg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 22:36:28 -0500
Received: from ozlabs.org ([203.11.71.1]:58955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfA0Dg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 22:36:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43nJMX4Wrxz9sDL;
        Sun, 27 Jan 2019 14:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548560185;
        bh=7Z1Oseks5tKyczUcJ9rSMa/fi8BcaP1k7aDIO4qd2Oo=;
        h=Date:From:To:Cc:Subject:From;
        b=Yj+uyimPJVrZ6FjRPNYn+fALL8X4O55xRI0IFPR21HBJ4oldGZL8CmxHpB6cxsdkY
         P6JM3DK/C3NXP6iBDYm9rm6dcGUdmQHyai87muzSrLmHST9RLE1a9K1np9zUlorUAR
         LKMuR3GW2ueeaLZUoF9DivE3uHv73K9Y5u71gwyItAI2xRSlPTHqy2YeKZuBObM037
         b4Cd9LfguywtXr2jE/VD2iaZDmuQlplQkVb4F21g4ulximPNWNsTrbjIJ/z/S/bQQB
         hO3YJc6LB9/Y1T55j5Ur+zeQVDVIrwGjldnFYrXZwUDCGMqkWnm9E57gXDVSDdTZAJ
         yanwXOvFIk+Ew==
Date:   Sun, 27 Jan 2019 14:36:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Denys Dmytriyenko <denys@ti.com>,
        Fathi Boudra <fathi.boudra@linaro.org>
Subject: linux-next: Signed-off-by missing for commit in the kselftest-fixes
 tree
Message-ID: <20190127143616.2e27781a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/53CpuM2heI4WEJ3DqmFcwP/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/53CpuM2heI4WEJ3DqmFcwP/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

Commit

  5d09ac9241a3 ("selftests: lib: allow to override CC in the top-level Make=
file")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/53CpuM2heI4WEJ3DqmFcwP/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxNJzAACgkQAVBC80lX
0GwLWQf/aykSjabpvW3CJKVAE+l0vulRlu91SfWlOUTvTQ+jTYnHhWwhZKyIfcOk
C7pN9C7vyzqWzL5W4ccptYFvU/8sHeZJrUGUzeL5mGZLAnrGReNbUpDSieiyy+ky
Y38JGfVhxqk3vLVy4pjUTfUjBJezGZ1lbBSsHW2cpmAHcC5k9G41CnRldohOpY7B
GG/eMIeLcdlUuYZRjoN5GuHZK7yylWmnAodhHe+Ns9g/mMsv2P2CLdq457FPankM
OeeX+eiVKwmmK5aH+mtVqGd5Tcck8KdKT0cjDKV9MhAHJx0oYDYOQEQpmUz5sgHB
WdHmY/RG7FVDGpocESFIS95DFUfVQg==
=WRnY
-----END PGP SIGNATURE-----

--Sig_/53CpuM2heI4WEJ3DqmFcwP/--
