Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BFF20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eekMzXWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfAOWZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:25:38 -0500
Received: from ozlabs.org ([203.11.71.1]:43037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfAOWZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:25:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fPzz3nvlz9sBQ;
        Wed, 16 Jan 2019 09:25:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547591135;
        bh=Qrh02D/1S0xNoyOe6lWJ1PeIpOs5zjH2ou0SURGrpv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eekMzXWGqiNHbcXcFCFhR6S8tUog2z1HrmeLd/kA9aKnmnGUO6VyKRn3rr6Ava6FH
         7mui7RLWUHVxZicoxLZQuDWKAGdOHqWoMPeledG4s1hXfNdILkVUvpUtBZsQm1GmJj
         yxAgr0oX83fRraProRloIrGLst6HR0QOvxUVJfeBiIL8YRQVUqUUuXpPmzOl5z3CTs
         wgHNlAvCBli7JzhF3DIUlNwfg3FpwJ6/NVVAkjkIlOlUsReFjFjVuYSrpXQ7sLwLOu
         Xw8N2HGnT3bUGWDKbhV7o0Ah+IlbnxKkzy/7+euu+NkWLBjQKM6hO1ooANRN8AX8rp
         9/cBRutmQVkig==
Date:   Wed, 16 Jan 2019 09:25:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adfs: mark expected switch fall-throughs
Message-ID: <20190116092512.42c0ac0a@canb.auug.org.au>
In-Reply-To: <20190114203507.GA17953@embeddedor>
References: <20190114203507.GA17953@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6a_8a+Xy_oP4RY/8BuDV_ll"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6a_8a+Xy_oP4RY/8BuDV_ll
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Mon, 14 Jan 2019 14:35:07 -0600 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/adfs/dir_f.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Added to my fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/6a_8a+Xy_oP4RY/8BuDV_ll
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+XcgACgkQAVBC80lX
0GxtrQgAk1crMFkCtqyJWYWa946hbDk4A3Ope1A+CkuOEOVjpGM5VlyXxbGQhQI+
H6+da5dZsV/D02Ufyc5vGAJG4CpcoTVa0933eD6PbDTlI/YWLZiGdYWPoAVfkeOe
qlJL0ERrdqUKtrVkvzMRtHhqy2NI8QEhkiAouNbcb5VkL4jY51kVI0cTLnUv+GBg
oBP26xk+ptLIFdNFrUvPIOrSlFJirwVNllsJrfU3QNsZhEqsq+Sa204Y8MPBZo/H
qop75KGeDzHhqHfrMDty+HgW1KjbjoC9lzFTuhQdpqPtIGVJOC9AUJL0cJsFu/wV
Gb/tonDwZoTWuHpZkx932B47uEAetw==
=Cl5b
-----END PGP SIGNATURE-----

--Sig_/6a_8a+Xy_oP4RY/8BuDV_ll--
