Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3621BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BAA20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HBwNbWFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BAA20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeICB6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:58:05 -0400
Received: from ozlabs.org ([203.11.71.1]:56845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeICB6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:58:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 423RNf6607z9s2P;
        Mon,  3 Sep 2018 07:40:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535924451;
        bh=rvytEGEJsLNfTAfFS0TFnyu/9ZF/R0quNXVwhUUGrv8=;
        h=Date:From:To:Cc:Subject:From;
        b=HBwNbWFvZU8x+ThI9oc9kQOblIIwTLJFiOQIsJaJxI7Pny77FmqOmRhWw/i+PGpii
         OiIPnEIsdGUV3csE6svIARX77h6pUfAntbC4RzGsMt1L3a6LssRsaPBE+UQVBIORTS
         OnqT/9YCPXhC/jgI8AyWwXiM4ryUDjBOSAkbA00bXb059YYJe2SfC1p/fdymMSysHG
         jNo8kUyGKqR3boSzwYGAQnu02fn07ZusOlNLZCnAkdY+Ts3eSyPZpk2kJvxbMKlYxw
         cejHN/ZbXg2KGTZQ+WyqISF3qROekR3JWP4rKmtT9nSSBET/MGvJSmagcLSnHJEaTw
         ZNsCOse32aUSA==
Date:   Mon, 3 Sep 2018 07:40:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vakul Garg <vakul.garg@nxp.com>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20180903074043.65038277@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RvFjk9o6Y5EqMMaNUVGJsO4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RvFjk9o6Y5EqMMaNUVGJsO4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning across mul=
tiple records")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/RvFjk9o6Y5EqMMaNUVGJsO4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluMWNsACgkQAVBC80lX
0GzY0wgAjEQ9SimnqiEx5Lt/BkKO51jqjUljiwoaU7u6CcpkX6YHSjsWCG9ORyv/
wGR/INMsZaL4yW1i181CUdXzkagOeXqcEy9ln3mWAWB4kQOe50dIm0eOSq6Rw9/+
NuyDJDXWsaB/J/wGRnTgjyHLjvPCW+AeNfrHCLu//s2jA7y0/WbxXvfrRnL2thGx
UrntHdVf+A2CMTvQzFVkevEEyhmUB6k1H3q89xKIBqdZKD/wvx9I7e2cZP3DrJlJ
UYMRwDw761Kl7AzNZeXJgsFVdltnWHyBMV09kFsozKw8eloFSiTV2HKSi33e5GL8
GG0/tiFiTNHcbiVHeo7wPnTIcUhlJg==
=AYBW
-----END PGP SIGNATURE-----

--Sig_/RvFjk9o6Y5EqMMaNUVGJsO4--
