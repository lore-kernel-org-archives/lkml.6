Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED424C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC2D21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dmBVNcJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfBSX5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:57:09 -0500
Received: from ozlabs.org ([203.11.71.1]:43995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbfBSX5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:57:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443yMN3dCsz9s1l;
        Wed, 20 Feb 2019 10:57:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550620624;
        bh=fO0Hv5pjtorZ4bePQ7efDbT53GCSntslqtTBLEPq5SU=;
        h=Date:From:To:Cc:Subject:From;
        b=dmBVNcJ+N4WYCpkxvy/5CGaCstM+kenc6tTxVSntE8w05q9XHIJ4X+XDrz+hS9rRG
         XI/aFjGWt4hx7JGbSPsRRYL4/4WzpddpwTtsrJ56gN4n4ls1UrtxyHt6+HsZYZcMnm
         mhbY3faHXAiQI1O+z1LUiCh+gJIGHi4oZsZk26UQvCSWkvg1ZTD/ZCY5Fcv3bvgfHd
         fE4jxzJ4RpqIic2djur679yLmtRdDxIfPnRdIb4Ieh73sQw3zId/yKCyNuvYKMhPQU
         A88NWQUh+jv7iHtDdndrPmyNmVcpIdg1nFG3fSsZcV/rKHIrLO1CDpa3t6Jy1BBOU6
         C1TPSCtBKpBxQ==
Date:   Wed, 20 Feb 2019 10:57:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: please clean up the v4l-dvb-next tree
Message-ID: <20190220105703.69c9b582@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K_B8T43XAryDoJ6zl_PUVi6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K_B8T43XAryDoJ6zl_PUVi6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

It seems most (if not all) of the commits in the v4l-dvb-next tree are
also in the v4l-dvb tree and are now causing lots of conflicts when I
merge them both.  Please clean it up.

--=20
Cheers,
Stephen Rothwell

--Sig_/K_B8T43XAryDoJ6zl_PUVi6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsl88ACgkQAVBC80lX
0GxaMwf6A+gpGs2vkgWY9iBnIVQ2FudZoKz6zhpOWx/ZAebtqUTkrCzR6IjDZ5FV
n2zR3FDylV7IiOEZHtMqhqbK9emb4f3AGE9tYWUZYuqJ1nle2Ru9WYrbBoBU7Lo/
efdrNSAZ72YLt3o9pDOi1+t28/RKvEKPa26u+pqW1RKv8QKHFKve7eJ8MkoWHdTJ
V2EukCXvICW5PEjgk3czzMx3HvxL9P55TL19dvpxlex0vfcspiIhqqjgy7HBi2KX
xH8dMebs4VjdvPnbnhKTbFFcCENA2L5IfSLerU4U2xd+bWcbtY9I9TOP1ATn9PjY
S2fArRS+WCscvez8KxL959LdU2Zwqg==
=+aMG
-----END PGP SIGNATURE-----

--Sig_/K_B8T43XAryDoJ6zl_PUVi6--
