Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE32C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B8820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XtCQtIDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfBULL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:11:27 -0500
Received: from ozlabs.org ([203.11.71.1]:57585 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBULL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:11:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444sH01M9Mz9s4Y;
        Thu, 21 Feb 2019 22:11:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550747484;
        bh=gsgJ2pt46ank+w4ec97L2m6FaArx31ZMXW22TNd5xCg=;
        h=Date:From:To:Cc:Subject:From;
        b=XtCQtIDfCxGWgEPqa3vHeo7tBtU6HXnW5Tis9MyvMKm/GIzPOU296lrt+9dSiNoXe
         o2hhhzEFHjTtT3ovS41ScOOL4GXrBxKXPwwunR4aHiCdA7N5ad1NxkyW4tq2SnePd2
         NmYouhZBb5LE5YsodDqjRO+3JAWOuwC3mndBpy7R9uLUqPylciW14MtrqMKBLki4F/
         toLyeJVn79sztnE3nhPcTEiqSZQWcKKP+5UKjxozwg7ar2E2YvOBqert401WIkrx2f
         0RLm3bqcZFyDrdzOEjqxf6ixS7bpyW4zUqGcKQ99lHHZqZQs7VFyD9HByOUO1Q2ECO
         b5uCYhyaYRXWA==
Date:   Thu, 21 Feb 2019 22:11:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Fixes tags need some work in the net-next tree
Message-ID: <20190221221122.7e0f13a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ab1MvUwH6nCM2WdhBMI08n1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ab1MvUwH6nCM2WdhBMI08n1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1c50d369f560 ("net/mlx5: E-Switch, Disable esw manager vport correctly")

Fixes tag

  Fixes: de9e6a8136c5 ("net/mlx5: E-Switch, Properly refer to host PF vport=
 as other vport")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

  Fixes: cbc44e76bfcd ("net/mlx5: E-Switch, Properly refer to host PF vport=
 as other vport")

In commit

  acad70731e63 ("net/mlx5: E-Switch, Fix the warning on vport index out of =
range")

Fixes tag

  Fixes: 22b8ddc86bf4 ("net/mlx5: E-Switch, Assign a different position for=
 uplink rep and vport")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

  Fixes: 5ae5162066d8 ("net/mlx5: E-Switch, Assign a different position for=
 uplink rep and vport")

In commit

  e87636117e9a ("net/mlx5e: Remove unused variable =E2=80=98esw=E2=80=99")

Fixes tag

  Fixes: 1cd3ab86b713 ("net/mlx5e: Introduce mlx5e_flow_esw_attr_init() hel=
per")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

  Fixes: 988ab9c7363a ("net/mlx5e: Introduce mlx5e_flow_esw_attr_init() hel=
per")

--=20
Cheers,
Stephen Rothwell

--Sig_/ab1MvUwH6nCM2WdhBMI08n1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxuh1oACgkQAVBC80lX
0GwQ4wf/VKc7gJSMN5KAuJ5Wg5h+yW4R/nGjffsKTiMf0RQ4DkWKZEXmCuSyyGPO
CZUmN3bpymp60xL3RscyEu5Bt8/KcDspBocezmQ5OqOn5kqfJLpEDGZn6vt/goCc
Ukhcb3gc1nkjceWA2yba3oga53MBL+VgxAZelS+CKl+xPsG2wYW3Gfrkfp5AW1G4
0Q2nqGBHb9Z6WYghRse3/t92Rq/h4G1bgYceGBO8xakJsFhsvdZQ6ewDqqZ7un9l
b6iMrjWbq4aTkXkAMaSFXcqFBel+58T3I0BL70KRZuFbs3rIxrYDwCcgrTp6y0v1
8/KO7LbNXLVkfkPAoONBQo9HMcebWQ==
=zSYl
-----END PGP SIGNATURE-----

--Sig_/ab1MvUwH6nCM2WdhBMI08n1--
