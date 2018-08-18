Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8A217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fqyHeMtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE8A217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeHRRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:43:21 -0400
Received: from ozlabs.org ([203.11.71.1]:41881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeHRRnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:43:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41t2fh3k8lz9s5c;
        Sun, 19 Aug 2018 00:35:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534602924;
        bh=RV5OfGsemNpT+zWgkiXFOQJ3afGCfCBZWNTC+ADJPtw=;
        h=Date:From:To:Cc:Subject:From;
        b=fqyHeMtfp7ftv6s85PHqSINsovknh81KXmJ4Cf6FFP2EpGBfBaY9NDGoslbgIcKFw
         0Pz61azjyK+NZBMi6pgfKO0FGhUgxgmy1zeW0hfHf2z8hLzlVkzD5QNN9Y6NFg2xrn
         Ga+9+zZotI6IOsd8yO3ZOcAGIA4/eT/UwUXVRPQUnxLppzEjMRY+MYslENNHZ/rgRY
         6XHOnHzLQNIv40PqNRei/Da1cT/2RjHy1NDA6ewygSgt8oqhPk02nfmpAa4z93785l
         JAZfxfOPh6rmLSKrWyK6SynIqcWuiWTgdZ5+epy/JDI8TjkCMb0oeh6+i/qyPt4OLA
         PxbCzYdUI45aw==
Date:   Sun, 19 Aug 2018 00:35:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257 <youling257@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20180819003523.398f06e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B0V2D.OBYzM.IAVaUaU.M0F"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B0V2D.OBYzM.IAVaUaU.M0F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cda5915d15d3 ("platform/x86: touchscreen_dmi: Add info for the Cube KNote=
 i1101 tablet")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/B0V2D.OBYzM.IAVaUaU.M0F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt4LqsACgkQAVBC80lX
0GwA1Af/ZkCVsGAV+F2zwX8iiVAgAqWM/ZLxfnIoZTdQwNTV2vhVZjzL7lflkLO7
xTWfcY0y8AmkKRMmHiZv+eFE/Wv77gPCRhJJQUouLFQx837TioGH6x0C9s1rw+yt
TdDhK6rqZvasvOHD9EaoARpfDDyEuVYgjyk//lqQI05mFHIneBdkKOj9LgMMv2fM
9cAhWKuZ7+MXpUobDg7ZSEr7xpqurHxMmOySGH+VqIRt7u3oJ8G4zggwtbPcveX8
T4wrNDAB1VYBSKryIuRTqZCBiSXU2EoSq3yK7SoXSfTEWYqnqomhKvjt/MGJWWyD
/KlhfNw+DdfOQXIU65+IQxYY66Fp2w==
=WDFS
-----END PGP SIGNATURE-----

--Sig_/B0V2D.OBYzM.IAVaUaU.M0F--
