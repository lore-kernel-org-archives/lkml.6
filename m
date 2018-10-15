Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA0C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7026B208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YPlBMoyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7026B208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJPCeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:34:03 -0400
Received: from ozlabs.org ([203.11.71.1]:60111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeJPCeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:34:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YnVr2fP1z9sBj;
        Tue, 16 Oct 2018 05:47:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539629252;
        bh=nfiEzyQdxXDbSlWeQzm5l5tKMD5uXE9F5sJ/IDYSzr8=;
        h=Date:From:To:Cc:Subject:From;
        b=YPlBMoyZxONx+tZ55kMj+zaHYv8U/376gL2AoE8SlEHZMbErmuSn75nAwkp/YdRZc
         tTAzL6r991ICgSZqipaCcG45Z4DEOT6Kr7vUtjAR+jFbWNStX1wxQXhyyip1MFuz68
         h7/rlVvrSGfCbpVj12R6KGiUjQoeEhvuxgpJVQJgfRueYGPwCI+ftR9KvtQu4brHNA
         5Pll8+0jE3EbsJptcPhGVSTKe+a46G/v1Va46rpkV8SpAEbIqVaSC1hZhtW0Km0UQT
         k8K7BmI1S0U8Nzf1d/dGoIk+FNHVc3zJGFwMNGkPEhN0HJ6CQ/GYrFgNWevSnpWOiR
         ByMa3xxlrPMVg==
Date:   Tue, 16 Oct 2018 05:47:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Schatzberg <dschatzberg@fb.com>
Subject: linux-next: Signed-off-by missing for commit in the fuse tree
Message-ID: <20181016054723.4dfb83f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S=9TE4XGR7tbJl=uSNg9tR_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S=9TE4XGR7tbJl=uSNg9tR_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

Commit

  5571f1e65486 ("fuse: enable caching of symlinks")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/S=9TE4XGR7tbJl=uSNg9tR_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvE4LsACgkQAVBC80lX
0GyaEAgAiYD4xrM/7Zt+wPi89D7ZTAPTggrPsT37gf5ZTl4p1FGv2gdcOLDzKBbw
/gASdUGGim9eDD/Jx09l6G2rCeckz/FgbI16xyuSlBHlf0+LIU0vLzUhHidf3BNF
4gBlQwK1BgEJNlSXnQNZdvDIJSWTEcohbQd6zrglfy7YZlmasJemQ0C7PCs0N0M0
1B6+sBETOeOt3p0oUH/tQDkJx96K4LkiNiYZqo6pVwg5Uk2LJS+l8My8FKBWlfPY
qYYUhRS7xHqK6hqoQHgxODN1HGSHwln5cTcGo5nSW4EZtX7X3TK9ZZfta82og+ws
5EH/YrRWUc5bbmcR8QZ3rQVMQ2jWgA==
=+Niy
-----END PGP SIGNATURE-----

--Sig_/S=9TE4XGR7tbJl=uSNg9tR_--
