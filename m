Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8444223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AnlmPcDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8444223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeKLVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:35:35 -0500
Received: from ozlabs.org ([203.11.71.1]:36429 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbeKLVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:35:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42tplg2Yjmz9s1x;
        Mon, 12 Nov 2018 22:42:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542022959;
        bh=7fxHbowTAxMsO4yQRyoc602rv8W7ShHLdyBJcSWFW7o=;
        h=Date:From:To:Cc:Subject:From;
        b=AnlmPcDXBfbiJoRzUJ9YE1nQGfsa+RV8TvoHnUzsuSvSdWLHglShOHV4Aa7aTWjc1
         GnjOi25l9JQNODgLD3lKzkwdIEf/mxWjI4r/uM/2ssJYZfo/wCHYpyqwVPYE7YcV9q
         J1w2CySPJ3dC5bllSnItEQSit3LwU5gpTqgjW5l5o124YRAbQ4tpNeG7dM/k3Mt/t5
         Jtce+w+5j77ThuRpd+s85p/A1lE77cu5NH6dBfPHpdMOD8sXJRXzoD4YeuLyxfOPKm
         UQ1j/m9QUIii0g3fpfvDOrpiwLaaZf3bFTHmh33YxqglBHJ5Re8Vhfd4hYBoy5d1Zd
         vJA6drn+4wL1g==
Date:   Mon, 12 Nov 2018 22:42:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nios2 tree
Message-ID: <20181112224232.1da23521@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IkrFuo+obyu/jLPlPTRvP+7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IkrFuo+obyu/jLPlPTRvP+7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ley,

Commit

  a070f18a62df ("nios2: TLBMISC writes do not require PID bits to be set")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/IkrFuo+obyu/jLPlPTRvP+7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvpZygACgkQAVBC80lX
0Gy8uAf7BIMmvmdz6+2iB7WA44FJFKpd74yUcYV3NiLIJQO9hFRNQJxBDSXRQbMH
3tTAU4Xd/duPLvRsG29hqMBDAivLNIuCj6oCpOyNh+TZEr2UNbZMnl0iV/yM9vxi
m+k7J2oIFDW/6ZVgKQ4y3qIeu8hvRDhrTvZFjjNp81IJPat3qdUY58+mQ65SW89K
LsKmeAyptFfFnkit65hPr2oK0svn90qadQ5/CDtls3o9PyJQT0WATrKm9nUzwvyl
H5ZSXAITu4dePZAHwT8q2Oh9v7KQ1KKctxA/foere3NSdoHpa5SQfxalN44m115c
TSUpXhNyygi5VGmF7D/GX8SSnNxsjA==
=FjR9
-----END PGP SIGNATURE-----

--Sig_/IkrFuo+obyu/jLPlPTRvP+7--
