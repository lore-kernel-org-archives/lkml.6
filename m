Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7203FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBB2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I0SYMCax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBBB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeLECKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:10:54 -0500
Received: from ozlabs.org ([203.11.71.1]:57895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeLECKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:10:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438hzG6nqpz9s6w;
        Wed,  5 Dec 2018 13:10:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543975851;
        bh=ka//mFHanEEku5Tdz9+82pLkMl7qRpMjJ2fezgsmX9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I0SYMCax55eZ15jBX5lcQ//Rh3AVS4w75nhcL2IYH2oamspFrPi3qAf66Mf6Wzm6C
         ge5fZK1VuVucF0a0fLvYvC9qkL8JMfO0zCpWHr/chN0xN6qe4Pb0uPYB+Bs2a32LZ+
         PNJ1j4cs6MgjIwCEdugXl/SZwwqrOnArgI+GYGVFlPOMVH8mGJNe6tBLRvhIOq2q1y
         ACIVKegqTEtDzbWnHVCU1X/Nv1KWsf4xaqe2t0awkdkzdRtnc+bvUX+xLRF+kZKiaE
         bIy35OI5mX7kAW0oM+ESNsPoXU0DREqR3gybpz5bnxgqKMcVDGFTA7Kw0yEtgJCTY9
         /70GWaxNgTrGQ==
Date:   Wed, 5 Dec 2018 13:10:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the rdma
 tree
Message-ID: <20181205131050.40ab2924@canb.auug.org.au>
In-Reply-To: <a15a43d96bdbfc7201df2ea00e813fb4c0a323a1.camel@redhat.com>
References: <20181205120706.294b9422@canb.auug.org.au>
        <a15a43d96bdbfc7201df2ea00e813fb4c0a323a1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vG645c4b6W9KXzOY2s6rz7x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vG645c4b6W9KXzOY2s6rz7x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Tue, 04 Dec 2018 20:33:08 -0500 Doug Ledford <dledford@redhat.com> wrote:
>
> FWIW this will go away in a day or two.  I merged mlx5-next into rdma
> for-next in order to take a series that depended on it.

Understood, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/vG645c4b6W9KXzOY2s6rz7x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwHM6oACgkQAVBC80lX
0GzOJwf/SCt5nIq9akTUi/0Js6T48he9Lzl2FF6YTU4b9Z6l4Nhv6NCIjS5siEOS
j7HifJEBkW+zwzIXVjGq1U9ZMrBy8ZJQSux16x60B4Er5RuYp4VmsbDGdmmP8D8A
ESmtQdoQEKnr3I4G3qkEhveJPBSc2DKlkLXCOxH2f9SJc6A5xY9z6KboUT7ebJ9W
9t+gbv49UxkU+mVh4muRVnYbA8KK3/iBHc0NnZxaUQZpl/chgAe2YEYyaOd2XmOi
/VWtPeuJOSVrSMJuBMovA7BQHAkjR6sQUK6DCqKVTO+qhG94n1kSkyzSxo+S0LMp
jwgm3hCToxPRhv7vBWdHdd/DOmlSlg==
=6VdL
-----END PGP SIGNATURE-----

--Sig_/vG645c4b6W9KXzOY2s6rz7x--
