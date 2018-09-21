Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27CAECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751FB21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mRKPrt/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751FB21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbeIVEtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:49:45 -0400
Received: from ozlabs.org ([203.11.71.1]:43631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeIVEtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:49:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42H8Cj5q42z9s9J;
        Sat, 22 Sep 2018 08:58:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537570721;
        bh=470to7rMD3fzYplh74cFzcavJCUUbhLuznwD/yokpAo=;
        h=Date:From:To:Cc:Subject:From;
        b=mRKPrt/wM+5KsaWivLjHrIBN7ok0DV+fmXibiUsBGLC6LzJyoWnH5CV6X28CPFLD7
         2aR8Vkm8+niB8XM2fZ8xb1juGqBVj/I/mOyyig7yO0b5tKwLS4V0i/7g3eOSGan1W6
         gLa/MR35TtTySfq82U5l/uFDblJYYXMF8v6qrNCLah3Yf+3cyucOv/M704u5T850MP
         UgSIgH0XqTBWQkpaiqrqzc0NpPMJBFlV90B9DZWwftJQek1TKHvgB8bVndj8jpk5Po
         BbXqIyA+5O9Eqtn5tDzrFRBUk81Yb/rKU9b4j02idCSgKMxYx5mDBbeHMGQjgvEXbQ
         6C7y1LSa9xopg==
Date:   Sat, 22 Sep 2018 08:58:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mali-dp tree
Message-ID: <20180922085834.5442f585@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=kIZRny5NQJ0IGq9ray2uO0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=kIZRny5NQJ0IGq9ray2uO0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

Commit

  fd75f5726f65 ("drm/mali-dp: Implement plane alpha and pixel blend on mali=
dp")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/=kIZRny5NQJ0IGq9ray2uO0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluld5oACgkQAVBC80lX
0Gw7RggAo+4xGqn7rqmOK7HLwQzxQQvOxmBfN56oWTDyXNl++JIQxh0/r2+o4vjN
b40FEMq92HQ+vSimTuOkeZevr1/WHbBUZ/GJcGUsdpTBOVhL190QhjA1Qlbcn0jS
sdFzKpp4pBMfmsU6T93KDPIn2YIwYY5sMIIfGxK71l3Q584GLn65R2cfMD0IJWxx
2YK68EeNlMPx2MtfdsPT42z0Dyj3tdC3TuBA695b7QtBwPccZogny8BVdJ0XvYiT
BGoMmv5b5X5MIk8kmK7d5H2dZHs/7mmIhrvH7CnoXe5fff2IxinyWXXEHI77GPQP
DtvMRTl/aFHy0ahC+nokgSxgJ2r4fg==
=xY7E
-----END PGP SIGNATURE-----

--Sig_/=kIZRny5NQJ0IGq9ray2uO0--
