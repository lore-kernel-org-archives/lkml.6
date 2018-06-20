Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13158C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DD52083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ApaBt5y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DD52083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeFTVb1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:31:27 -0400
Received: from ozlabs.org ([203.11.71.1]:47845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933326AbeFTVbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:31:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419ygv0QG5z9ryk;
        Thu, 21 Jun 2018 07:31:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529530283;
        bh=tP+37CgG+ZB9q1qWn7urWbxVRd54fPXNC5CbqDG5A6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ApaBt5y18MoyE7BmFQwK5MAslUuyyHtn/ImQQO/ahhlo33qcr4TUPkoQCGLi06IdO
         t31+XTGmDfS2+LuBZWkR6KhIRl5+T2r77WtqqaCkhILhTPGgnaf5YSQCu1V166UF6Q
         MG98kTO6UfeTQjkE2rozwSVlUcRZznOESdP8Nf1updMCa8P5iUqpBUyVTcKXhAi0Cc
         zOPVtx67jSp+MakbG3wEOtth5TLVED83Hb6LUeWdgooveKUSPZngCB8NpWU4K9c6+u
         f7xE3VZH4biQRbUeoUQom91aY6HpCv8cK5KC7ZQNOcGZkpKgx9j4+UPQIIijGHf0f4
         fWGeGia+9F9+w==
Date:   Thu, 21 Jun 2018 07:30:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the scsi-mkp
 tree
Message-ID: <20180621073058.32b95241@canb.auug.org.au>
In-Reply-To: <yq1h8lxe7mm.fsf@oracle.com>
References: <20180619211533.1dddf9b0@canb.auug.org.au>
        <yq1y3fadxiz.fsf@oracle.com>
        <20180620145436.4deb9079@canb.auug.org.au>
        <yq1h8lxe7mm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GhKSn2SRcPWp0IDcfHfwLk4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GhKSn2SRcPWp0IDcfHfwLk4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Wed, 20 Jun 2018 12:37:53 -0400 "Martin K. Petersen" <martin.petersen@or=
acle.com> wrote:
>
> >> Fixed, thanks! =20
> >
> > Unfortunately, James had already merged your tree :-( =20
>=20
> James' script will drop the offending original commit when I amend
> something in the SCSI tree. So the discrepancy will go away next time he
> updates.

OK, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/GhKSn2SRcPWp0IDcfHfwLk4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsqx5IACgkQAVBC80lX
0GycsQgAhtd3vDUObBgtzNOv5cNx/T/SosCo4ULGolcprqs5HPkeX/FAvh9F6U2c
A6niay9YK2F8GOdzLc7G++Em1QwSOQCr+lmA1BNCFi4bwNnHc3bLuGWPzQxDKnlY
T5Umv7Xxk+uEVUj19F3RVv47hA3RJR6KIVd/vRNSRzrH+W9W4oarGvdZYQ4Oqyd7
THSWz50QvwZXsJHOIDJ0TiQkuYkcda7V6d/OWqbiKUBZgjjAzetmC41FtDJm26j/
9qtrQV8FWLwzM+wAghgGTh0oWqVfi4RWHPZH3yHhphKEm8V8NACwGWRH13n8nVrm
rtP+9VLsC0eUykPX0Bv3ZMUbEqujKQ==
=H9bc
-----END PGP SIGNATURE-----

--Sig_/GhKSn2SRcPWp0IDcfHfwLk4--
