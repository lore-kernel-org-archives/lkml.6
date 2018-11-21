Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C81B21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FZ/UEjc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C81B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKUPho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:37:44 -0500
Received: from ozlabs.org ([203.11.71.1]:58929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbeKUPho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:37:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4309VW05rXz9s3x;
        Wed, 21 Nov 2018 16:04:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542776691;
        bh=RhSib/i5CvV0/UyYMLrW4qfVL77kjJA2HIwjnbjk04o=;
        h=Date:From:To:Cc:Subject:From;
        b=FZ/UEjc9/Wgz8u9NLmqSUKnKINQcIu8tUQYppxQqwAq1PB6/5pVmaTQO1oHhzYFgm
         5tzb912pHbrFFakgu9Vcc9ZfEXgvztdjUvyjXCLsdYZWQvRn20YUTihZJqw8BQjPxp
         O19aigKsZzbGzVQkEfh0luQWxPz33E5cJYJlvMevtTDNUT/HUwKJD6DjfWy7E+XygU
         LyFKrd2Rwv6CyuZMejAgtUEcRZVNw1UIfTOuHVLW2VUhzaV8IenBj8tva/CnvyAe34
         hjIM613EBAZOBY1JsbItnFvII4fOB8tzh2h+xCZLEH3cPcRzmwti3GZNN0dw07v2fd
         eW/prTzOFCeZA==
Date:   Wed, 21 Nov 2018 16:04:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20181121160450.2219ff48@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3zwyDAAUwvx0DrHVnHqGqpn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3zwyDAAUwvx0DrHVnHqGqpn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f2cbd4852820 ("net/sched: act_police: fix race condition on state variabl=
es")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3zwyDAAUwvx0DrHVnHqGqpn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv053IACgkQAVBC80lX
0GzNYwf/XyWo7trJfwQOvs6VV4q3XyIAZz5S08nWO/VOkU0HV/8pwJVqo+M50eqz
OxF3X1SNoO0kOAPF78T6+RvUblBAZF8C29qMKJ3/9iKZYE9VWuW3c91oStaEOerC
2y6CMoTLHqdJpeNetTG/MFZGOUGzMwJ8BkZjGMQv0lFIwkUDPrQY29K4tKBqVl9D
eyNvHRU0uOuDMaBHgnZeaQkZAAYOc3wdKKXGkX3jOxMAhwY8vN4ImcawxFJI6Osl
JvhADXcJFjeJRqBXVYUzajBUH1mx42r91FMubMLEo4Wc0X6yhXAzy2mEgimzUasz
VU32i6o6tbevAIkUQeKhKqFq0RY/3g==
=vo2Y
-----END PGP SIGNATURE-----

--Sig_/3zwyDAAUwvx0DrHVnHqGqpn--
