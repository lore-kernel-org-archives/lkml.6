Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FF52145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lJiUMaBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FF52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeJQEhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:37:37 -0400
Received: from ozlabs.org ([203.11.71.1]:40619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbeJQEhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:37:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ZS4N6c9Nz9sCT;
        Wed, 17 Oct 2018 07:45:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539722725;
        bh=OkeFkr+aSlxgtJKDydrgrn02R7XWliJaankncE84Ss0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lJiUMaBf25gqxC798Jh1uItSFCq4v5P7jlRdztHfDmRgMEEV4aBZCN8Mz6O6314T9
         DpaJxSEILM4FkEnjgfv1rQZMxs3K8RGWiWw4MKP7KgNz7wqzFU/HXIqYzGd4cMe0Lx
         9m8FfSYdKQ9t2PjFoS0j/r3o7UF3JHDzdohCkbVENND8OTJw2SkMe+DXGO9wYawqEQ
         xDkEl2KWesC2N2tounoSSL7vECO1/LPM4SkcERbXN2jyyfH/IyUgO45HT0mhqMQs9t
         i0AZP1pTX3w3Wr/MpGaZF5x5PoXjJ68NkZz9fX4EIO0iPttwD8m4cpjlAwtkTIR66N
         N+1xI2j/hPwIw==
Date:   Wed, 17 Oct 2018 07:45:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20181017074522.770f8cc1@canb.auug.org.au>
In-Reply-To: <20181016163744.GA29774@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181003103222.6e1655cd@canb.auug.org.au>
        <20181016111712.33f9dc2e@canb.auug.org.au>
        <20181016163744.GA29774@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/J59MMHI/AeR5unet2Ouv8QG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J59MMHI/AeR5unet2Ouv8QG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

On Tue, 16 Oct 2018 09:37:44 -0700 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> I've modified this patch in f2fs tree to use SB_RDONLY.

Thanks for that.

--=20
Cheers,
Stephen Rothwell

--Sig_/J59MMHI/AeR5unet2Ouv8QG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvGTeIACgkQAVBC80lX
0GzusAf/aXRjzeUjPE6Mr329/ug5SMBj+rrX1TqG2dtMvZpkMiV4gCuUbD+mYN5F
WPVLX4PtVDPJ/q4nCOgfSWrdKcp/S5ujw1e0NNOygnJKV93+GoY7IFcZZZebLbDN
ir8dFlneVRDmHzp0RSiKf38nVMkkqqeU70ZJHE1G46fzETKWmbrxRaJ6U/YDB21k
ZXrDDkEdtwRLMKRESm52I8Pi4taonT2MnBExhgmn4gdObrB96K8otHFdWrNu7jkA
HENI8nJNNRWpXRD9BMzPTipwTd2eCN0nBavMYIYpk2ZdC2HMjDYNkcdkllFxVaag
4tlam68QTC9zHiNv1nfN+tDiAQBuBw==
=hJbL
-----END PGP SIGNATURE-----

--Sig_/J59MMHI/AeR5unet2Ouv8QG--
