Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA40C6783C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2540B20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U/XiwwdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2540B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLKUYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:24:12 -0500
Received: from ozlabs.org ([203.11.71.1]:39137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKUYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:24:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Dry133Cvz9s1c;
        Wed, 12 Dec 2018 07:24:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544559849;
        bh=MTvTMn3D+494wQJ7djJinH9eaAXyR64uR0mMHLhSMCc=;
        h=Date:From:To:Cc:Subject:From;
        b=U/XiwwdMPIKdDBi+Tpdlbp6x1HaveVApu3tBr1n88Yi7UT26E2E8LhV4XvVi1/ySe
         a0vhQvAM2LG7F37NQlx5zoIrvKiMUSefqnzeC+iWrAkJItkGO9amj4U+TSd16F2wUs
         +7RBAjJJT2/TCw0C9J7bOL2+N8DNubiD7N+XMsJeKk4Vm7SH15pVJIaW+59oU+w2IN
         1TLs5LtXf8+Dgcu6oTOLrBCQ8HE/YzYRkMnAqnxrXsCP+xJnWmo+QDUA8fvfg8zrOy
         +XFnKudtYE/2neRY3bM84TScOCX63y05CiVGXzivqfZ1Jc8nvwwMaGhUJg4oZqMm8u
         qOI/EAZUjxBrg==
Date:   Wed, 12 Dec 2018 07:24:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20181212072402.7b967df7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M8NGu9AN0qZCubDrYoPDlQ_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M8NGu9AN0qZCubDrYoPDlQ_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ec702fa79702 ("gfs2: Dump nrpages for inodes and their glocks")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/M8NGu9AN0qZCubDrYoPDlQ_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQHOIACgkQAVBC80lX
0GzsUwf+IlfRH/ejw9dftfobCVrGG1j/dX7txmrfqzRyuW1IkVAMeK5msA6V1Jcw
3KZZmxYnbx506muCfbNzM1z5xzwophX7sR2qaAImDSakZlmIXKVmuAIKYlmojXzs
Ws8loSGiSxP832sTKft8RFRMIx0Tv+4WyEUdHIInZZBi4Ei2xuWIDp4NKRzTXJJ1
7NAdERa2TvMMzHtosyKdbdk63YBN79ZCjgCL7GFeVDy8aW2o6YEbxkXoUw6JrQsY
o8IsTFtk7Y2CGg4u8vafYzvXfY+s8Qf65b5rDPGSilFHL+1FYQa/gbZeoOgPUJus
LpwXTuaU9o12MNv1wIHKDwJuL3K1Rg==
=0PFl
-----END PGP SIGNATURE-----

--Sig_/M8NGu9AN0qZCubDrYoPDlQ_--
