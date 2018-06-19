Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455AC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k0cnLrIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455AC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966263AbeFSLPk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:15:40 -0400
Received: from ozlabs.org ([203.11.71.1]:53021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937580AbeFSLPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:15:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41953p39qNz9s5c;
        Tue, 19 Jun 2018 21:15:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529406935;
        bh=JCI7DaAcPX108/IDLV9cyXYDogfxmEEUid4BHgutnJo=;
        h=Date:From:To:Cc:Subject:From;
        b=k0cnLrIqaEbWjErXnYTjKrwoe6Wz4KuT7gjR3kKCuzAvAHxtD7AQK/9RjOGLgeApE
         3jW4mUu9nmeYdUe5sly4yOtiHeX9cepKkQeYHizJ8yK6kuLYQc6HJyNl2Ko0tAYQRJ
         VaqwLgW2Jtap9HQprbv9f9oxq99C/QKFz2nJ1S4a6k3NmTNhNX+QMN0DNyfViPpzoF
         Kh7eU/ysSAgItHN1wMngatXX7VWfMdwpgn1T7eNLoMOhfe+/EXT24E3MUw7C+XSQ8A
         e3byWcV0ogDITikRc/xKcwWv/Ltl3MZ5IJFs13aJPFsVw1mrv3JyEcSqdC8gKxP8/0
         CVg46n0zRyqxA==
Date:   Tue, 19 Jun 2018 21:15:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>
Subject: linux-next: Signed-off-by missing for commit in the scsi-mkp tree
Message-ID: <20180619211533.1dddf9b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H7ghmihbp22fxsmr0Y9XWJK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H7ghmihbp22fxsmr0Y9XWJK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Commit

  508fbc44bbb7 ("scsi: be2iscsi: Include null char in SET_HOST_DATA")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/H7ghmihbp22fxsmr0Y9XWJK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlso5dUACgkQAVBC80lX
0Gx+vwgAgPZB1PJiKJDrIqDp2XXIoebBXV3ZhTakN3+28u5PQdmAW5cG8ru5t8NH
quKeTrN/gcbYtAgMzJph+JK0keWs9p6Jw2B7YBUytqGnHO6/oyy8Osh+sSfQ32E/
KXLqz3NpISTp4n4Wmy4vSC7ylC/WNghDzs+Bmw0RD9qvo5K5kUb6uhjBHE2zJwIT
Sc95H0ZI+BlYPxFAAqETOsy79IYtF39MiVEk8b58jeqAjYwLcPwvwwxchrP2GbqB
TJ7Fn2HNt9pyIrwT8IgJopOYpO9acmj0O070j26mjulIHt2YuekMn1DyxdquAE3/
u5vDTWrATnAGqndaey0dYyr4TKytrQ==
=zXgi
-----END PGP SIGNATURE-----

--Sig_/H7ghmihbp22fxsmr0Y9XWJK--
