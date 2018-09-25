Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63812C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47D7214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jUIWeC5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47D7214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeIZDmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:42:38 -0400
Received: from ozlabs.org ([203.11.71.1]:60385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbeIZDmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:42:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42KZ7355Q2z9s55;
        Wed, 26 Sep 2018 07:33:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537911183;
        bh=Sc5a/qGb4alZEWzFYtZTSPT1WOlcsFgRvmvhV4RkMSg=;
        h=Date:From:To:Cc:Subject:From;
        b=jUIWeC5cWFWGQAmU6uaZLD5Q+DRvVHGlfu/oQS5lmBIuXO2Uq2+NQv1uSB2uvuxHZ
         aszTBZK1/85swqDs4h+Xvoom/bDtE5L2IRmPe9hJCpZArmDXVXxP0lxkdyqnZEMqVh
         l8NrNS8wTK3CwwmuUKk/p+gQ6Dzo2xSerKLJZa2NtuxqRBY/IdqqSBUAgxW7CJikNM
         nPCNvOAEdD84GG16bvoObi6OgljFqy86ZuJ057lNGjTuhQePce9KReXSlcXrRu5Iq4
         vD2dyBaOBckX3qdtbQ/zq5BtONOf3iFR7678fC6Xeu59B0Q1aNAQWE9cs2t3MQEPlj
         5rYV16Bm2VXNg==
Date:   Wed, 26 Sep 2018 07:32:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the dma-mapping
 tree
Message-ID: <20180926073246.429ff97e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.WOad2merToPLt39eu4F6k4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.WOad2merToPLt39eu4F6k4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Commit

  e3b8f15ec90d ("Revert "dma-mapping: clear dev->dma_ops in arch_teardown_d=
ma_ops"")

is missing Signed-off-bys from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.WOad2merToPLt39eu4F6k4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluqqX4ACgkQAVBC80lX
0GyGwgf7BeLXYooVDqAkNVoQ0Jd3MMe5ybQ9ZdeAknFYNR7RT+0uTaoAXLhQwISJ
qEFVx36Jg0+Cv78oAyGOeCnEo2LivMQV5kKpZE6+ZZLZf0Eh/ME6qXFlDR4hqUGL
OQ7N4oBdoxF8O5zV7E3GO6zzx1vvhhSidwwoJacAUy6zgI1kAevv6XDrRgQ5KOc5
X5lJ5ynjJRkVAFU0Fa5UeiZDFBeOABcUTdW5zutjqiO6X+BDZu3prs35N4iRS9B5
5fw4Ih3DE2YOAwd5IlFLGICg0Y/V5fEpOxJd1tpJykjWxPvh6gni9oLM1A0s0w9m
GSdxB/PjZxgr+otzJSfy7bDXD6Lw2g==
=h9ZJ
-----END PGP SIGNATURE-----

--Sig_/.WOad2merToPLt39eu4F6k4--
