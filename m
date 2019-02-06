Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2463C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8479D218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KbA3qOt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBFEfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 23:35:04 -0500
Received: from ozlabs.org ([203.11.71.1]:49963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfBFEfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 23:35:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vTBY2v1nz9sMl;
        Wed,  6 Feb 2019 15:35:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549427701;
        bh=kM+SeEhQ0NFYlb1IBeIF8ptCizPd1cTCF3bVeZPbGks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KbA3qOt3mzN2XrzhVOk+p6ulfWclW7SfkBru+CdmAfqOXVOAdEvcIw7K3pXDr3t8A
         3yTx+PdlLCT/xGVuSAvBEYwFZYDMFQsg+3DV3JWh78Qp+ycoWCnI0QFbXggDe9ZMy4
         bwOtX630/aS96mA2JBHFTVVY3/k3jp9AJTmCLs/XlTQ01OUmFjVMINGXBH9xgxz2Ku
         jSfqp11OD23rsNeEyLK8AR/OUk1FmpTfUXxAIOTH5mX0N23Gi3YWJTbqJ1poHEKD41
         QY1KYZT+XjjrVIkMllF9y16pDIme24AHnUnkPHaotPmzmz9r2Vc2OAwgKm0UkIeGds
         bNzDmSvBsxWPA==
Date:   Wed, 6 Feb 2019 15:34:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the scsi-fixes tree
Message-ID: <20190206153406.0febc79c@canb.auug.org.au>
In-Reply-To: <87tvhhmuzj.fsf@vajain21.in.ibm.com>
References: <20190206072033.3d04f96b@canb.auug.org.au>
        <87tvhhmuzj.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e/PXiCKE5J8gFMidHWpaXfc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e/PXiCKE5J8gFMidHWpaXfc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vaibhav,

On Wed, 06 Feb 2019 09:25:12 +0530 Vaibhav Jain <vaibhav@linux.ibm.com> wro=
te:
>
> Martin, should I resend the patch with this fixed ?

I wouldn't bother, it is a really picky report (I almost didn't send
it) :-)

Consider it just a reminder for next time.
--=20
Cheers,
Stephen Rothwell

--Sig_/e/PXiCKE5J8gFMidHWpaXfc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxaY+8ACgkQAVBC80lX
0Gzj/wf9FVAuHXEgemdJbMqOrkD+2a1npnQVq19XcrTEmvajFzA4ISNzWIJoNyk2
sq5/U5IwY851Ur5o9h7MGjTuz7iVyW4cnEhZmXr3mtPbX3sMgd7iy66bcuvZTIDF
c/bs0YdOlnPydCL35qjqDh5/HnO5eoc42lC0Od86dInIiQZEbNd6equ6W9a1S1k/
gYOhUsKkZD/xVND50Nv0FyPQjqh4xIDDW2cK9dtxWMp3Fd0vjLXq5KVwT4+ddxDO
wpHkr5XA2E0YC7MOXt2zu+txs4LLgfeiUnFopzQrhCTXB0O4fiwm1WR2vnUYHc05
3lnIKPnbdoVoUj0LAspfCpEjlY9wQQ==
=SNO0
-----END PGP SIGNATURE-----

--Sig_/e/PXiCKE5J8gFMidHWpaXfc--
