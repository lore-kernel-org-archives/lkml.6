Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31521ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3324208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l9G81mRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3324208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeGOWbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:31:36 -0400
Received: from ozlabs.org ([203.11.71.1]:58685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeGOWbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:31:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TL7g1pTZz9s2g;
        Mon, 16 Jul 2018 08:00:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531692015;
        bh=qpdhxIEBDib9o9BjE1ONys5zslu1fEpw4sX1hL8nXdc=;
        h=Date:From:To:Cc:Subject:From;
        b=l9G81mRK8LSc0q3+WHxi9QMfEVhSWoFHHE9AS5q3GZP/yKhvHqq7nYs6GKFFKCgsj
         Ak9QrcYNYENLUP2KrrfOzVqCUflmqELSL7GZdK/mjnpCMkVBBFTi+Q6jDQzoH4RQMC
         vYFC1omVX+f/7QaaD7is/03yv1t3gz5M92SeMB2oOu4pYVIbdS3QTSDpcJMrsSo9ip
         vfcwrq1Nm9GOFYVZv7wvc7BGVJC63t+4jc2HUN7On6ndZVJnv0og4qjRBgnK2ZlZMK
         axr3YOcdhfZBmnLcL36HuiVeUZlBFLfIfZ2WbbtC8UbKGVGGXow1c/02S0iHdlIO5l
         xaVv3KzbQlpJg==
Date:   Mon, 16 Jul 2018 08:00:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the amlogic tree
Message-ID: <20180716080014.75c9016b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rUnyhHLR057.cEwkaaMRW6j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rUnyhHLR057.cEwkaaMRW6j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  3f1ad8c53b29 ("ARM64: dts: meson: enable the saradc node in meson-gx-p23x=
-q20x.dtsi")
  4dabd157d48e ("ARM64: dts: meson-gx-p23x-q20x: move the wifi node to each=
 board's .dts")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/rUnyhHLR057.cEwkaaMRW6j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltLw+4ACgkQAVBC80lX
0GwlJgf/SMTLKC+a9vtvKJ+heZfmcwsuUGiFgqAFH65dhsMmuHTsW5coPYyL18ki
8BR3Oflv+/WrH1F+5eAkHm7Uh/EkA+d1reSXF4C6hp4DBgKW99KC6Wwzl8fBH3aA
whMFJ4hEmwtV6octgrcZxwflsEOuftjyGz3guQfm+0U8RVmuC1wpQPJOIM5p/Li5
hmEfU2oty8oI4rwBnef2o52/4Nz0E1ShSeoyJ0/Pbd0NsGZC7x04pu8nwsCgg08f
VwVG0DA9SrnMqzfF+7IxrfbQPux7u6PkCXcyVKoLhhWPkeP6ueveNq/zZXzYNdZU
ghkBCLi2sAkA4kxfc/scpHo79JKQYw==
=ia4u
-----END PGP SIGNATURE-----

--Sig_/rUnyhHLR057.cEwkaaMRW6j--
