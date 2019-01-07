Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB67C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9A20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LZ7aPG80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAGDiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:38:12 -0500
Received: from ozlabs.org ([203.11.71.1]:50705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfAGDiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:38:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Y1Lp1H5xz9sCX;
        Mon,  7 Jan 2019 14:38:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546832290;
        bh=pxqMJz02drByj6Ul7OWeQfBjEKD/bH5FtBcwy2yrB/s=;
        h=Date:From:To:Cc:Subject:From;
        b=LZ7aPG80Zek6w8fLNRKWGpzVTerjS/ry3uoYggENaEiOSquxRS+URptt7vrYVwDi5
         qrKkTVJMQUUQHjmhI5d5fn644MQ8sh53QacYJBWeIqtwVFPQ259cJkq3P6s63Zi7qx
         IMxcXHTGsIMbW44GonPQjkUaEXpSLxhgrFXiXgSX3TBSmjgLgWmGRQby9JvIHJ713B
         vBcTaq1GEJkwwkxG6eUCgsq2rgcRGaezHxEPwBq3QbPUUilZJHZtAPHIDjLxZkSq6H
         Nrw4PwKi2tcIsIyXjCIimMtZZuugZnBkggEtMX/eQAyt6w6YgqUCPjiigTZQKeO3Ke
         gF0B2d5rRzzAg==
Date:   Mon, 7 Jan 2019 14:38:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: clean up time
Message-ID: <20190107143809.0e3679a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U/vMgn4oSPRqd.n7R48MDq/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U/vMgn4oSPRqd.n7R48MDq/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Now that v5.0-rc1 is out, it is a good time to clean up your linux-next
included trees with respect to your upstream trees.

Thanks in anticipation.  ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/U/vMgn4oSPRqd.n7R48MDq/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwyyaEACgkQAVBC80lX
0GwwuQf/dfALWQiBmxJb7ocuww/8Rc1xiiobkZBvou/rhOWNufVZXUkaShQ+yybp
6BDsIFgm9vTNQ+n8oqw3/nPfpFgK75lyLILQT5vU1PQEE/+zFTzCk7JU1dPkhMva
79PBMfaZ4rL8F4sONXZEGa3FjOEOgqzjp4xn/5dRriaRnXHdr+lJwN/B8VDyWx7E
heicp7nTrQvn0KpiZlEd+gvKr5BwfnsJ29n9SZlRrKwXW+0IAUUwKLn7b8zQsUkS
uej7F/qlDjAhCq+RS2PjCOof4WcbsuOrglt52P1vMlV7ajA5iOkHsSwoB+5oqtq1
WxSSGx/yR/mJtorxjqEsxb12wYniTg==
=IeD8
-----END PGP SIGNATURE-----

--Sig_/U/vMgn4oSPRqd.n7R48MDq/--
