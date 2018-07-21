Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F55ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A265220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ono7zU2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A265220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeGUP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:29:08 -0400
Received: from ozlabs.org ([203.11.71.1]:39195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbeGUP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:29:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Xr0T1YX5z9s3Z;
        Sun, 22 Jul 2018 00:36:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532183769;
        bh=VE9AM4H+RJrG1H3EukSHC8aI/EwWv65Jcs5ytXR8z2A=;
        h=Date:From:To:Cc:Subject:From;
        b=Ono7zU2tCPG8Ys0Fwryl+7ZrdwBIPNF3vaxySKdeEz95Si/pKXZPou6QrEt1VIC9z
         5A20OQH6IKrX1En87yofFeu3hFzl5PXrpUVM0uy1l0zf+NZPp1RG0CWqgXCmaU26tU
         vpozREye7ElSU/2Pd+XSCTL3J7fOCQvS02lQP8axMqds6Jq5T56qS3WI8rl5b/iZFW
         go66GWmXaEfQN5RR4BoxgSS2qpeUTt6gfgThjFR2gHcdx0eBe8IxMr4P9FqoMe8HL0
         ADc0ed8sUaY3ovLMjx4pW6Pkodddx7n1qrthq/w/lDxB/RH9xiUGVYfG/q7Ijd/F55
         Rs3zweGzRprBg==
Date:   Sun, 22 Jul 2018 00:36:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: linux-next: Signed-off-by missing for commits in the nvdimm tree
Message-ID: <20180722003608.42e7164c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P7laA/=dEy8kSLVBB7aKFCl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P7laA/=dEy8kSLVBB7aKFCl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Commits

  212a28b4dae9 ("MAINTAINERS: Add Jan Kara for filesystem DAX")
  30153e5ba54d ("MAINTAINERS: update Ross Zwisler's email address")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/P7laA/=dEy8kSLVBB7aKFCl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltTRNgACgkQAVBC80lX
0Gx9xggAhbFgqqc2HomRlurYRwAfWYT0GlAlvJhQW5V3Rx1SekQX+10jafEROEkp
ATAnZvmsM4iKJADzIU/cZVH5q9mvN4Z+9W9tdvusbgmjkYfWqugqHMSka8mlaeym
iYqDTp8/chbj43AtW16+evovTNTSdWFh9WYCQ/DXWzaHiwCXZl6oyn7lGMrtRqnh
/KSa1FKjntzX3d9eRo2IV74mpfukf+4iXrOen9QhopZhsDWArF22WQuttscL6Nzt
x9UWoSB4mg+3X8f3BM72wqLuiWc+Ml2zuOErlKttHhpEQJZSyF5XOwQHsTfu4vZ6
3pemLimAE5lXOsEu7xb6VSYD7x988g==
=xyxh
-----END PGP SIGNATURE-----

--Sig_/P7laA/=dEy8kSLVBB7aKFCl--
