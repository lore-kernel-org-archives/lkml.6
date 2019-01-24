Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0EC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q2eiI4eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAXGhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:37:21 -0500
Received: from ozlabs.org ([203.11.71.1]:38071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbfAXGhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:37:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lXWg1GWlz9s4s;
        Thu, 24 Jan 2019 17:37:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548311839;
        bh=F2NTnkcDn3CalDhTUT/LrJUHLwRMmAhFHbcsR1pVQzk=;
        h=Date:From:To:Cc:Subject:From;
        b=Q2eiI4eqJ5cdo/QgSc/a+tzD9FtewdoAi3MDFZMGxFjUvDWoopVmO27LtXK1N79tw
         ZpkXInYU30syoKyeqk58H2/CzaiAyfTewGXHaSOHFLi6MykD9FSJleKNJiQrQX5yl4
         cfQtmtQsdhAoQ4avF3Ko7z8iVywY3Hi6gNdbxMlD9yj0owO5et+jT1oG0qgaCvrgNd
         36wCHZ5SDNNt8VWy+2vjoQANJDgbEw/eRZ5M+kGWGLwoopPW5UqrOTv9k1B0k48C++
         4vPC0sOskAmBgNLW1SBYvDQqzE53IVrSDK1c9JwjY/BjJZxFx531M5OxkBnpSUo5gs
         Et8cJCEimLXvQ==
Date:   Thu, 24 Jan 2019 17:37:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the fscrypt tree
Message-ID: <20190124173718.4549bf2a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PqJ3JW9C9TX3.J89xb.cTXV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PqJ3JW9C9TX3.J89xb.cTXV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ted,

Commits

  f5e55e777cc9 ("fscrypt: return -EXDEV for incompatible rename or link int=
o encrypted dir")
  643fa9612bf1 ("fscrypt: remove filesystem specific build config option")
  62230e0d702f ("f2fs: use IS_ENCRYPTED() to check encryption status")
  592ddec7578a ("ext4: use IS_ENCRYPTED() to check encryption status")
  1058ef0dcb71 ("fscrypt: remove CRYPTO_CTR dependency")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/PqJ3JW9C9TX3.J89xb.cTXV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJXR4ACgkQAVBC80lX
0GxrYAgAkcbm3Eb/XEyJB8m67F+dzJdl4MzHPTOWnr22BNSy7UFRG3ZmqHv6YTM9
hwPg3SdTwGb1J1UmngAr817xk5z0lbHhcnZLywjmVACI+aS4BoMCrBs5p6gc687Q
JiVV2wfTjF1tI4jmsAsdxn1tZu+D59Uq0hcdCXnj7yBmCf22Y1uZPCIfcFkxXLix
KbYT1zEHEdXsGjCEn/zqgtGq2Nufxoik2DsfJ5Lj/3Af7AV+4x2GziSoH46/ht/H
S68jJv9eToU5n19bIEk7VeI8cun391kZdw7Ab2b2pPn2MuT6eSknh4nMTEDK7Nul
j9LukzJV2eFienPV80XJznLz7s/hKA==
=Cfpm
-----END PGP SIGNATURE-----

--Sig_/PqJ3JW9C9TX3.J89xb.cTXV--
