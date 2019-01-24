Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA25C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14FD217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fkskZFuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfAXUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:15:07 -0500
Received: from ozlabs.org ([203.11.71.1]:36311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfAXUPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:15:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ltg85WJZz9sBQ;
        Fri, 25 Jan 2019 07:15:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548360901;
        bh=J2lN96oZepae/H7hjVD1wvlW0aKIbS0vefN1ybHZZcc=;
        h=Date:From:To:Cc:Subject:From;
        b=fkskZFuYHUeV2eQMcHtNqlkSN0oCof2+cx7eTHk0dsByVHwz4s9nTeTKTg65yDXVD
         twlYqgGSeHNe0fr+iGDvFKSpG/pNK4chzpEJpPfLfrIARkwhgrqXLpdzI+kh4WLSZ+
         1INaxc4Jo1Bv9+mXLl77ythi5bJOIaiN1jwWvP0Dm6EKS6fmVb16xSp1M5pPFiYTsi
         BNedPp6GhbRgCKNkyNZMhDcFfF4RYMHYcDtmTqQeiKatJshYLp9/4kt5XmjPMnY7tK
         ADS8g//r6DqscRtZUOtVWLq6mgkDztyKaFC2MkPSmVWuek6JgbXrq7MGVfVr4ogV8B
         OUu149TYgPPQw==
Date:   Fri, 25 Jan 2019 07:14:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the kvm-arm tree
Message-ID: <20190125071450.5107222b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SJ=ngjBB2bSqh5H2YMogom/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SJ=ngjBB2bSqh5H2YMogom/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  188922da4992 ("KVM: arm64: Reuse sys_reg() macro when searching the trap =
table")
  ef40b3d5528e ("arm/arm64: KVM: Statically configure the host's view of MP=
IDR")
  31fc83bdbaba ("ARM: KVM: Teach some form of type-safety to kvm_call_hyp")
  74bdc394c5a3 ("arm64: KVM: Drop VHE-specific HYP call stub")
  051a0ebd09ce ("arm64: KVM: Allow for direct call of HYP functions when us=
ing VHE")
  1fbfa15343a0 ("arm/arm64: KVM: Introduce kvm_call_hyp_ret()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SJ=ngjBB2bSqh5H2YMogom/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxKHLoACgkQAVBC80lX
0Gxh+Af+KNurm3MNFwX0BwGPBGpgy5hL28aSqRJ13CpBQBwAxR/qOvkT2hHuJllC
8zLDQOXIzVw0V5QzKz5Lm80pr+R0H8RyOlJd+ebOD9CXkIT0jnTFEBq1JA05w8ZX
d+38UqDLoZQ0IGCJ/PJ3zdm08lrdA6VnCgqNCDuwfgPOsqXcxYJ2ZdbJeGqRNk4Z
zqdp4MBWKByUrOpNGCSNmDOBRhdDFAb2967L2e7KiUw3hWdcAu6UxDmREM61oA3k
w+wCUA78b15eZysMH2jMNX8RdKNopszi5f3SbQ30onbdG3iVCD55DdWqPetGnK+U
U0Qe5e8Xnm01jOTscs22EoPToNsEgg==
=O3DQ
-----END PGP SIGNATURE-----

--Sig_/SJ=ngjBB2bSqh5H2YMogom/--
