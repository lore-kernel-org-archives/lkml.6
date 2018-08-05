Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC5FC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823F4218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823F4218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHEX5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:57:19 -0400
Received: from pide.tip.net.au ([203.10.76.2]:53235 "EHLO pide.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeHEX5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:57:19 -0400
Received: from canb.auug.org.au (124-171-82-245.dyn.iinet.net.au [124.171.82.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pide.tip.net.au (Postfix) with ESMTPSA id 41kDxZ4Fgnz9C1D;
        Mon,  6 Aug 2018 07:51:12 +1000 (AEST)
Date:   Mon, 6 Aug 2018 07:51:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20180806075112.6253d2da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D.puO.VvdkJLSP1ml3ymr7j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D.puO.VvdkJLSP1ml3ymr7j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Commit

  290a40cb336c ("nvme: don't enable AEN if not supported")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/D.puO.VvdkJLSP1ml3ymr7j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltncVAACgkQAVBC80lX
0Gw6OggAnXe2ilTZg/3wNzjCkOfX+SL/UmP6Cl5I2X4ZgOryCtV4tGjTAh/+jMDa
MjyIMd1wlfohGTplgytUCfz6g4y/Vj6Lps8DAieR37UwF32nAO03XKoC815eWeDq
GuIlnA84YON9sGWRKxt+KvIgm3z0IVyRT2uDAdNQtgs6dBR/ar1VXuQaoWd2kUAC
/hKvzTW5Cds7qTrnlpta5ew7jNh5cic1gT2xRAM+xAJm1oIrTi0dUSZiE15zox3H
8Yv9rWFrO19Xbg/XuWmLgc4AesrcGKI5QFATPmM182hVi8WKVlqDGPQItzn4BJ2G
Dj+s04YjZRFskWL8TZLnqlfO7icgHQ==
=E6DV
-----END PGP SIGNATURE-----

--Sig_/D.puO.VvdkJLSP1ml3ymr7j--
