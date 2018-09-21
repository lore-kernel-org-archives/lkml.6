Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41859C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FE72154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jXPWyvDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE72154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbeIUGLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:11:04 -0400
Received: from ozlabs.org ([203.11.71.1]:49947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeIUGLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:11:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GZ9c6b0tz9sBJ;
        Fri, 21 Sep 2018 10:24:52 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537489494;
        bh=e6lkNMgSJU9LWVisD4XKHSdM/ZLMRmnQDqGFSltQGgM=;
        h=Date:From:To:Cc:Subject:From;
        b=jXPWyvDcrjnm/CdvsdZb3+jhKGjtf0o96JvPqFnWc8kdeUdVP6/73r6d2baqh0E7g
         siWIGX02hmMnHfNwS8tY0b7FaSGagLF6DfxpLz/JACl8G6znm1TqgLl/lNg1J19r+i
         EK/QHVs5SmMt/zfHYJJa5hJJz0NlL6VnrZnQoLWAScOfeJFcZpakk3Vc7nYP8L8GMe
         TapswL0WHLpIX7kr60d3Udc+ymK8apiLEpLUOuZ7DuwQIFOipE8VAt6VvLP5LL4GzZ
         /ddduxI9BmcX+ge3ua7qllX3iKlXZjv37CE2mUvfn4w1bb5BCoJ5B3aBeNrK2UseNk
         2Bj12FKiXxsHw==
Date:   Fri, 21 Sep 2018 10:24:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180921102452.3dc420eb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oQeBqtk5vkmsq5NRg7ZB/pV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oQeBqtk5vkmsq5NRg7ZB/pV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/batman-adv/main.h

between commit:

  dabeb13eee81 ("batman-adv: Increase version number to 2018.3")

from the net tree and commit:

  138c72efbd5d ("batman-adv: Start new development cycle")

from the net-next tree.

I fixed it up (I used the net-next tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/oQeBqtk5vkmsq5NRg7ZB/pV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukOlQACgkQAVBC80lX
0GygNAf9GTl6GKZUf94KAp77yBer0PyPtBCpvEwjl5omlFQ+q3t2j0MeH+8xSt2d
n9O+E4xjcA01AR4DjWW80V/HS0elKA2Mt3fum5Whzo0pG+zor04Vjc5S6KDH+XXC
lPSfTnFqrQQprPe45UHdJ4A3OifvPDJ4yaBuYZT1SMvED+gnOqFdnOq/cx0bhl6y
CPpCSOlwyVYaOP3Z3duS7DROQ+ZiagQzjKYHpk0usvJI1LMk8sJ1bbiAVgL55qZW
+rkDL0u4rWP54yY3wZhaIZIQ3IazwjonaJTsjPU06gneMKssTAlgNYDisrJcYsUu
Ikysj+n4qtOuF08pMuie1bGzzTEHtg==
=KFIg
-----END PGP SIGNATURE-----

--Sig_/oQeBqtk5vkmsq5NRg7ZB/pV--
