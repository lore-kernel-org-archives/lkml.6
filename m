Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37508ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C339E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QDVasLyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C339E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGQWdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:33:09 -0400
Received: from ozlabs.org ([203.11.71.1]:43897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbeGQWdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:33:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VZ0h00qpz9s21;
        Wed, 18 Jul 2018 07:58:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531864708;
        bh=6ICcQ9YZo4teDZJb2ctwvf0vwJZcv99WB+xtfaVDOUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QDVasLyDFYjF0246NFoX/kSIEQhd+UWhZ/OuNjpfFEJttOappM9wBiv49l4Qkr6wg
         aO+xN+K47yInU9a1rO+Scx3MC5RvgXBMd+BXV1a4Cs7sfpLFaVI/pZ0LUtXEVfdTT3
         Z/W7lZJyQIkGjXFOs4I+0MHFs6PQ6lW/ufGUVO0IAlQZEgTei+lum6m4j/LWvuCobT
         aB1DSoKfESfwpSTE4DE6nCviPmwErRIeNEH2QdEZalt/kBOTNdP7lsqQZ82SDHxeUk
         YLkAqD062YI4KwxwlmCU+cwZ17HsKKKzMtBWIOBBiZoUWg4/OzMMINv7fDuzCZeh9S
         qnecvY/aRlCUA==
Date:   Wed, 18 Jul 2018 07:57:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the h8300 tree
Message-ID: <20180718075750.037fd403@canb.auug.org.au>
In-Reply-To: <87o9f6l0ck.wl-ysato@users.sourceforge.jp>
References: <20180717052419.11610795@canb.auug.org.au>
        <87o9f6l0ck.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ni.5GwuzH1_MzH_g4yD+hnb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ni.5GwuzH1_MzH_g4yD+hnb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

On Tue, 17 Jul 2018 17:42:35 +0900 Yoshinori Sato <ysato@users.sourceforge.=
jp> wrote:
>
> On Tue, 17 Jul 2018 04:24:19 +0900, Stephen Rothwell wrote:
> >=20
> > Commit
> >=20
> >   39f077046d46 ("h8300: switch to NO_BOOTMEM")
> >=20
> > is missing a Signed-off-by from its committer.
> >=20
> > Commits
> >=20
> >   d6bde68ad18e ("h8300: Add missing output register.")
> >   5aa2f1573e0c ("h8300: gcc-8.1 fix")
> >=20
> > are missing a Signed-off-by from their author and committer.
>=20
> OK. Fixed.

Not really, you now have those patches in your tree twice :-(  To fix
the missing SOB lines you really needed to rewrite your branch without
the original commits above.
--=20
Cheers,
Stephen Rothwell

--Sig_/ni.5GwuzH1_MzH_g4yD+hnb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltOZl4ACgkQAVBC80lX
0GzCVwf/a7etmJTu01sQD63kSbLkW4nsah1W6eALEpuVwk9hGXiUNhAody4ShtAU
dtz32oHrMEZeSW/IGUk9PVzzs6YuqJ7gGFuwpSiBf6bKDUtc77I41HKA8hjU6YhW
+cyjrdcP3QDySbvP8HIGz84pUJGz0iWgbwQBKO3xB/hPA6RipZwYUZ8/9CRpe3Pj
tH29IcUZ9TwfIH2HndXctCKUATEuBuWnYiogeivKp3lbd4pCynUtRILPx9RcsnnY
PjRWqrH+MrXc06RyDuZ/B39Gl91XmSFGuW8WnaDOj9JXoLNSi0s7n36/uuSoWqde
tXpa8x1f+JColuvVsN32Ak5/B5lBxw==
=ORMB
-----END PGP SIGNATURE-----

--Sig_/ni.5GwuzH1_MzH_g4yD+hnb--
