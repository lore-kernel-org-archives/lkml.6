Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F13C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E456B20665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bltNNK91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBWOFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 09:05:16 -0500
Received: from ozlabs.org ([203.11.71.1]:46091 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWOFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 09:05:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 44692d2nflz9s71;
        Sun, 24 Feb 2019 01:05:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550930713;
        bh=55U9hCGQBqE3wTnIhmc1OpiXezvNvyppGido/k29iLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bltNNK91zomwZMvh4oTLVmpkVhxA+TH2wb1PSbpyLTSKm2P2XLNW+tCYTWEXqwyeW
         RAT87xiApCW/cWf0XndhUhxcM8qfEqSxilQqY5MYi6AYPMSzemPJNrCtQoCLOKvy6f
         I6U+o1EgFYiRNF6my2xCiK63u25U7Se18wD0ROQxR4svzYEmyRuEfZg29NAx4JXxTB
         s5pKUtE5KRcoDoG6j088MebGbGGg/C4/UaCg6FmJ3kGtZcvu7MT/rcyQrUWHTS0wGB
         XPWRbzMiawuGgpSNN8g5lW0BHCGQYtghuW4ovwvyKX9mFHOaeBFgCtCemouob4zcKN
         eq2IUto3SJq8Q==
Date:   Sun, 24 Feb 2019 01:05:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20190224010511.74f25272@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ioXh4QPO9VkP60je8D=8ArN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ioXh4QPO9VkP60je8D=8ArN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f68e7927212f ("Revert "powerpc/book3s32: Reorder _PAGE_XXX flags to simpl=
ify TLB handling"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/ioXh4QPO9VkP60je8D=8ArN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxxUxcACgkQAVBC80lX
0Gxx5Qf7BnKPha2u1xMJBx5xoklk9av9LFuDOse22ee8m4nznWE7QxBicgMNy6Yp
OoKA+h31QqtB/QRbd13uJoAaO3oP4ou+IpXfKao3tNolnP3SlYhQ8f4SEeLH4FlZ
9RUC9Ej3iBCyBfx3Xr64vkUp3U9BaCuIxyPl1/c8NBAd9qAZb2zBZyhz8HpIEEVv
arZ4m6TkhG+TaoxVXsnisbT4Ru6J1QN8j+mN4nHsjhy37uGPKNGKR1rEG7NK4pYE
0zNCQrLGGGcWTHEdh4L+gTOGqLxeLfEjYg6FtfVJ7Ubj1MMtWWxBUmVFYlPfD62+
rjx4cH8MAUb4SXqyd4iyXHcRlwE2JQ==
=TZV/
-----END PGP SIGNATURE-----

--Sig_/ioXh4QPO9VkP60je8D=8ArN--
