Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D7E2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eYSKGQ/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406080AbfBNHgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:36:14 -0500
Received: from ozlabs.org ([203.11.71.1]:56855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfBNHgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:36:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440Sqv1x5zz9sML;
        Thu, 14 Feb 2019 18:36:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550129771;
        bh=XFNYlUhSDJOrHHFLAyfdhnbdXjBfrBCZCu8CUI3Wj5k=;
        h=Date:From:To:Cc:Subject:From;
        b=eYSKGQ/eYGobjwh5l4yZ0xkq+TeB/zrXVJYBtQ1YQm2gZ7G9i5DUnvl8yLw+lHc7I
         /bXvAz8tRWBGaYuvHsqkwJ0g5yqz4UmkEuxwKYjRpp3ZAWq2ENonKOqWgqbdA4iQe/
         T+Jbrx16w/YIXbtg1rcL0p3rEbmGGiKFa7xhvaaUqQJ0pZo75P3So+txdP2lgg5P3d
         3zzmVkXyNeGRumKFyGk+H6Imes4JFlrLfOf5BgckdhPQLpp1LFRqy4W2itCcH5z+xX
         zdBwZVFh9raGfsz0EFr4sFCsMM/9mq0mhQPMtqzDxgMiWW1S9cCUj+yFsF4p9vmr22
         o2qeff+nwwf1Q==
Date:   Thu, 14 Feb 2019 18:36:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the leaks tree
Message-ID: <20190214183605.3132886d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c0VxBprFlYC/OObZ89OgnUr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c0VxBprFlYC/OObZ89OgnUr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tobin,

Commit

  5d06b3fc8e61 ("leaking_addresses: Completely remove --version flag")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/c0VxBprFlYC/OObZ89OgnUr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxlGmUACgkQAVBC80lX
0Gw8Cgf9HXU4BkTcbrqAZtNeeQxhJJEQFQj92zm/OfpH0aMx7YYz/45YonHNqBhr
XAfwt3cqX4Di5TuL9b9EjfV1fBpAGYN/YxFDiQ9f162uJ8c+WMN98gW2Ecne9JF6
03Fo8Z46s6EHsILCC+G1akeDBRBrRB6sYSPFnZklWFw7/ugQ7K+RK9oTnbatDr1l
qAMIA4TswIak3C2lsAAYCRHYm1m/JEfagS75b4zk4nzRPAaWk6W1CyQ0gahEcWzu
r8cTC7cXgttYPtNB9rKUlvgNKhCdQ7IwKsE9ZVHrjEgjAxqvS9CYJX0lNbt72EKy
Y0ROMArDeeUpCHLERHKTi+2+tRURbg==
=wtQ7
-----END PGP SIGNATURE-----

--Sig_/c0VxBprFlYC/OObZ89OgnUr--
