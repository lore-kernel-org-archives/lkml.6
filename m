Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DDD2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ug/6tPyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfB0VB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:01:57 -0500
Received: from ozlabs.org ([203.11.71.1]:35829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfB0VB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:01:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 448p5Y6xmCz9sDb;
        Thu, 28 Feb 2019 08:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551301314;
        bh=5QVWhWx5PxMAY0S3K6R+zW6kCyadyO6uvpzSPNYZfAg=;
        h=Date:From:To:Cc:Subject:From;
        b=Ug/6tPyrCJdOq3q5jj+o0ldpvjJ7Q8emdaqyUXiCk7Vv5ztr7J/VjH9li+w9s8ybS
         tH1CzaTGHAyg7RoI15ZyP0cdaiguxda49seDFUFDKsrvyjOSJW8vagpTXqbIOGZYVW
         vnzQ5Vah+e9Ut/4EHQoBgpE/gYIBowLqZzBCRR+jPELWKur297AcYPiy4xlExtKnBF
         cPpfFybOXYYfJwE96eb3WoaWJ0N3QvqVgfYQm5K0la0BuUFrbLZ7U5y4BFnTnSE9W3
         MYWnFb26voaZr33lEEGdr6wrLpHOAWs+J61xq24m4MNIsl94kpB0n5OXyOFU5t6KEt
         rW7stAO8PG6og==
Date:   Thu, 28 Feb 2019 08:01:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20190228080147.20df150f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZkBFemCWfKw2zLvRzJ93lP1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZkBFemCWfKw2zLvRzJ93lP1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commit

  a048671aa0c8 ("PCI: qcom: Don't deassert reset GPIO during probe")

is missing a Signed-off-by from its committer.


-=20
Cheers,
Stephen Rothwell

--Sig_/ZkBFemCWfKw2zLvRzJ93lP1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx2+rsACgkQAVBC80lX
0GxSvAf9FIFR60LO91Ch5Uf/pK99io3w7dhQh7oi6xj3hBaFcez/fpnxCDf05bIp
R7cGYx5JZIu8Qn1VeRSr6RYq1izVWvudOQid3HzTDpaWbUFC3XJ0bLBjdDBTiLEO
J045gjA4A4Tp6G+DJgrqBrsA0VDJtEbnJ3N/57Nx9l4bvNiGDmnksu2D4WTK+C+S
wn+AaZmLPm4koXcaiS/t361lVbE5cKwRkf/sKY4o8KUDtDD2QT4cTRUPSzak6DAb
7CvWxfhH3c37ZVHDWGfvjC8s7e4Ro3kFfL6MUjgIUz5PtoxLewvj4O4drr0qFYfY
0arjtNj6UI+iKZT8sdzFpYLN+jIuJA==
=eobH
-----END PGP SIGNATURE-----

--Sig_/ZkBFemCWfKw2zLvRzJ93lP1--
