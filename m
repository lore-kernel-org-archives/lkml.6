Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCDDECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FD020858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D+i6SiUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FD020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeGUPY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:24:58 -0400
Received: from ozlabs.org ([203.11.71.1]:60659 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbeGUPY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:24:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Xqvg2xDkz9s3Z;
        Sun, 22 Jul 2018 00:31:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532183519;
        bh=RZVx4HsPlPudGIn7iKpsFVWr5FUrURGH7Qm9T4y78Xg=;
        h=Date:From:To:Cc:Subject:From;
        b=D+i6SiUtDsfqBObKhyLVtolh5gETVVq2tjRe9oiKA2qlWz8WOctGljA8JEQeonXJ7
         VsIT5UxH9KjiqkJ23ezSGBONQ0WLEv+wdP5V1c6NXjHyyUVc0OYt/MJrhprz9P9Cdt
         aEmQC/49/JkN0OTqchhF5NuSZ/jqyIsOdlSaAVvmtNSICjKO0aLnDyghvcP9nB7cHW
         T1IxA94T9oTh/GMfRrLJUKm9jlv9v3Wtyvah/lLaop6eCpm8LArAqAZLua02wEghFY
         IPsBoH4ptilaVqets4xxTCIk7SsGZwH+gRTT9CvIAiqtwn62j3byLO7X2+xEK8vuvl
         r9gFO1kpZWTIA==
Date:   Sun, 22 Jul 2018 00:31:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvm-arm tree
Message-ID: <20180722003152.447551b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/scD4b7qOvmr6IvQ5.kZKCoc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/scD4b7qOvmr6IvQ5.kZKCoc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9904b113fb90 ("KVM: arm/arm64: Fix vgic init race")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/scD4b7qOvmr6IvQ5.kZKCoc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltTQ9gACgkQAVBC80lX
0GzUKAf/eFdODQRQdrarUEL6U+uT2egXI0SIuZ4Ghpg2kRD+flXiSf6NewwfOW1q
NM3crZw52rjlHEMr421MyiDtdelV0XH0Rl91/2odmsJVumOVzAf6pa2ylE76zvCP
oImulSk2TFBHh/jgehFxVH8Xy6Avw56aZVOKDu2lrUk23PmI4blGGxQTqfeAjPtv
1DLcKkn2xdagX3LHreYUpBbCAnrGDPx0dG0z2yRtgixLW+IgxO8CNYEZm//AxdZJ
IeBy2/UgrKLoLfc/Emipueq3reCHP1h4euXSpXX+K3XcpILEdKMVHSiMNHJ6FTZd
kbHhBQxCZNdyhOCcxG8Z3F2qCMDTQA==
=MCTF
-----END PGP SIGNATURE-----

--Sig_/scD4b7qOvmr6IvQ5.kZKCoc--
