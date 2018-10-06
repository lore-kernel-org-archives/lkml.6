Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644CC00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB6D21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rcet8jnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB6D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeJFJAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:00:17 -0400
Received: from ozlabs.org ([203.11.71.1]:45183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeJFJAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:00:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42RqY62f5yz9s47;
        Sat,  6 Oct 2018 11:58:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538791130;
        bh=OJ8d6ppbpeJuICCwjAdtf2opOtHHCbzb/6ZXDMswWFU=;
        h=Date:From:To:Cc:Subject:From;
        b=rcet8jnUW+IwrkcYlzONXBStAA7gm6FlmCYgo4V0q2pvxDQ2+yHHh4mkVcVmrGECd
         yAUAOonfzinJnKt1KJvGLP8XdboleJj1pZ6vd1Da4vMT9nVCAqg0eRRYDdeInRziew
         slFwVTTlBxLm/XJBv4iqH82MN5x3LyfgbZDslTgUJdxb7f1uEWiQ4Br4S+tf10SDJv
         yZ8/BcLd3/3WPtwQmszpJoWMRfOAaeZTqJ5vD7KxRp60w6MumRcSo1bEDAGautccBh
         O+AmEnZEiEmLvDBOGaV1h6X48drQ2uAuhLKKsv0sZkwHW4ZKCCrowomTNcyErnGZhL
         5XJGZjd5EpJYw==
Date:   Sat, 6 Oct 2018 11:58:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the integrity tree
Message-ID: <20181006115838.62f7712b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/r9E7lvhtk3xj1/LMAf2fyb5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r9E7lvhtk3xj1/LMAf2fyb5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3dcee2d9c069 ("ima: fix showing large 'violations' or 'runtime_measuremen=
ts_count'")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/r9E7lvhtk3xj1/LMAf2fyb5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu4Fs4ACgkQAVBC80lX
0GwgsAf+JwtcC+WFAqzE2yqJB0O703IR8Iyz9QGT0JMWQm2ZsDj+vXAs3Nor/aOE
zW5iRv59LhMP5+UFqH/mpQ+BL2GH1hD0xc+/UWKIv82srZDj3lxL6VuFpe1Z1OOS
swfoxGffqxw664rcXL4cVsCjn+CEyK8HipiV/4rCVIuF6XP9vHz3dbdL1JDnbWk+
f5HgxChREDnsOTrqHFsXhdJde/ihbhaZmE5Exrjv+Pa69QyGpgDbG26nl/BC/Vng
feGybouwO0NHmYYx5gP1r0bOwllAdHzw0ZVOnJrWVWy78NMruHBFOX48LEeMjr9P
AbxXv4v+r32OUdHmQKG6Faes9WMWBg==
=X+mI
-----END PGP SIGNATURE-----

--Sig_/r9E7lvhtk3xj1/LMAf2fyb5--
