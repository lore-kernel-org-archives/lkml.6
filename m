Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A530C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E1D21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AY3KBdg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E1D21A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbeHFXu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:50:27 -0400
Received: from ozlabs.org ([203.11.71.1]:50689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeHFXu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:50:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41krdS38s8z9ryt;
        Tue,  7 Aug 2018 07:39:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533591564;
        bh=euiFTVXFHe5c8tU1c8yR79EAG+qGSGISDJUnsDQP0+M=;
        h=Date:From:To:Cc:Subject:From;
        b=AY3KBdg8+RVYnuY20TJFupWCBW54llw4ED6QuRpx5l/6GX6an24xviQ6mROsvkOu7
         mdGfrG3gWOoaoJ0MuFPVqv5x6qQtg1soSAdKfb7yZc8A6xpTWvtuAN7hfY4XddF87B
         k9qStLhz1YsqUxfPyL6bHO6A6L5yskGkWthCfjdX38vITEIhs0zrUUSI9VAhf13xE/
         y0UC0/EIqbXAKrelX/Ze4LinSfeF+qtG2a2dAnvpPInhTyefpeJKrdDJeabKl4//yr
         2DJrPFj3AWUF9XFe8lB+07PE7Z51EhegrGCQJiH+0KqorNa6gD/XTQHnFt2phAxynt
         M4Z+GMBCfS9xA==
Date:   Tue, 7 Aug 2018 07:39:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvm tree
Message-ID: <20180807073922.665e1d63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Fu_SOGjO3Eh1=cHJi0/AMIS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fu_SOGjO3Eh1=cHJi0/AMIS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  81781b6884bd ("KVM/x86: Use CC_SET()/CC_OUT in arch/x86/kvm/vmx.c")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Fu_SOGjO3Eh1=cHJi0/AMIS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltowAoACgkQAVBC80lX
0GwBPgf/a0nOKk+yWTIVR5F61U6gBcqKR7e4LYBxnxcrjMJIStc+PCrZUMPSkAOR
w7fBIZI6CTZWoR7YrAxF6GUvVzjAZsPwf9OFp50zmkFAjUVoUB3n+7TlEerbfBUC
ztbvcfEPGevv1I4d0aFPDZFSlAgwR/Ti0Px8Pc6WWXxUiAf04VDCIFo1zw3Wz+l5
EbJSKJHU/KsWUGIsAL18H0Jtwu39rgC7DKBq7h3JcrfhyoOtWuE5aCi8FCqt7X3L
dDhXMQEn/XTDbbAigNXII/aqc4r+sRwDzK2cWfOuKpoq+ABEH7ewHNcbzkVqgg+O
TY+nZqktS16wTs5zg+jxtzAPM1xlDg==
=7vws
-----END PGP SIGNATURE-----

--Sig_/Fu_SOGjO3Eh1=cHJi0/AMIS--
