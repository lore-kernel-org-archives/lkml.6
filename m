Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3E620836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VPbU3mAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3E620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeFTEyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:54:41 -0400
Received: from ozlabs.org ([203.11.71.1]:56517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeFTEyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:54:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419XYn36V9z9s4n;
        Wed, 20 Jun 2018 14:54:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529470477;
        bh=el+2GVxC/lmPgaAFdd/A2S/JwX81RzokiPb/Ieiz3aI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VPbU3mApm0zF8blqQWLzzb42lMr6GIJHPVpP7vW5lYf1ZtwktgMMweu/gLidWJYkq
         rE64FtX1IPcF6Lb5rzbURsd3ZKagJLx9Oa70mYUK8+HMsAF6z9ypeMZVIFTDQkzIwq
         38R/UFX6zeuKCHGAbPoB0M3sYqkrVACYtNJOhI6C6QG/+52L4cIDeh2OdsRgE+iRuN
         PhcK+yTtmDAMyi/R1vw6x0FSSS8ZiVbmhM8s8RMRmNqUN1Xp6os0BMmsHtfZlmhZDA
         BIrLMRPxMvcuG75B0Og52neoQs6+H8B3WKaEJLd3+iL8TftFTem0MZtu60jMPV8qYx
         DHzrJ9ayXB0eA==
Date:   Wed, 20 Jun 2018 14:54:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the scsi-mkp
 tree
Message-ID: <20180620145436.4deb9079@canb.auug.org.au>
In-Reply-To: <yq1y3fadxiz.fsf@oracle.com>
References: <20180619211533.1dddf9b0@canb.auug.org.au>
        <yq1y3fadxiz.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OihCY020kxEbYjQX/BKhSLj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OihCY020kxEbYjQX/BKhSLj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Tue, 19 Jun 2018 22:03:48 -0400 "Martin K. Petersen" <martin.petersen@or=
acle.com> wrote:
>
> > Commit
> >
> >   508fbc44bbb7 ("scsi: be2iscsi: Include null char in SET_HOST_DATA")
> >
> > is missing a Signed-off-by from its author. =20
>=20
> Fixed, thanks!

Unfortunately, James had already merged your tree :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/OihCY020kxEbYjQX/BKhSLj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsp3gwACgkQAVBC80lX
0GxVUgf/ShqmvO1/O/5dubWdr5Qfxu00yazSX5fp4Mc+UpyRhtX8KWmkyRzIn9nl
1lX3l3toiXiDbDAagi6GN7KBOMiqTmsZYH6IHp4TsgNavokzbJTSXsreuPUOJoMM
PUj9tgBB3b7ztdWeK49WgbZa8gYc1ftoz7ZvznqUbxcpRZKgBPF8kNPRqiS0xRVb
mPNuxBxHi6g7JFZwVnifi7K6rrArLzO1kwDXDeqq36c/Mt48+bUXY7PP7NerwtRc
0lFvFKb459NDAJ4BYKSV8NDwOfTxfKx1c3LEwWfQYN2QoZEe1DGjRdRy4soBZy/U
pSUS4AeV+LdiCiWUnw7PNLIgjtAHjA==
=kXQ5
-----END PGP SIGNATURE-----

--Sig_/OihCY020kxEbYjQX/BKhSLj--
