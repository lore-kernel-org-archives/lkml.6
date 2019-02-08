Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369EC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9432021929
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kE0/Vu06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBHLk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:40:28 -0500
Received: from ozlabs.org ([203.11.71.1]:38769 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHLk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:40:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wtXS2QnZz9sML;
        Fri,  8 Feb 2019 22:40:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549626026;
        bh=JJqZ+W8MgcHUZatSsFJ8VKpmNMn1kFhO1/BK4AFXmb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kE0/Vu06rbl30d64a/nNckFgYNA5sL9ojvdaCmoks79emOLtynOa/Y0iq4p8HAoR5
         VHIVgeF5k0eCdv5KmKIb3i2zhqsGauyjQmnpM3MHbYJfn6ar/9Lr9qQrkfw1y5COQZ
         8sDWwWJbsehPnEWADXQd6tPT/QW5+/B3R2s/IYq3vyq1CqMvwF+5UcNNHgUP4Zwn3q
         IxO9xlcizyjtGqIfDnRhPVHXOPUhyek/NEHS/+aZc2DR8wGz0hC9AM+bdJRgzj0pgA
         4aSpSjvBGNbInRQ+e9GrI6ckEvt3qGR99SeVOq00aMiGL4TLt3esdz3WJvRosl7myX
         d01oOPeczCi0A==
Date:   Fri, 8 Feb 2019 22:40:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20190208224022.6bfdd56d@canb.auug.org.au>
In-Reply-To: <2145777.rZLEu8YqWI@diego>
References: <20190208220137.3b72799a@canb.auug.org.au>
        <2145777.rZLEu8YqWI@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WRmrqpeCRp1v1YZBUH2VnvT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WRmrqpeCRp1v1YZBUH2VnvT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Fri, 08 Feb 2019 12:31:38 +0100 Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
>
> we had this warning already from the drm-misc-fixes tree :-) .

Sorry about that ... there goes my memory again :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/WRmrqpeCRp1v1YZBUH2VnvT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxdaqYACgkQAVBC80lX
0GzGTAgAonbRwa6BT2OMnCXiT0vr8+MzkQPWBcXDrPXJ2LoaKbkXCDMxB65+sLoB
yR78Vl52nUdVilOp+VMgGdXPOGo4VP1ylNpmb6kDoRWO3FkRrAPsK9y2aEx2ZoRU
f4myF3pwSrK0OBJJM1NIMlCSPArlLGKqjAIVY8mOIutwERYq2oBvS9d991wStA1m
Iydwi1TgcZa4Z2Fizx+YC+86F3AZ7y5nT40MwGDnbKPIUlS4wvD7zNFcwQJgiBUT
arZeq3X0zfMO0tTzqbTJyv/1u96KKZPZkX0JAA/9GdbE1QFZqoogOXvBMWFJWAaU
GLp4p6UzUzYLfWQ5q8CYBJ1Ejldb9g==
=//hW
-----END PGP SIGNATURE-----

--Sig_/WRmrqpeCRp1v1YZBUH2VnvT--
