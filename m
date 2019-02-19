Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F265C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CAF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pMxhsxSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfBSWdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:33:08 -0500
Received: from ozlabs.org ([203.11.71.1]:58131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfBSWdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:33:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443wVS3vlhz9s3l;
        Wed, 20 Feb 2019 09:33:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550615585;
        bh=seuQK33U+myzYtjnZFSVusLuHYrzVD6kJEjEh4DjU+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMxhsxSYU7dsbukRPPHqKZnRXoCYS6u77pmLGZQhKBR+eFG3vk51K61TQEMEHr69N
         K18qnSfr7Q8fnnHZw8GXaecZplyHBbrZvMN4y3E63kRXtNNvdMatiGqKxpHdpzAThV
         2VyDed6JGJBRgAWgTrhhM60uapiMPvbQ9p/sLk5m5f6GgXXe+IEtLEuIhLWqzeqjh8
         eYW/49egoYBz3i5NJdnieZpPCjmoeBAG9tW4/ZcSGIOF17s/O2aATt807G3aHvqXMn
         6qQ7fHcmEuN6jsuUCpl+dKQ5lFjGI1GEvo91mpVzO6Q/XP7b2ra3u3s2WMbAgr7lYr
         7f1oOMH3UOR6Q==
Date:   Wed, 20 Feb 2019 09:33:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the kvm-arm
 tree
Message-ID: <20190220093303.6abb8fe5@canb.auug.org.au>
In-Reply-To: <86zhqrqy2w.wl-marc.zyngier@arm.com>
References: <20190220073801.3cb6082a@canb.auug.org.au>
        <86zhqrqy2w.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UDZJS21+o2rUFV/_yMV13Uu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UDZJS21+o2rUFV/_yMV13Uu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Tue, 19 Feb 2019 21:15:35 +0000 Marc Zyngier <marc.zyngier@arm.com> wrot=
e:
>
> Thanks for the heads up. I've just fixed the tree and pushed it out
> again.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/UDZJS21+o2rUFV/_yMV13Uu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxshB8ACgkQAVBC80lX
0Gyccwf+Io6dJnQkexgitl9WgP3vwSG54cT/WmbLD3vg1wF7CsWX4Di1Yl1desJ2
46ytNUnnQYSSU3oTLiOo1Wz6LCEX5VkQZQGqpnECJXuLsy1MJeZ86Cy4laDJbxzP
prjt68jvSm8Dle/aupjBXvDT76CrxkB2FddqMFwXK4ZCfra5SCnOCTTofgwGJMuV
LLGOI6Cu15xdTN0cFZu9QEmAJT0joc8w4C53Ps5zWP2oaDk8iiwXpUCQpKRwYidf
O0TVchZdwSc/SAmkx0sll4DxZAD34Uhdo9mBv9y1dy93XmyjffodZSKsGbpNzVje
OzH5whT+/VgO5EiJPXrGb0KYOFmWHw==
=/y5m
-----END PGP SIGNATURE-----

--Sig_/UDZJS21+o2rUFV/_yMV13Uu--
