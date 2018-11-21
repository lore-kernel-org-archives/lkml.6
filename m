Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41914214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m+92+XoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41914214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbeKVHB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:01:26 -0500
Received: from ozlabs.org ([203.11.71.1]:60817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732926AbeKVHB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:01:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 430Ywt46Sjz9s1x;
        Thu, 22 Nov 2018 07:25:34 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542831934;
        bh=mLnZbWxnAIsiGaqOsOY0HOS8w1l7vToH0bNatAZCihI=;
        h=Date:From:To:Cc:Subject:From;
        b=m+92+XoPGUiNurBANHl9D7fUH73EWbp9DRGwG81yhf0M1hktBspmnfdcWJTUfFETo
         vHZwsuf7MdKt5KXeEnyeiOZrzshjaE2k9NzFv4sVQZAwIDzaFmrC0LWJYfbDnh1Vhy
         mWjrxouPx9ZKddfxi9/bN8zJQELYJ256miPN1ZCCi+PvcdomsDYhsFRTBfhFPWm1Ec
         QwVUb5wtZ8V08KE0WVFd7EVbMKo3L/U0XCfokqcsTVFp2hdR+NZmGB5bwHZwlytB1Z
         9QLTBb14FUAFGsggd09ZvEhqO1evTq3s3STf3HMw3DKWkSAo7U/HxKybC0t1ew4ah9
         OPwOKcjfwumqg==
Date:   Thu, 22 Nov 2018 07:25:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: linux-next: Signed-off-by missing for commit in the regulator tree
Message-ID: <20181122072528.11372826@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JzQXOjNFZz+G8I/SY2HUwv9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JzQXOjNFZz+G8I/SY2HUwv9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  fe115f7fd44b ("regulator: core: Only count load for enabled consumers")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/JzQXOjNFZz+G8I/SY2HUwv9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv1vzgACgkQAVBC80lX
0GwpPQf8CtOUxZcnbvARuLWJ8Vf8o6uZR+LL08z5dkmkMpjoy+bRGymR5srm8cOd
2jCIIQ8vToF4W+qfCRLNI5+OKC298EX0HvSb1UmxsGMKFUV+7LpuV/R6c4zj9xuN
8JuRUwNyStmFpO4vuXT6lKmmuKqPStMMcaZwNu4rXDuR0f3QXwuT8IcTnB8LSlfL
ukjgU0Jxf9uGQ+H9fGr0NQG+tptxExeowbY9Zzl1v4OQFDLoP0YM807C48YBJKYg
h+8ikiNmrn53zBw/i7C/QdlZz0HWgYP3CMMD8KOmlk36ea/1gtS1OUcagE3Yp1eu
AdlWqB2tQvV6wWsL5j6x5bOAGWpGYA==
=s/Hz
-----END PGP SIGNATURE-----

--Sig_/JzQXOjNFZz+G8I/SY2HUwv9--
