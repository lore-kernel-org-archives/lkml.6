Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D129C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3926720857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AKlzO0rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBGUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:31:31 -0500
Received: from ozlabs.org ([203.11.71.1]:57683 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGUbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:31:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wVMh3LSRz9s4Z;
        Fri,  8 Feb 2019 07:31:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549571488;
        bh=AnRp2/679A/u+ch6HJZf+s7c0fRA+khtBdq33mWAVag=;
        h=Date:From:To:Cc:Subject:From;
        b=AKlzO0rFhv+SWAUvmgpxBhD6R7OdI8sTQykwk9FnTMfeRZ//gicZ5RBmlDw4Igvp5
         xtdzaEt3kwX4sO7AJZZdPaYK81TF4qh1NoABFM9GFbZRSmlEvYOO9W0JxUUbicx4K2
         buUZNfZ/5OD+uTDZm9bbwKLIqgXunMnUtLSZXWbMkdvkc+/rpkoQCw8SNDkErTqp1T
         Y1/kDXK+VY5kxeXkSARpfwgUMYgjG5W3DxXFTRNcoEFzDOB5/ypni8oyqR7Wknz/jc
         BxH9wj8okVXJ/dS+sP/mx0fioiXlSjEagVj6OqBTv9/Ym3Aw0N7MPq1p5BJf7HtxXk
         8Dih94AIW96HA==
Date:   Fri, 8 Feb 2019 07:31:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190208073113.0043c41b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rWI=/q4=d0Ydc7drSuSVCOv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rWI=/q4=d0Ydc7drSuSVCOv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  76379dfbfd7c ("ASoC: rsnd: ssiu: correct shift bit for ssiu9")

Fixes tag

  Fixes: commit b7169ddea2f2 ("ASoC: rsnd: remove RSND_REG_ from rsnd_reg")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/rWI=/q4=d0Ydc7drSuSVCOv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxclZoACgkQAVBC80lX
0GxYhwf+Kho1PKVJTzRqm4LQGZu/vgljgR5TyvU330rZOmyUxQCo15Xo99RAk9Qn
FluaxERc+LdXcaYnF5sZOUAzb3f0qNL9smSGFJnXhxBJJR8pQRJz8CP+ODPRmeeh
tbZMgMZOE/RofEjcb8ncSbyiTyRg/4+ozoouDu1HY3OFyHAweQVaSWSi9L5s6gQq
KP4uu/Xv3MAjkXGpVqbZ7jFno2n3Wof0vg4LY1vUdByL0ADV3HA/sCNxBqkzPAa3
9fccRoH65WKWTfAfS4kXSxPohAKpH72/cVLESC/UzOF9BXI3RPuB8dziTzWsUvdT
ldZAWmxNQOopgIHLPuirACil+b501Q==
=dj9V
-----END PGP SIGNATURE-----

--Sig_/rWI=/q4=d0Ydc7drSuSVCOv--
