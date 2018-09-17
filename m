Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93079ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D46A214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NPqEdTe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D46A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIQQag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:30:36 -0400
Received: from ozlabs.org ([203.11.71.1]:43655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbeIQQag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:30:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42DNXX0lSvz9sB4;
        Mon, 17 Sep 2018 21:03:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537182222;
        bh=eUc8awBQHlBuAFU02cnsAM/jhiWsILYWUd3lYr0vyj0=;
        h=Date:From:To:Cc:Subject:From;
        b=NPqEdTe9svPCrcihJk1CY1VFezuz0zuIXVK+ksmQI1mixYxqR6htkM1SnhClmAtBG
         PqUMpaE9QXp1CJDdnZsLjZgMla2Qrhk0Yxe5p3qBmCxG2pVNzToJjCovvvS9BINNTx
         RIqt9eP97NfeXN2XELkBebcgmnJ4Qc6+2CJ/fQy+JmxsDDZLryAMsEp+WWXUJcodHq
         rQnl9yN5SuyvcIdLNAZbeXD9UnIpK903m4hv/NvgRdnfm6rTDAixjg/Hb/9L2Xn+KR
         vTyODqXKcTEUb/nhoSEwuNfeeyEVAXjedOVnfM2I4EFANDow5seXCkzTfm8NX2yk02
         AkfTyMADI3ujw==
Date:   Mon, 17 Sep 2018 21:03:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@elte.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: linux-next: changes in the maintainership of the percpu tree
Message-ID: <20180917210339.21ebb029@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hbDnUY_be7uUy8fVd41.Hxr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hbDnUY_be7uUy8fVd41.Hxr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

I noticed commit

  1194c4154662 ("MAINTAINERS: Make Dennis the percpu tree maintainer")

Just wondering if this means any changes to the tree/branch I should
fetch or the contacts I should use for the percpu tree in linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/hbDnUY_be7uUy8fVd41.Hxr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlufigsACgkQAVBC80lX
0GyRgwf8DoCHOHSabdoBgj1BroUdrOWCYvM+CNd/3pSJ/x64a0qvbZ0JgUGU5B2z
JOr7+mwYy67HZCQqoio69iEoDvPO+fVu+Tg995epFRuXj6EKp11bGLml/8QvPVQP
jfIZ6biv8oG5MN1GkhV2gMo506h8HSdK50lfmmOdCWLjhg5lSS+NI6QSYyzJCxcn
yYJUNErY4H7iOArecRe1CdD1rRv8DptQ1R/mviOsSYKJhgI7w9tBLcovYXnlxfN1
gi+3rqPGWrWwwDLOB1wbQsRhPmHqU5C3HM6p6GaORYOxaexTG32waoTr3ty1BNQD
MqpouHk6/JwN/dIOPn/5GppXi0rgMQ==
=6q5K
-----END PGP SIGNATURE-----

--Sig_/hbDnUY_be7uUy8fVd41.Hxr--
