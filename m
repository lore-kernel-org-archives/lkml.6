Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B176C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60DC20672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ePevYZlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60DC20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeLFJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:32:06 -0500
Received: from ozlabs.org ([203.11.71.1]:50137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFJcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:32:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439Vjt4Cjyz9rxp;
        Thu,  6 Dec 2018 20:32:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544088722;
        bh=paVJzLtG9JnEeO1Q2EH7MMYxgoHBNVZLq+yvqmVDtHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ePevYZlHSshW3T19s+EZAJ3QF1l7aXIF2O2yx3FgsRyDEtD0pNEiWDp1J6CQ9o5y9
         6R6OiBBWFX4NWaT9Ms9zsBuj2d2Ym5vvfKthvncqyCymDYARQRNiUM190gMLOGa+rx
         g/rlMkUqTEgC/z0HdHvprEQHiWKwrhq0SVkQGLwyF3xnhkDAcNkWKezcDBr2g/BP47
         QBCyvcDcbCmAgJoUwssNVsxNdYUHp/RMc2fqDZgA/0FP325u3JGwhmeDEpEPJ+E+AJ
         kTaHwpAjGj1Z4WegMCB+y7v12X6H/AKXfDVBaGszqeJ5BpROylzUDYpoRLLty6sm0M
         dySxc8c1VF1ZQ==
Date:   Thu, 6 Dec 2018 20:32:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 6
Message-ID: <20181206203201.5ff81349@canb.auug.org.au>
In-Reply-To: <20181206191851.374f4352@canb.auug.org.au>
References: <20181206191851.374f4352@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2IsjG1oleTxSkH5ZTxD3PN4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2IsjG1oleTxSkH5ZTxD3PN4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 6 Dec 2018 19:18:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> New trees: thunderbolt, thunderbolt-next

Actually thunderbolt-fixes ...

--=20
Cheers,
Stephen Rothwell

--Sig_/2IsjG1oleTxSkH5ZTxD3PN4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwI7JEACgkQAVBC80lX
0GwG/wgAgyGY2VFGab19Ihuwv7eO2T/WDa/60WwrHPUZ5QJ9XCPj6xpL0vntdcFs
AmG8In1/6ma+1ghJC5B0lYP9iZ2QQzLn6el6vx4I0fAr/FD2g2+Yi0j3+13yyjfg
K/LK2jpywOQ3kxxJWaVn5LcTEKscj9By5hXPU0MZjFs9agSVf+ESQzQByl5yIuN5
cpr3Cas3hAtOOX2/N42h99qPQI31qD+TkxR+QDZJ7Hnrz9VoKbDsOOWJ/eIRIlBa
tYa3odeZGcGu5ULPxop3zwCrIpVBPTP9bupEqvyl7f5sef4f/OeTOBj2GuswTcOA
Jn+siO/FmfIR2COBCAK8EbOlCBF2gA==
=rdV+
-----END PGP SIGNATURE-----

--Sig_/2IsjG1oleTxSkH5ZTxD3PN4--
