Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6066A218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dnDhz9XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfAaUgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:36:05 -0500
Received: from ozlabs.org ([203.11.71.1]:36321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfAaUgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:36:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rBp96qcqz9s4Z;
        Fri,  1 Feb 2019 07:36:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548966962;
        bh=w1uIdG+0mlzb7FIcgvsuUU3hCJg3VHfql3WCnef3HTs=;
        h=Date:From:To:Cc:Subject:From;
        b=dnDhz9XXjcnavvUllsRwFsnkjRvCjTKw3oHYdcdZbr5T6Nyo5YpH+BoRVrtpmgCOW
         4Xe6jftBK4ZgQtToS9iDrh9Nd6RxIoaOjsBjcxiEPZuWtY8Klo0bv5trO5BqPfJYUD
         IGBFoSjpwgoKL0Y/pZnHZ8GyJSJdl1TvrBxiKlVnUCXafZxnJVvVpUBSOaeAGDfwRC
         wlOmW7mNG8JSKxPNUenoNrIi9PUNjFpVv902e5AQWtYAZxv9Cz3PJr9yWDY5NwcFXQ
         kufOtQyq/OetWSMzJ7i0sfPb8buUY0Bv+TajCd/aOHskfsnRSrGiXH4rjhfcN/2Hiq
         H/NZYDBg4aIJw==
Date:   Fri, 1 Feb 2019 07:35:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190201073553.742ec57b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S12qAWD6jV+QVQr2h6xSvrI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S12qAWD6jV+QVQr2h6xSvrI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9fc55413270f ("net: hns3: fix improper error handling in the hclge_init_a=
e_dev()")

Fixes tag

  Fixes: 288475b2ad01 ("{topost} net: hns3: refine umv space allocation")

has these problem(s):

  - Target SHA1 does not exist

I can't even find it by simple searches for the subject ...

--=20
Cheers,
Stephen Rothwell

--Sig_/S12qAWD6jV+QVQr2h6xSvrI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTXCkACgkQAVBC80lX
0Gxhngf9FKIehBrEVoYr4sGGy/mNTpCNov8jsP5bHQWyjGKH8wDsvg0jLB27nDDv
FbajKS1lFA/2MXMc4k7nB0FoHPVlQ6rnliHId30YOJqQq3z5PKTMVo5050TvgGgR
iMwQVdyjj2O5vdrLCNP0f8s5P3O0Bp9CP8tRj7G2+ajscd3VLtu78mB8d+sOtaux
cmTVLDG9Uxtn3eM2koYd18qEMKhFdhj2qAiuoUpWHM/KGqHw3tQ+RzDe5g0sqDPU
NnEymkXbxfThEZnI9Yv7g3RBGk7G+G9P/U1F1STH4obTsVmzVvpK66OVBaGEVrdt
gRCvBRk//kgSMrqKx0XM2PE/2f27Jw==
=1XpU
-----END PGP SIGNATURE-----

--Sig_/S12qAWD6jV+QVQr2h6xSvrI--
