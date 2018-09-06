Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7793C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597C72083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tM7NPdXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597C72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIGCDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:03:38 -0400
Received: from ozlabs.org ([203.11.71.1]:36049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbeIGCDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:03:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425tst3wc0z9s3l;
        Fri,  7 Sep 2018 07:26:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536269173;
        bh=XEXnsEpXqCF2wLPhR/r2cleXKE3iuX5osbzNdlFerL8=;
        h=Date:From:To:Cc:Subject:From;
        b=tM7NPdXkuxSLxtrHQRlpY/HiUD7HiWnnX91rLdAWuyGP5BF4ZsJDAuihgqz+V/tOc
         5PYMidOaGVDcIOPZZ9tUwMr9STnl6J7tqkREHxGY7erZFkX3jrgApjNqtRcnGnMQ/s
         Cbn0x5jKPEu7lkNyWqGKYI6e0/I/GQkx0+RDGPXTXhglEF4CuUhAJkdT/lAFdUIFLN
         UjZeB/qHEmHekTq+Z9UDedx/CHif6qneLz1n7cPhqbtq+t1kZ2ia5+JhMxGRSVXF02
         MMFfcx8rx3QlgyaFP2NJdbCuUa/BlVvmwXPErmUydyV5zhVAfe8wrczPebWuqTPGni
         ydQdJAJEnPy9Q==
Date:   Fri, 7 Sep 2018 07:26:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20180907072604.3b0019d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qTMNdongZYF.DCqUSwKVhHJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qTMNdongZYF.DCqUSwKVhHJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  760902b24960 ("clocksource: Revert "Remove kthread"")

is missing a Signed-off-by from its committer.  Reverts are commits, too.

--=20
Cheers,
Stephen Rothwell

--Sig_/qTMNdongZYF.DCqUSwKVhHJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluRm2wACgkQAVBC80lX
0Gz0MAf/cQPb35R+sF2u+KkT5GFbTNgNHEo/OQr70kwr5FjTbYbJB+4Y2wBf2jEW
LshIzNbq4WkNi/Va6wK6IJgwHpy5UDzC4O5wJxb7xqnT2mklsJNUTMeKHoQLUjmy
5Bs2wKDveZ4HbwWcTw+OdUloIWtcsolsNm1ufNBorBdu3YgC2p8Jprbx7lX/+/1O
eBsCJyIyQCZfwizvgEqbDrU66yQaA2pRxFObQaTeq8dFVIWsX67QcP75hEqr8ktK
pKGANFKI4FoysTUwQkAurLnhAR0Auj64crpze5RmT1S3/dr8xRfAjf2z+AM7kQ+q
+WAWyQX26j1xpS+K5U4RfVYZ3UHCFQ==
=nd1h
-----END PGP SIGNATURE-----

--Sig_/qTMNdongZYF.DCqUSwKVhHJ--
