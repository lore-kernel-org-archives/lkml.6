Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BBAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2966A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K8tcjISN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2966A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLCUlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:41:08 -0500
Received: from ozlabs.org ([203.11.71.1]:59011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCUlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:41:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437xjF4mzYz9s8J;
        Tue,  4 Dec 2018 07:41:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543869665;
        bh=mbYZmNMz3kAzhPnsKbEpoJXV7LzN8biWMBuPhjMVDgU=;
        h=Date:From:To:Cc:Subject:From;
        b=K8tcjISNZLJZuy0YuWT5aj4wxhO6dbFVEFoefaGaEnG0ntJJIhYg1DeI+5VTB7ATK
         oqAzJwAUJnXOqLzcEby2/5fVI2owoBTWiduapWTv3H4SxTux28tgFzOw6/WjbRC0Gp
         S123BNABEOFfbxJ99z2JCaGPDt9Ms7/9Ye/vEk9rZpCsdfXwclffgwWV73GHFlGva+
         S4iyBFsuyaLrE/QLJJ43kplLBuOlVn0sn+BaXFEnkC56y3MpkEBziGvJfGNGRZd/yi
         XT5HiTYSgEIEeHUZDthgZaO/ntPHOsZZnJlIuub1bMM19mauUNNtMGb8+ttPGM+U73
         XlqmW7RJUpNhQ==
Date:   Tue, 4 Dec 2018 07:40:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: error when trying to fetch the mediatek tree
Message-ID: <20181204074058.3bd8e572@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ezLLCIWa3MfzDzcqZ4afkKy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ezLLCIWa3MfzDzcqZ4afkKy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

Fetching the mediatek tree
(git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
branch for-next) produces this error:

fatal: Couldn't find remote ref refs/heads/for-next

--=20
Cheers,
Stephen Rothwell

--Sig_/ezLLCIWa3MfzDzcqZ4afkKy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwFlNoACgkQAVBC80lX
0Gx0vgf/QuTnptJy9m6Wj46wIWpZLF2Au7OtS0cVRi7AsfKdu+6/GdEBeDqiFQlE
1ekWrHXW4u5LDgtSOTPYzPTQWWdGJyFAO24PAxyZOcpd57epY2+8z0IlatFBJc+Q
LrOELk9FGE+PgQufplT2YOKURN2nstDnnuj7JIrGk9kwUGJ7eUSxuLybseXKvilt
LsL849dQZENSMtUDhAa69qS2JihfoX/shoIXdhmXitULoWw1xmWomcEa2nqSVxQj
BNK4/3OeK7+ldJPQKRzaeQMOvUkbM6Je78PBsZPQ5WraozwWPOjpGmGImMZ8HrrT
boHtzs66JQnVJEwV587gxca1dGxkrQ==
=H+Iz
-----END PGP SIGNATURE-----

--Sig_/ezLLCIWa3MfzDzcqZ4afkKy--
