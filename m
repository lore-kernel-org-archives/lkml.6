Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF14C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D1206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JjpJldlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2D1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbeKVIF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:05:58 -0500
Received: from ozlabs.org ([203.11.71.1]:54915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeKVIF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:05:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 430bM30Y3Sz9s29;
        Thu, 22 Nov 2018 08:29:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542835791;
        bh=Xgw4O3dqr1c18WCIMUBcbU9JK0/Ol1PPoYRoEq2XCXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JjpJldlmpU6B0PikYbec3Cs9XaobHUoPcaO0Oxv7YMgymMeeFue/STCe12UXPIWoC
         BnodEyZytVexO9KHT0Bxahn6cXIKO4wZrbameO+h5/tHFXPUvbgY4DmQcxlRrZlzyk
         7PcMeJYHOxjtJnyrF1Y4n2UJUWlpWaMnpA8vTzfDSM8T2ob+ljV5G1ehTrftug2NMM
         jkOn3yyFrTcUyP0zOKdV/pa2S349uHElluJkryolIxLXQiOvMRzEDOhTN2MElEjQYI
         qeJhEjjVMjpkp36c2XqCjJOPbzvy0Gp8piKiSq8B20YeWOOvxY9Q3dR9NoFj9V9N5n
         5s9qyCxLdWYmw==
Date:   Thu, 22 Nov 2018 08:29:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the regulator
 tree
Message-ID: <20181122082949.2c9717f1@canb.auug.org.au>
In-Reply-To: <CAD=FV=WErS73ZLVmnP1o1WYX1VfrhwhCa6yhRC4gS9B=3vPYGg@mail.gmail.com>
References: <20181122072528.11372826@canb.auug.org.au>
        <CAD=FV=WErS73ZLVmnP1o1WYX1VfrhwhCa6yhRC4gS9B=3vPYGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4AbEjVOapkp6lbHgFTQ7RGN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4AbEjVOapkp6lbHgFTQ7RGN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Wed, 21 Nov 2018 12:39:45 -0800 Doug Anderson <dianders@chromium.org> wr=
ote:
>
> Argh.  When I squashed two commits together I must have clobbered the
> Signed-off-by.  :(  Is there a suggested way that I can fix this?

The only way it can be fixed is for Mark to rebase his tree and fix the
commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/4AbEjVOapkp6lbHgFTQ7RGN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv1zk0ACgkQAVBC80lX
0Gx6yQf9Gk3gakP2lHnZJL1q/JReTXsOfR9qn63o8z2KcFH72fxNxvXGph3xNPPX
8c8YvqSwmiEng7arwL6wQRvTBZcXGoIj2r0LY98MZfS5YmiNE+B0cd6q0Yya6TQP
Lz3LLaFYTTVYbaNBJoyx4CBjAhR4VHVnoDYzfmdFn6oMGOLvAu38BuOQrtf1h+8N
P4/zwX+P7Nvf94tKr+HeM2U29vnJZl10yLPu85nE/KGbM3eyLPxsO2rVf2ReOXB1
4VG7cbpnGawy8lxEHb/Vr7ITEFE1NxbZfB9x1iEXx06tAXbbTt5kUKnL4hpxsA2V
YmB9TSrMBN3fNR0gPQhaZBqqhh8kvw==
=R94f
-----END PGP SIGNATURE-----

--Sig_/4AbEjVOapkp6lbHgFTQ7RGN--
