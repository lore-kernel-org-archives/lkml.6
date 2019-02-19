Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45453C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B22721479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WYf8DoPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfBSUiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:38:16 -0500
Received: from ozlabs.org ([203.11.71.1]:48869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfBSUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:38:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443sxw6MS9z9s21;
        Wed, 20 Feb 2019 07:38:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550608693;
        bh=TfKmog2tlEgzfKE3NMmvV670sHD3SSIZpPwXmH9/CDA=;
        h=Date:From:To:Cc:Subject:From;
        b=WYf8DoPJrCATtoNE3GRdBpeuow8emsMD7hKvWklr2rq65lGp8PuI5QtucRPL5Sju4
         BV/TH3bGS3M+hRafV8WdIabByJySIHQXA2AXA5MEEmAb8G1sHG6Cf6+6kGn/MKapIo
         7AF582cqM8eqCMbwVkfXt+6M8luDPM/iRXwdmTIazmYQ7IEplq07ovINCnxNZp4ObG
         Y6yLkT9DxzeBqfW6SphTtqB2nVYvFNfpqzOm4AGzUjxakNmL05aQPgOKnDer1Bgf+N
         d6fUpo8Y3anvKG0dCCjYa65pV0ixtDGskHKk6vGtcVezwnKSe6RRV5UvpMah+wwv13
         lN7HqPzyZgSEg==
Date:   Wed, 20 Feb 2019 07:38:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvm-arm tree
Message-ID: <20190220073801.3cb6082a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k78+FvmXYI+NSxj2YGr6R6H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k78+FvmXYI+NSxj2YGr6R6H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  32296b9048b7 ("KVM: arm64: Fix comment for KVM_PHYS_SHIFT")
  bfc871bad87c ("KVM: arm/arm64: fix spelling mistake: "auxilary" -> "auxil=
iary"")
  1c1c37e5600b ("KVM: arm/arm64: Update MAINTAINERS entries")
  b1206bfb39d6 ("KVM: arm/arm64: Prefix header search paths with $(srctree)=
/")
  507f5a8474ef ("KVM: arm/arm64: Remove -I. header search paths")
  af8c5901d5e3 ("KVM: arm/arm64: Fix TRACE_INCLUDE_PATH")
  d116a11d3ccc ("KVM: arm/arm64: arch_timer: Mark physical interrupt active=
 when a virtual interrupt is pending")
  17925ec8a87d ("arm64: KVM: Describe data or unified caches as having 1 se=
t and 1 way")
  eabb8caadca8 ("arm64: KVM: Expose sanitised cache type register to guest")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/k78+FvmXYI+NSxj2YGr6R6H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsaS0ACgkQAVBC80lX
0GzQjAf+NWA40y/iJlRA9RE6gK3SVcBtezJaNKWR+9d7eO9HkFNgbl441OfGMAcQ
9KLDI5dXwYA5/J3LeqrJJQokQ5f3tthkVsb2WeOJT8DglIn+QNLR7xRd2bgZBtg8
idXnIHkz7ZFZIllh/y7wGfq9mPHBN6QO9A0Sg/BINaCi2lxRczi/VNJrF3Uh/nDq
p8E2hzI/TfvTEHf7gAmyD9BKjcEkAErwUP83cijfZl6jjEt69DOk+e009EnUgd4M
U0FnIzxTdIjbSjk2lUYd+u53b23M3TxC1Z2rlpO5zwVXtcwJPnjzsNciSrqqxv+N
8Bm9dgCaPeP4fuJBG2QUM39IQdcFQA==
=K9ro
-----END PGP SIGNATURE-----

--Sig_/k78+FvmXYI+NSxj2YGr6R6H--
