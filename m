Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D507B20658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l/MzbjQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D507B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJQOJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:09:13 -0400
Received: from ozlabs.org ([203.11.71.1]:52043 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJQOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:09:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Zhjl3ZSqz9s9J;
        Wed, 17 Oct 2018 17:15:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539756907;
        bh=WvU678jVDHPFc8jAWy60P/0UvLmITfWtECeMLoIk6cw=;
        h=Date:From:To:Cc:Subject:From;
        b=l/MzbjQzGQ6m5Fr3s6fPdNIWyQBJsivYjk7frhjPb9pkHlPip7s6Tf9E0C2SRuTPE
         ZVVaPwTWwwRhoZ7couyfZnZcaN4vcnulEB6wVRzj/Ug24UoADfG6JsiXm4rhmg+/4e
         O/OTCgnG5IsGtBEsLOQNoHtIu/IygKwrjErOUkf1tIN6fmRxYYhzx7dHdReHH+htUf
         gy1ZqOf0rydJjfE5KArxgzX0bouxZL4NrgyRc6J2fAw1qxKBkvq6e+bXL0BaU2KKkQ
         pWTyoMntcB1WFP3hk71pyYTRE67anxAyE2YQ4CeIHKm/ju3isB3ct1jDBsDe98kE+q
         fBvMSBv4ltW4A==
Date:   Wed, 17 Oct 2018 17:15:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the parisc-hd tree
Message-ID: <20181017171507.6cfe08d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gZsn.ra0WuoNa=dnqw6kzvd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gZsn.ra0WuoNa=dnqw6kzvd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  17714e83ebff ("parisc: Release spinlocks using ordered store")
  c389eafd8ac2 ("parisc: Reorder TLB flush timing calculation")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/gZsn.ra0WuoNa=dnqw6kzvd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvG02sACgkQAVBC80lX
0GxJsAf/ZoFlEOWdSCUHSFJiKFPUXsuPXPhjvrl6cNXGU7Rr3PjwFGLC80EarbWm
wtp3So5riUBiycvIRI752unoe9DAgzFciZ4LJ+DX1H/JFs2kOoguyc0ehX2WZ+1q
19NdTYc9QXXQcaTXeQl88RkgCdKYenqd9F+ftijJkaUsvgioSecJabWT8XGaKeDi
fNPRKgpztzsMJ9me0AEkjT6u3t6sKgYPisX+9SveDsgvKndc0n/lis3m1PvEpLbb
Z+nPTpnaOV3uF5Z8I0gz0h74JVLofHZ+UrBoZ1trebPwv6X7ruZvjNhWjh4eKmDQ
XL3KT+IQpGI2JJBjTTPaACPvEpStUg==
=8Z2q
-----END PGP SIGNATURE-----

--Sig_/gZsn.ra0WuoNa=dnqw6kzvd--
