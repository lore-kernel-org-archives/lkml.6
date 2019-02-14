Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915302229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tvLPFYr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfBNURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:17:23 -0500
Received: from ozlabs.org ([203.11.71.1]:47245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbfBNURX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:17:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440nk82v96z9s4Z;
        Fri, 15 Feb 2019 07:17:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550175440;
        bh=TcmgZohNs0BzQtealhQSW3xhJzEihIRy7Ar5tVlMY7Q=;
        h=Date:From:To:Cc:Subject:From;
        b=tvLPFYr/52RY7RyOLcIcjptK+YElOkYzBA3QIPgcDV5zW8EpaurSJnIfQEuHxJ10h
         uUW3TZJxHqi9CtwEWcljwgtQAfWWYQjsdLfyCP6WqjE3tm4ZzY9e7MlyZeyZV2dEvo
         xP/rpFRfK7pOF4TGl/7l3MiZgJmlKzzk9fpRKXsygYsm6h9Ti5Pkg0tArL1c1NVjzJ
         X+YueL4Gmuh2DaObFHiebmdKY5SrW4lyvSeiJePLi8HAn6HjkMhaML+/ePOP1Z9IZn
         UNEhXycYA1kDmeUtpRKpUMHFQB/TeBlQdXgykrFmBIn9uPWgTeP0slB8RmpJU3rIwC
         qNVs1BCRPU42w==
Date:   Fri, 15 Feb 2019 07:17:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20190215071702.56ca522f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JlU.7LRQ5UAzBF0AwgB9f3J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JlU.7LRQ5UAzBF0AwgB9f3J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8fcf13f6be52 ("mm/page_poison: update comment after code moved")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/JlU.7LRQ5UAzBF0AwgB9f3J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxlzL4ACgkQAVBC80lX
0GwA5Af+IG+DrTclqTKdNi+ECHT7YKQuP5d8U2Fo5ptXyi6TC1LVJceMMVcF0Xgy
olAP9kxbBcYomfvu69rJ0WHpnUzS0+XlPbc+xKADhXQZWCRXBFNR0pOCYkgd2Njw
0UKUf9LXhwNjREM8jymlGKebdKRa8rr9tPshpS3d3kD1kwRKCfPWjWaooDBqe10G
Gd9b0lLF38ZOby5JWqPdpKO+pNtnh1COVhhqLjCp261F0TInpy6fWOgYVYghcfmC
ZE17Eq6isYI5uEgaYE/1XxtzopG7tICDWG8jRBqAuwCAuT35EED09vN2cnG5EZJg
iLr9qMjGfWCaMiwTIV4q8/1gz24rUw==
=Pfyh
-----END PGP SIGNATURE-----

--Sig_/JlU.7LRQ5UAzBF0AwgB9f3J--
