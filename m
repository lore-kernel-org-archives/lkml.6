Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7964E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cw6ib6FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7964E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbeGYC0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:26:00 -0400
Received: from ozlabs.org ([203.11.71.1]:40497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388569AbeGYC0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:26:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Zy4J1Nw3z9s0R;
        Wed, 25 Jul 2018 11:16:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532481408;
        bh=UQqt5SqqYN3A7clz0SHa2UKyOBM9oHxn+cZLkJYXC98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cw6ib6FIS44OO3Um2UXbUGgg/pODi3sGTdV6s4CnD7dd/eNCOTf+Vb6zxC+MsSfwl
         cKD83JtaYoM2aMEHfDHQRGkGjJ1aGtuqQ8l4emdQCAHdKBwXP2EeoS8o7b0bAweEe2
         n2KvCUtth/jniWmDqxVJUdIXIZtELI2/sISynQkbrtLaBSlPMFiaebHrTgduwDa2Sf
         WSPPQMvPexexOyCl7FrJjcPyaI1wVpc6HWDROq0b759eHD/5/j/Hw3ADcu2+GgLRsb
         oIXylm2aepXypPpDhm/zbvHFKyWdQJ0+immI2odNiDLcp5C3iRecgyyk/+GHQfvpQo
         rFQQqKVISm7BA==
Date:   Wed, 25 Jul 2018 11:16:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andreas =?UTF-8?B?R3LDvG5iYWNoZXI=?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20180725111514.14951d78@canb.auug.org.au>
In-Reply-To: <CAHpGcM+WkOKkd+GLMiTWsvnLA_daY_5pBfSQp_KYoPVcRQQHGg@mail.gmail.com>
References: <20180725080130.314f62bb@canb.auug.org.au>
        <CAHpGcM+WkOKkd+GLMiTWsvnLA_daY_5pBfSQp_KYoPVcRQQHGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9+GW7cuk9ae9H_Au9Ppa+XY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9+GW7cuk9ae9H_Au9Ppa+XY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Wed, 25 Jul 2018 00:23:22 +0200 Andreas Gr=C3=BCnbacher <andreas.gruenba=
cher@gmail.com> wrote:
>
> 2018-07-25 0:01 GMT+02:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> > Hi all,
> >
> > Commit
> >
> >   b6fbc2f6a686 ("GFS2: Fix recovery issues for spectators")
> >
> > is missing a Signed-off-by from its committer.  It was rebased. =20
>=20
> thanks, I've fixed it now but this is getting rather annoying -- and
> it must happen to others as well. Do you happen to have git hooks that
> prevent this from happening?

No, but I don't rebase stuff (that matters) ;-)  I think that someone
did write a hook, but can't remember who, sorry.

What I have is a script that I run over each new set of commits I fetch
that checks these things.

--=20
Cheers,
Stephen Rothwell

--Sig_/9+GW7cuk9ae9H_Au9Ppa+XY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltXz3kACgkQAVBC80lX
0Gw3dwf8CQD3KNnshB88ALbaJJH/5/p52FFqf4xhG7iif4MqgsC7+IAgUdLM399a
D48euC28HfLiijRTv03RJeBNxuy04jcRRheqEU0Kd2ghQR64H/trRelao4npt0ZX
g21IVGyoEZOOa5dcE9fnhFY0MT0lCS0MCMrWdiuAHk6r2desbxCJyUT52OSZmc2B
O2HpmGDRVAWswNd0a53JAK8wTOpovx5M7EFmOXhvCQ5Qy6j1WYbvfVV5T7xSAAcW
EYHz2E5vrdntcrJ4fDv3hxeGuqkkCdtlJcZC/ljgX1ZHrsPOi+1moiUqe09a2yN3
a6Tilx+Uktk6diSH4/7RUy5ibivHhg==
=9SgH
-----END PGP SIGNATURE-----

--Sig_/9+GW7cuk9ae9H_Au9Ppa+XY--
