Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC55C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EAB2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ToKs4kSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EAB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLFVB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:01:27 -0500
Received: from ozlabs.org ([203.11.71.1]:59073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeLFVB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:01:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439p1H3xPNz9s47;
        Fri,  7 Dec 2018 08:01:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544130084;
        bh=tvYMXjtFhHAY8sIZ9WjIoHcnf0D/XYHLosjxxKrVdkA=;
        h=Date:From:To:Cc:Subject:From;
        b=ToKs4kSxq6iGweon22S8zn/LDurTbUDFTZV8xmO+m7ShUZj7XuZ4UQIsCZZKbkaaw
         pcm1N3289VfbqrMQ63kv6F3beIDSnbrbQJ53vLQQFxCyBcVWETgrW89CTxZH4IOQC3
         D+p64kmSnjhCnjhV2n21prGSA9H8l5OP54dok8X2lYIfkXoQhIGgAntxImINy6UDnx
         BLnClRJyDxTlbOnla3ZDO8XXuZoODdjw2SqI0unMTUKP5HyEsYWXq8J5bGx2VHm5+7
         J3YxJs0ttbK9aPqGS1EL8/BEmaqvtS4KkRZbcs7u+NOs7cMfY3A4unWYidWcKxsnZi
         hUAczsnQcSasg==
Date:   Fri, 7 Dec 2018 08:01:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>
Subject: linux-next: Signed-off-by missing for commit in the sound-asoc tree
Message-ID: <20181207080122.20d3d342@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/glcZ8AYzY_LBswDhEZ.VN0P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/glcZ8AYzY_LBswDhEZ.VN0P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  972fd1f58267 ("ASoC: max9867: Remove useless assignment")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/glcZ8AYzY_LBswDhEZ.VN0P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJjiIACgkQAVBC80lX
0GwSuwgAjrxc87HUf9k0XD+2rGqnCTdMprW3hbVZcO9qANQY4k1uvaNjQ1z4Sm9t
QogVs8aZk8vdZdN1wMCWUua28m/ECS7U4xQmSYzpjGCj3e2PGe2XxpHOwfx8Ilkp
33kBiSDm1MVs/BGOTeWTdwk635p2vNLCYCZE+ECwysJ9wmmvnnmPx9cQFNbwUQMt
rs4eI8mDchB39t1RlOTZcYM3/KepUA/BQWCjjAHYG98UbcNRnMav6BP/Yj6ntB7p
6M5LBlbA6eiTOl5JdoGO4nqN9cBrEeu/xvm5PqnqE5pe25Ji4z8x16q8rVK++DG3
lX+3IsMBpOLdr3Fp7XBXh9MeUn3A4Q==
=daze
-----END PGP SIGNATURE-----

--Sig_/glcZ8AYzY_LBswDhEZ.VN0P--
