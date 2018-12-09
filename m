Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5EFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E92A2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tPC+B0kV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E92A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLIVAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:00:55 -0500
Received: from ozlabs.org ([203.11.71.1]:43997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeLIVAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:00:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CdsH1QPgz9s4s;
        Mon, 10 Dec 2018 08:00:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544389251;
        bh=xYNPl5F4zY0VoePwhSKBpTqxguORw5tpSff8s4a6Adc=;
        h=Date:From:To:Cc:Subject:From;
        b=tPC+B0kVtaWCmvAAt0s9wuy+zstR+PumM45Zc0TW+0wAsCARHGUH8AAjx61jJ9zLp
         kPuxUpmOMX8io5AHYOW1bm2zM+jfYhNikJwbhMVrfsQnDJxmpduu9Y5ussLtptH2r1
         TdIjgCiDNbvBcuepmRk+fBIVvrFbB1aeJIxOWBU7ZnrGNP2kDyb6N2M4lp1VQU5DF/
         G93CwhXljc9quWgFk+MOgMOsV3oYC8vo/yrucVKqq3qtFj23/9Wb4tcm5EZGC8rYvl
         1DYgqW5fj6b82BaPqHJvIynIpsyHuhBCZ57E9nm5xq9HdRCxaHkbQ1h322mhfaXTRF
         RTtV82cwPbmTg==
Date:   Mon, 10 Dec 2018 08:00:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: Signed-off-by missing for commits in the net-next tree
Message-ID: <20181210080045.0e67ad79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Qeeya3rehqj/w=59b.5LUHp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qeeya3rehqj/w=59b.5LUHp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  dc9d38cec71c ("net: phy: mdio-gpio: Add phy_ignore_ta_mask to platform da=
ta")
  04fa26bab06d ("net: phy: mdio-gpio: Add platform_data support for phy_mas=
k")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Qeeya3rehqj/w=59b.5LUHp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwNgn0ACgkQAVBC80lX
0Gxq1Af/cPsC3t0Ro2i2z01ecDnFX2EMx98RBB2ZIPMdfMOBlvnv/ntGSdtXADWT
qoc5I2AVsFwlDXM0YcCsagpwncc6nW8QFgFV1hw3Wga5zr2n7tKMZc6g96M8wKpa
xZ6fWOkVXWhsirVSvrOjxZBc4LLmPySDZQe6aBvoFAa4L/3/8WNB/TJkDder59Zh
vH6gl635LslQK/60FJyGUvuIpBk835/45htTkdQisK9xkq83rs4HzQ7MHE5k8uWG
53MGVVfJAK/DBYqYHyRvwGRVdcsyiNLZPTiCNksfzNSKkC0QnPSFlEXdSUgAHB8S
yOs8z+XUiRkMUI7MAuF58g6LBlbJwQ==
=XnOT
-----END PGP SIGNATURE-----

--Sig_/Qeeya3rehqj/w=59b.5LUHp--
