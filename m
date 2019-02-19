Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F15621738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nfaELQ23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfBSWbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:31:41 -0500
Received: from ozlabs.org ([203.11.71.1]:42287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfBSWbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:31:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443wSn6pjKz9sDn;
        Wed, 20 Feb 2019 09:31:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550615498;
        bh=cP+yN/7As/EDBarCQljclPeEBBkY+daLzbK7jA6BC9s=;
        h=Date:From:To:Cc:Subject:From;
        b=nfaELQ2339AE1iel//cW/EAvLVok6mAJYD2IVboAtI/40LI4Q4m1Lc06CFMuTT3YS
         C/LFi3kCU/tcvVXagESDcAsN4u2WVGbrYUSF1OVqdrffxU3Ox5QgPyb1niKKeuIT/t
         sJOKdPWLH2MjG/mAcOtlbmZ+i5tr70qbU1VDS0ZhtZBgs+qyNdbjpjrQ3s7K8tNna/
         3SivUmkB57JcR7Tx1z5IxvXmwrlmAhvZmXexDfe97ebI0L6OApnuVP/vY/L+4WZnkd
         DPUxlSzoOz75op3Om6JLxOi3X2H3V0Y26CHFYOtwkaTTxUHilI2YJIT4ag7XdAZGl3
         wDzMh4A+hzk4Q==
Date:   Wed, 20 Feb 2019 09:31:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220093136.73779781@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PeFdU3HN7vduMNJqwUmiEU3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PeFdU3HN7vduMNJqwUmiEU3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a968b5e9d587 ("net: dsa: qca8k: Enable delay for RGMII_ID mode")

Fixes tag

  Fixes: 40269aa9f40a ("net: dsa: qca8k: disable delay for RGMII mode")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  Fixes: 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/PeFdU3HN7vduMNJqwUmiEU3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsg8gACgkQAVBC80lX
0GymcQgAobz4jyG0c9hquVzRF0ipROjjFvYsC85cwcNrr0KvArwZY3n39LBMuq9M
5h/40Ws53z+uM27ZnYo5WP6tne4mWMs/kzIwJMwzNobV5dV6FlOtE6Qvv8QSHD9V
1BxiYc/Dq6kLw3EBqUtlcKjx748NqKf8LKSBFqX886FXDMTFC+L3EOlzJcKK7lFV
l9CwLhSWwxmecKMIeRMCB8mM+T8/A4tw3ET0mBFHfJOMiPokf5fwNp+K/ItGN8Iy
LceNVO+JEgha+cAQx7ZFNgvikVxV+3izAKN+aY8VBJimzeKtp55wMkLbMklDFSIf
5gNQFNL9zXyxI7vAUCv96h3dEXQNiQ==
=NX/A
-----END PGP SIGNATURE-----

--Sig_/PeFdU3HN7vduMNJqwUmiEU3--
