Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF01ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD8A20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EtCpcf/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD8A20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbeGVWxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:53:17 -0400
Received: from ozlabs.org ([203.11.71.1]:41485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbeGVWxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:53:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YdhT4Ps9z9s3q;
        Mon, 23 Jul 2018 07:55:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532296508;
        bh=jk9XO8PljcfkzSE+4PfjZWbSxiNLXEVgDLQxL48vsIU=;
        h=Date:From:To:Cc:Subject:From;
        b=EtCpcf/vBGxv1ugCMsSdYUIN4yiyI3BnnM2eyu6y8XFUmHb2Q0R9f10pwNpP1feuc
         bc2Fpk+MBJBHc6fqsQJzVQnhc4JAb/0wuRKMV/ilLI4eb98PC6Y1sZol4JjBYUBPvx
         rphl36q1vRiT1Jlhdc+TvuSjAvoCvyKwwvIwny90gUTiPGj4IJgZLRZ6Tbom9R+Ce/
         0ilQn2gQe9HrKZ0hDV1b2FwtwAEjUV3pjgfFikTqDL2zYnnF4vsctIfjPV/N84B3+h
         NWLvCE2Qm1mc8u4pwukejxtLDUO1/FJ4+xddBi+0U8cQwnYFKd69P29ZQLLlDNGuxV
         uvnpzLQtS+rLA==
Date:   Mon, 23 Jul 2018 07:54:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20180723075458.12da7c0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+z1LtcPj73z..IBdfbM+8C4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+z1LtcPj73z..IBdfbM+8C4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6fffacb30349 ("x86/alternatives, jumplabel: Use text_poke_early() before =
mm_init()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/+z1LtcPj73z..IBdfbM+8C4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltU/TIACgkQAVBC80lX
0Gzjygf9HDSnSEPFS5OnlKxk5ScExexo4ovH3LVSZ9m1DRtEy3J6HQA090VYVpvZ
d1HdzlyffHOHAULqAKmfjkqv9iQdNRIBi9TiynodMx2NzXFTMX8uo5ap6Euaps39
e0ljZqJ0lGcSi+ULjkz2VYP5isPhjLTFTq5iE9Oy3U6izWdzEWwOFqstaMaPnhff
fNYxvKjS2FJZasq+QBoL1ZXRRt/vKZYvvpcBlZP9CHs3tYCArMxPMvnsmpz2XMRU
U3iHt/3CfqkGeN0SK5vr8+Zq4LLjuIADolsqnt41MOre+SkE613GX2k5LNaC8E6l
KvTi/n/BGcKWV1iHv2NEmStxhVXxIA==
=RVXp
-----END PGP SIGNATURE-----

--Sig_/+z1LtcPj73z..IBdfbM+8C4--
