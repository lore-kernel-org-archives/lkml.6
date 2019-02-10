Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217DC282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5404421736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E3WLjB06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBJUOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:14:53 -0500
Received: from ozlabs.org ([203.11.71.1]:60139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfBJUOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:14:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yKs56L7nz9sBZ;
        Mon, 11 Feb 2019 07:14:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549829690;
        bh=TAFYy5mOS/SqUhawxplg2GfDPHXhkeeu68IlmQPmGsk=;
        h=Date:From:To:Cc:Subject:From;
        b=E3WLjB06FmHO9tYN6lhQ3Hr+CdPc4MQKDUoIcViN1HBTcgO5xUjU5Ta5LgqmC3qKx
         39MQlrfEptWXb3LI3bmg43wQy6a9tE4EiPWxS5bqgDc9sTpnyTc7cvj/xKATDDVj3S
         tQ1aZEJH7hsG40Cfh3QhkvIWXRGb4UrzuOiafGF8sP71ikPAtFVdfwfDLWpow4As2C
         NAlIvOb3R5KvSiq5y8IF+UEowSJ1UdHzn02yD0RiF+WxG26I6jSKZeWfphgRoRN468
         UurQUgtVFBDfjL58AvY7IUyMaUOviFY4dX78RrYzXcGhHkaa/q4gi+gY9rwcAsojmk
         fy6FwHswTSDgA==
Date:   Mon, 11 Feb 2019 07:14:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190211071442.153e158d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JuyT=nG_xTwOHADdz3gBgWj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JuyT=nG_xTwOHADdz3gBgWj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ccc8ca9b90ac ("net/smc: fix byte_order for rx_curs_confirmed")

Fixes tag

  Fixes: b8649efad879 ("net/smc: fix sender_free computation") (net-tree)

has these problem(s):

  - The trailing '(net-tree)' is unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/JuyT=nG_xTwOHADdz3gBgWj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxghjIACgkQAVBC80lX
0GwyXwf+POnzrOJWYp6o9ChWPy+nupuh/WVQ3ZoBfFWas4arHyu9HGjXTP/wSo8w
KBQvgTwANygKb+zciao/0ACZtCC5qmZJTOQXAeo/vFn0gPnaJ3DHkN8Z5GSGBXvL
OCk/LN+bQoHm6I1QFc+xlSye9d26S/o6jA/RPun4l7jPuu0Hd5uWdXef/KdkSWME
6W7fM+BqK1nDvSxnaTOUDIULsTJPepShZi3vMFKD5ytzt8IT+qZ/RAYlbPYc7lVk
rISKsO8cMdwYlzmtB5ocaYd83RKHMtj1fM/g9movwbrWQn39wpH0+KvAgSh5ZVNh
9yWPoXa7HOa2M9g5o7VBD8/40MYHLg==
=/Jb8
-----END PGP SIGNATURE-----

--Sig_/JuyT=nG_xTwOHADdz3gBgWj--
