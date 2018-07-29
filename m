Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3F5204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QeAqoTnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3F5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeG2Dmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 23:42:38 -0400
Received: from ozlabs.org ([203.11.71.1]:47333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731506AbeG2Dmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 23:42:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41dR8P6d1cz9s0R;
        Sun, 29 Jul 2018 12:13:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532830438;
        bh=j8Y47AJcPaGyiCHyuLvRCzsnA9iQpHGDthQyJe0IzSM=;
        h=Date:From:To:Cc:Subject:From;
        b=QeAqoTnbcL70CMxVQEk6m2ftFJvMiijjposThoKqahnhICCLwIHXe98PMvp1rR+0V
         e543hWgIWo2rrv4LcjwklG+oDsinZwcha3Nt7ZDbNFzskLHIAFwXOKSzkV2rIQmiJR
         mAsxct/toPrV/ilVpCk+SRLMlFSpudCxNm/A2ce1eIyySp3HrLww1/m6YcWyylxjTS
         oMwy1mBNHtuHF1ENV4Mi3xlyJPkiXH4ywMEAaa+NgQT8LwB9fLd4oVlIK0Itzhoz8p
         v90++Gtrb4OGbWggpqu5pdF8Gb7+7xMDOuWdfXAikaYmn5vf/EFPrzU//tn+7R7cbu
         gLzrIrM/xx4Dg==
Date:   Sun, 29 Jul 2018 12:13:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arc-current
 tree
Message-ID: <20180729121351.26912f3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bP1TogKgY+TMCHMoYvJmZfV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bP1TogKgY+TMCHMoYvJmZfV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

Commit

  fa52704e2816 ("ARC: add SMP_CACHE_BYTES value validate")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/bP1TogKgY+TMCHMoYvJmZfV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltdIt8ACgkQAVBC80lX
0GzUHQgAk4ZkHYWgVDL9X2LfqrFaQEqpiZyB2VCvysq268etv9YW66ySfCgR7hLv
O0HxtGPpYiMpISvJxtUw0kmDkfolZp36j+EZIYOW8cia5F86YF6uVwCNLU1LfE0J
XSaDTnXPsAK/A7uT32APZFEwla6H6GecMlG+2k0cAnJfuCULUAPQM34s+Fv1PPdI
0jBAao9YNLWIOwLL7WSRsypvZtQ4ejF7sebYAEkr64HWaVMrt43wmIbYF22vJSS9
uqndV+4nt+zZbpGCiZszQc/kJ94VATz/2qCCuIMmkJhCL+c93S96XSgtx6EcvDkZ
lsX5uuOQ/UlyKdebhIEyfJ1FqawdsQ==
=BDEO
-----END PGP SIGNATURE-----

--Sig_/bP1TogKgY+TMCHMoYvJmZfV--
