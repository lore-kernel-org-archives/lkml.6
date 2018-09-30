Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60595C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050F82089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fU0ScLIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050F82089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI3Hez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 03:34:55 -0400
Received: from ozlabs.org ([203.11.71.1]:44487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeI3Hez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 03:34:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42N6cs6zbqz9s4s;
        Sun, 30 Sep 2018 11:04:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538269454;
        bh=ToFbGqC4fdzyJsaPYfwwEMyPHIsUN3RcEamhMxzoIaQ=;
        h=Date:From:To:Cc:Subject:From;
        b=fU0ScLIWDCeOZtJHYIYQWrY7oqmeKXBDtOkUdyMotgoK3bNmGH/TpjZiEuaNzkxLL
         Cyr0hQgt/TeURCsMJkmHOPTKBD1/vqtL1M2rO9h4VAT9ySaXHZGWtvgxjziR8FRrPD
         gk3S8IvqV/SQPAHLECedjJVNrM282M5baiH6kjZQ8VZ5VNPiUtah5Hb2yoNcKzMzQE
         sDWBGo1fAis+ivp1CMHQGmrMCViAPyGlgprgHW5RfaCkYT21ctaJHvLVJKj9nIWGbU
         R8G5l7cSIfL0Nu/oxRyY6BotPHJ9HHVjUwDU/xDq5/KtDdOhglY5XpyFvopw1hiypd
         dZkwSRKmxYsaw==
Date:   Sun, 30 Sep 2018 11:04:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the net tree
Message-ID: <20180930110412.3ef0bb93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eAjzToyXDC7N7q8GunleTZx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eAjzToyXDC7N7q8GunleTZx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  5f672090e44f ("qed: Fix shmem structure inconsistency between driver and =
the mfw.")
  ce7d17d6c607 ("MAINTAINERS: change bridge maintainers")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/eAjzToyXDC7N7q8GunleTZx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluwIQwACgkQAVBC80lX
0GzIBwf+OSvm53GA1VUqY1T5QClt2v/nkny2kxOVxemt52faQr/u5hUC3mN/iwRi
sUids3cO1spoXVnflaheQDzwpv6VN7pRd1TD5D/f4b7lU7mdwuRkTlajXn7SyPn/
ottSEna0rb6j+vSOxtnCFOW07GsXh7BqYVlv+MtvikTKZjB7IgOxCTVo/t9WcufX
TSM4pq3h43XjitgnP+FrFVVtrVScT98AV55N4MIpm4Jun/px0g1YqJZOV10m0mkG
LiI8liTKxI/xJr2lGkuQdZkZr9mu057Zp/1SuGYioZuqhIk8ISwDlkHnt5NiW5r4
97qbAtCP6HTrujwupIoh4VHpRlrmrw==
=yo2+
-----END PGP SIGNATURE-----

--Sig_/eAjzToyXDC7N7q8GunleTZx--
