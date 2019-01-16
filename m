Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FED20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EJEIIEg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfAPVGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:06:22 -0500
Received: from ozlabs.org ([203.11.71.1]:51565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfAPVGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:06:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43g0B30sh2z9sBn;
        Thu, 17 Jan 2019 08:06:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547672779;
        bh=tMB9JgI84M6tc90TLavsYlKaIcGrz7gDu81kxIpyebw=;
        h=Date:From:To:Cc:Subject:From;
        b=EJEIIEg1E1RLU9Dfn5w6YAiYzIX7fAi4lFSixpBMMzbEfaM1pnHdhvJeCZDYYXTuF
         SeFPS98wolSF6N+zODbs0clEoZjNRcEHRccZFjM2gLwM9MUZlgMXn4J69skhLEJ4v3
         FAULmG+hcV/NGm7YWOvwwGqZ8gF8XkAwAKNuYgbFjJWG0J3h/FLe5D3wOyTWrxx3S7
         gbjSKivv3Ldlb8d6LLGIrYyFTn6Ut6FzcYkRZSErdcwYkfoBZX81gOMPdgxL7X9zHl
         SCc1LEOg8w/0iDBX+6kHCtqEISUPvMuzM4WfrDEdvhoN6lJ7VOJpAFajbUB8b8iMig
         ZuTq+6ayQROGQ==
Date:   Thu, 17 Jan 2019 08:06:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lepton Wu <ytht.net@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20190117080619.5a632a41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/htqkIb3uUy2yoYZgpWZV39E"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/htqkIb3uUy2yoYZgpWZV39E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a22d3251423f ("Fix ERROR:do not initialise statics to 0 in af_vsock.c")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/htqkIb3uUy2yoYZgpWZV39E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw/nMsACgkQAVBC80lX
0Gx9igf+Mamr/zsI+XWBRZ6R7+k2fBz/jA8H8GG0QPqvbXVApVLf/kHReC8ILRLG
NjXleC0ZaHyhSXmUyRrBxbjxpnPx0qfbqxxaofTTb/Q1RAfq5bNnRXSTD5UGt49H
M9IetCep8qyFObC7lG3fLwYN4eTlPJxFsWZWw4g9a/SqRyPnkfE1lfqafKiLNo+k
WZnVkNu+RqqsFKRp9TDK+wr/uZNZ/qCg6l6UpWH607pV9swOJ1jc6MJzcilU9UYK
0XsbuOBltV6tbpi5iQNXzK6yCrzns8XHu9JGUS1c5eN9sHat3PbGzx48ZnrA0HIg
vBrSIWoU2u9FqXpoBrM0j1MjoNPNEw==
=u/kX
-----END PGP SIGNATURE-----

--Sig_/htqkIb3uUy2yoYZgpWZV39E--
