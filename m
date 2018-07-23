Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B594ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501B620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uc4JUudf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501B620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbeGWMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:39:09 -0400
Received: from ozlabs.org ([203.11.71.1]:49747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388032AbeGWMjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:39:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YzyM54x9z9s1R;
        Mon, 23 Jul 2018 21:38:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532345899;
        bh=kdCmd/5FEqXW/ajJiPl6S5s68OCYFTacE+F1rDZH6T4=;
        h=Date:From:To:Cc:Subject:From;
        b=uc4JUudfTiuR4RNYAokeAlc7FTW7hCU7Ww1kXjx8kL44qqoJeZ1lvvfjaF59KvjOW
         a8dB4W55C6c5y1XfwqmHiiLcvK4Gd/+xi4nrcYooWOiGj1uQuIBoXKcyZj/uoOMvAl
         Of909nTsVpYbbxk3bdKXtv8np4/4wQuZIESIE1zgEmwVJuWseyFXxOdqjr0jM5RSeW
         //V4AxfKLl28FK+fh2hOtTHD+0v/ql9LcuIYhmpWSDmM4yOiXGYu4VeONpAdqipTW7
         HWhSxzqdUtKcWIILwIg29aDPmqx0wkJmCPSOOONrqIfB3gR43gstGWlqUmia7+NqXc
         gphjDcslzrCVQ==
Date:   Mon, 23 Jul 2018 21:38:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: linux-next: Signed-off-by missing for commit in the s390 tree
Message-ID: <20180723213818.0941d58d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kPGe7MnWhCbRzNbsiUkcCBf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kPGe7MnWhCbRzNbsiUkcCBf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5b6f5ee0f97f ("s390 cio: Rewrite trace point in s390_cio_interrupt")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/kPGe7MnWhCbRzNbsiUkcCBf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVvioACgkQAVBC80lX
0GwocQf+PknemI9BjDhL3ItqzOKKn6gKx1oXVXIKautpW9ABGSoag+LTNYlf4/va
P70ExGNNObLmpgSvyLHvZQMMK5VPQ9uqCaib291wfLI6xPvS9+BGY5oa6IHsC+cr
u3aQttVVG87GOd4p7xQRyv4IRmy+ySyhTvAJz0cbS5H64GFYTawLNakZNBnZ4++X
/I0+MauuMhoxm03oWWeHtZ8EpshrXJGkJ6pbyqtgfB+HKI+aPKX6uvPK4zkHl9rN
vLzPe6VYEa2NyVE3JL9ACAEI2n3BZDAC8B0go4oyEeN5jhahLln7esBQHL1jEe0d
3EpjUnru7/i6TZZNOadeBOMohtLYRA==
=DhWe
-----END PGP SIGNATURE-----

--Sig_/kPGe7MnWhCbRzNbsiUkcCBf--
