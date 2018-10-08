Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D7C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF0320645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q6MrS7k5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF0320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJHSRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:17:48 -0400
Received: from ozlabs.org ([203.11.71.1]:44451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeJHSRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:17:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42THc94kNhz9sD2;
        Mon,  8 Oct 2018 22:06:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538996793;
        bh=euR5yh++p7/C8U1i60gc8VRTaIXG09KhmopoyYvfuRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q6MrS7k5dsIqMQkYFACaB0KruD6uNILqrWFfTeT0MbNAR5rS2T3UoqZJegkoA7Jnl
         FFQ5vJ7cc1Kfdt0S+85Z4Hpji+hCzIFUACTfMxNi3lLKOb37n2Nc8TGczWr2l+OLP+
         2vHrNC3PerK7f41w4pz8qVMXKZdlCl/7MRnwJjCqmhYbCe87ZI8RNgbalKa7d+tXZg
         AdiU7EVzXjDlyqrh+RdJF8lxo6kTWgx9MJhH1+xpEhMJzOS9FOx53sDpEdRpicxXyK
         Jn6ge1YscK+sidZlqesyizrKxQ1p1pBob9WEsPmrfn0xvcXxiFEaSHEcGG1lRB3i2y
         ibMYYkx4X5inQ==
Date:   Mon, 8 Oct 2018 22:06:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nand tree
Message-ID: <20181008220632.6b361e3d@canb.auug.org.au>
In-Reply-To: <20181008095334.6850f033@xps13>
References: <20181008113842.4bfc8cf9@canb.auug.org.au>
        <20181008095334.6850f033@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CbdThYiL=mqJa5l+YT9eZdt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CbdThYiL=mqJa5l+YT9eZdt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Mon, 8 Oct 2018 09:53:34 +0200 Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote on Mon, 8 Oct 2018
> 11:38:42 +1100:
>=20
> > Hi Boris, =20
>=20
> Boris is still there but I'm in charge of the NAND tree these days (and
> the one to blame too for this one :) ).

I'll add you as a contact for this tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CbdThYiL=mqJa5l+YT9eZdt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu7OjgACgkQAVBC80lX
0GyNSwf/QLV3RAZ9feCWTXv+Q81A8o9wbFAzI7JjzuxzbA3Dc1TzdTtCWl/lvZyA
rEDHrJBxjYHrTNK8mBDTdsiIsPiTSBng5kptOnyP2VZZoCcFsiaeEebeUwitGMBr
GpmUHFxxDxwMPrF4Lr7i5Toy0UAIzaynj2tLh5bQmzb3Ic8P00bHcGWz39QZtmO4
rqoW9ihZoNTeKpzgMqdIA+R3d0mP8vr31wb0GYfR1vjoMZfTCKPL09h+XRwNPPsT
0+0yhwl0/4fPFYZx79yW2VQskMdQue0Zd9fBRPfu5y15LIgdS2bKcPW3FAUhUzjA
O2XHLU1Mqz1FiHufhIoYd1M4SlCMGA==
=6Oa9
-----END PGP SIGNATURE-----

--Sig_/CbdThYiL=mqJa5l+YT9eZdt--
