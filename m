Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D6C61CE3
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177A22084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YnD+xZjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfATEKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 23:10:37 -0500
Received: from ozlabs.org ([203.11.71.1]:45561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfATEKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 23:10:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43j1S965Ltz9sCh;
        Sun, 20 Jan 2019 15:10:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547957434;
        bh=xO1voMFlltFkj4LV3nMUquk5VVeVmfMnA4uI6GyBtbU=;
        h=Date:From:To:Cc:Subject:From;
        b=YnD+xZjUMesUiA2+aMg1DY9/gxcyF/xYpFYo2QFRdX6XoTQkRvlov+kwgdanv0mCD
         22O/34Xh6ioAztULBW/sQtdxfVTp6junfRgLd7XO/8jirHvmz0TM82vUqAotQn+oQy
         n9usbZ1PwZTcjvQxf0izozcCQMTZkD8viDOr4bfpTGNBET58K3CRm2SYYT0mCw0jvy
         +SPrCR6PW+rtS0P7EWweq6h2tmDmSfooPGJcG4Z8OilJ3Wj517ZCxT0dkfQ7rgj17B
         5Z3gs9jAJ3GJi4DFHqH3p5Mi9lcJrDi/qfcoi2DdKm0qq0JBUurNp9yRu3HL5owl97
         RleZwJrP9irUw==
Date:   Sun, 20 Jan 2019 15:10:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Britstein <elibr@mellanox.com>,
        Oz Shlomo <ozsh@mellanox.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190120151025.196b7a5e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eB5QcuqC+._gdmVJWj8Nsk."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eB5QcuqC+._gdmVJWj8Nsk.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  25f2d0e7791e ("net/mlx5e: Fix cb_ident duplicate in indirect block regist=
er")

Fixes tag

  Fixes: f5bc2c5de101 ("net/mlx5e: Support TC indirect block notifications

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

The Fixes tag line was split over 2 lines.  Please, in the future, try
to keep it on a single line.

--=20
Cheers,
Stephen Rothwell

--Sig_/eB5QcuqC+._gdmVJWj8Nsk.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxD9LEACgkQAVBC80lX
0GzaMwf/Qub8Lk1mIzFmEFUEqxZ0C/Brpc0crAwn1bDT1AR2thWpYcGQwvxwFmjM
EEdrjxEAEhsV8DAPJuEuLjQNFSRRsC4WUOVzng6Y/+73NmHmEXu5+Q5cISv78c/J
bEvVL4M27MBJ6r+ddp9+sAnWt+ZjsguuyjtvKVo6wTIOkkrSza215Unhj06YOh7w
Bz4/sbTBEUbLkbHWabOUkDNPhZ/7C6DJuoAt5vUlDNhP3Af8j9FyFxt6c18aZV9k
1IYbk/AuaERo+MRXCmh5LHS2B7uOpDcFTeVIfc7cyJ+48Bo/tzTHn7iPkWsSn93R
ozrfE29iipxSVQ8NBY21TWvt8iZnFg==
=KssF
-----END PGP SIGNATURE-----

--Sig_/eB5QcuqC+._gdmVJWj8Nsk.--
