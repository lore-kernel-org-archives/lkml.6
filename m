Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C4CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135823C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eaFh+N5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9135823C7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934296AbeFVDKw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:10:52 -0400
Received: from ozlabs.org ([203.11.71.1]:42527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934007AbeFVDKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:10:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Bk951zPWz9s4b;
        Fri, 22 Jun 2018 13:10:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529637049;
        bh=P6aiqryfVm5awz7eaxyu0SDD0y083dtwxOslVJ1h+1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eaFh+N5Jl/Ltp4x7KFvnGWY+iSE8M8IXY06Lgo+XL4q5RTs70zObwcnIjHRGMkEI5
         v6SS2JO02HhUyUQOrHZa2kT5PMp2z/lun7TUOyLFGYCwCGbRm/vR/uQTwVRY0h8UV0
         ZKHh/wsL1JtUu6Z5KLQKAfSzit9tSRYotK6ZcvoyOZ282yG1OrmgECngNmDvlOoFif
         9xOQIKIbT8ccNZYCYm6GJECMLEBc9u5IfIKIq1sXNjRsNNlm5ZS0R+dMkyVHNd9kam
         HHzh3FRglXdNPsk69QzDbri7D4n7xBxCjxmHHA1TUmvRBP1h9cREqwraDrFNuBdBHh
         A6TDIDmykHLGA==
Date:   Fri, 22 Jun 2018 13:10:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Please add the fsi tree
Message-ID: <20180622131048.61b2dcfc@canb.auug.org.au>
In-Reply-To: <c304c6e08d7baa6e725c2634ea94b7fa326edd5a.camel@kernel.crashing.org>
References: <c304c6e08d7baa6e725c2634ea94b7fa326edd5a.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I_9YCRHRbnEQTI/HFKZ6JK_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I_9YCRHRbnEQTI/HFKZ6JK_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, 22 Jun 2018 11:53:50 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Please add the fsi tree at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git (maste=
r)
>=20
> To linux-next. It contains the changes that I will send to Greg KH to the=
 FSI
> subsystem used by the service processor to communicate with IBM Power chi=
ps
> (and eventually S390 as well).
>=20
> Commits in there are intende to be merged via Greg's tree. Signed tags in
> there have already been the subject of pull requests to Greg.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/I_9YCRHRbnEQTI/HFKZ6JK_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlssaLgACgkQAVBC80lX
0GxAJQf9E+ydy3+L+bDzJqJYJNnvyvSpNv9qJev5DWiQYSE/Ch3+6HRe5dkISg6p
t4RJiKDG3JpesfnYe1NaTjRjb7xgMyaU54W2CHQAygLmoMZd54r3nPjLuqPARiuA
O9KZVrTh7ghw98qdVnt3xfWVegXttg1IpA/TCCqdpig3pEfK6ufrG2YHXfVR9gFm
wFgQGlSc8CbDcbg2t+Rm2i2NiGu88jlz9S6r4FEcOO+TmnDf/9GGStIKRqQEodQE
theziVcmndJpj89PC1k6tuPqlS8zC4dObIQzf5Pl+IIAYjxiPh6agl6jVk4futGb
s2UvbfsYH1FdvlRYc96qZeNNcaiM1w==
=c9Xq
-----END PGP SIGNATURE-----

--Sig_/I_9YCRHRbnEQTI/HFKZ6JK_--
