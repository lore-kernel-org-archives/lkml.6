Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5876DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDA6208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Jz1mayNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDA6208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJBGPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:15:09 -0400
Received: from ozlabs.org ([203.11.71.1]:47393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeJBGPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:15:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PJXt1Qfjz9s7T;
        Tue,  2 Oct 2018 09:34:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538436894;
        bh=6WwuaDt0m2Fs5mbF89e+2q3TA5gqy53YytnRABQmt80=;
        h=Date:From:To:Cc:Subject:From;
        b=Jz1mayNChKst44+qy78SmV02KPJydW/S2Rc/8MfYLdLT/CJnpy+bgu91A3mOLVobz
         pEtegr4TYpo3haa5KlBG6XnUCHz3EVeLyMGv34pyia85rTikn+fXy5H++DzgEO5dYJ
         bLl4rXihrvBk+pCt5hQzlMubijjlTj4YjcPKyKwmOO/IzLfZ9zEZQHZ4eho/ElU93N
         a2jQgX5WIk/DTU3TM9bCvbtqZ4dbXiiVRhlPWiiVXZY5dKxfUgt0kLtRZ9V7sUotF1
         Zgvetw5PbDvOfBih402oAgKB7xgZah30dI+q4/aijhSdFgfKwnh05finFCQr+SbTq/
         alOILM4vlx8iQ==
Date:   Tue, 2 Oct 2018 09:34:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Gavi Teitz <gavi@mellanox.com>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20181002093436.0e43f32b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Tj./WHNVTNeDWzK3s0eS0p1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tj./WHNVTNeDWzK3s0eS0p1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f128f138cc40 ("net/mlx5e: Add ethtool control of ring params to VF repres=
entors")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tj./WHNVTNeDWzK3s0eS0p1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluyrwwACgkQAVBC80lX
0GyZ8QgAll81pWHUYHSxW4tN2nSoWJJQC58ray2ufKjjg7htOwTffolUzGYF9hJW
LrYm5e0okCCg15VP1wAxmY2NXBXCs3onCcAqPXLJrp86a1VRpBH4Vlxp+K7FPFq2
C6oscdNctYi/7uebk7Yp/gUc4WgyiODOvXu1u9AhvmHTz1r9p2CY8ws2QucnS4aZ
tDxXwVCooYwt0wjUagI6iFeMHEF1mGXujEmTNsGH1ds8wtE71Ldugf4PI1cT9OWS
z+RCua5cFQlT46ZfvlvhU8iNp6Ght8E5DFw8kwuLXSETkFjp5K8+HukNZI6fyvHN
4YhFwA2uW8HsduUYUbQ/yCEdBDaJ/g==
=2vY8
-----END PGP SIGNATURE-----

--Sig_/Tj./WHNVTNeDWzK3s0eS0p1--
