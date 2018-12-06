Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DACC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8B2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V3UyJDRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC8B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLFUL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:11:56 -0500
Received: from ozlabs.org ([203.11.71.1]:36317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFULz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:11:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439mw85n12z9s8F;
        Fri,  7 Dec 2018 07:11:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544127112;
        bh=xlz63YYF2Hug/Xur6Rg3v+1wy2JeqkKdeVazEB4jwsY=;
        h=Date:From:To:Cc:Subject:From;
        b=V3UyJDRV/kknmENl2mB+/3UG9cMWj/Vf/cYLQyBCcLgPW+ftEBMbQPFmSz2Ukf46y
         a7FIAteWs4s25VnAdgEOfw+aems0t+rYusmVAojig3VeUgIi9jIh4qJw1W6GuWx4Uh
         w9v6hXrksTlDDTqIl9Ah4MQ+uwTfa+RufuTO6Ormq7V9H40+NfKOIwEE6Q6xB5Yg3o
         IghZgRpY/PGyXrl5+3Yh5X47nCkUWGOzAjCWerAZaKZEwDYNPOhLfagqmjmVxnxfl1
         tfXFQRPhYEol0xkEJQT6j2vw7lja9NaJjwYE3L/6eU/lhyyordpiUe1//9N0A++kQ3
         ZqKPh7ig6nDJg==
Date:   Fri, 7 Dec 2018 07:11:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: bad merge in the y2038 tree
Message-ID: <20181207071147.3b41fb5c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oolAIhc+Pzp4MkvDnBbr4.g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oolAIhc+Pzp4MkvDnBbr4.g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

The y2038 tree contains a merge of next-20181206.  I cannot use a tree
that includes a version of linux-next.  I assume that this was just a
test merge, so please remove it.

--=20
Cheers,
Stephen Rothwell

--Sig_/oolAIhc+Pzp4MkvDnBbr4.g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJgoMACgkQAVBC80lX
0Gx59Qf+N/Hdi//Jt7Pyxw3wZWpR9UXtHEqa63AWDcnCMLbiEg5ATejUMclUKhet
7RUnTgaNOoI03PSVwc55SyIsHmwylh7AXmpCzXp3ctLrTNPDJqtcJTRe01UwN9qt
BX1rOx7hC1k2cdpff3NMdHGKqChOUMK1tLu9B7l5m8YWJUzuRRBgpZKKtIyp6mgT
sQAGjXPz5ZUL5bPAZw0jtWtKstL7555rYLo7sZWQA5RkehCtku7rJ9t+pIXF7x4Q
EYGPQESfNz6RGa47Xa6Lqyi3bYnlJ2Psyd0gM/+5vrVVqJMdceM+5t6MJ4KeBl9p
6rQCjaodXJiSsEcoohYDLIs/c32uUQ==
=GMFr
-----END PGP SIGNATURE-----

--Sig_/oolAIhc+Pzp4MkvDnBbr4.g--
