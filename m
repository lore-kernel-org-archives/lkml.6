Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31B0C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3E62084A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JdIHKfNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3E62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKCNH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 09:07:59 -0400
Received: from ozlabs.org ([203.11.71.1]:37845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeKCNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 09:07:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42n4sh60MVzB4YV;
        Sat,  3 Nov 2018 14:58:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541217485;
        bh=kPgscUgKf0/7XdGFNM6EUcu6+2Gx0ipUR1ZJN8QpKns=;
        h=Date:From:To:Cc:Subject:From;
        b=JdIHKfNuPrAx+UiSuWYDoEd1v0E6uXRdyiCu+MHIGVPQF+C7DXHkqEGugtT30cR7e
         bcRgB7GnTH1XQPuLNzXFRXmTPcHBAkPF3VXKXwEhLtREO04xbUstshDZaf3t1jixFB
         i9htMavQKxoP93XEaYciQOGRGjjQ5iKm1oYJq7j+IOc4mTUHCsE8JGclP9cNMKrIyI
         Cl4E51pmsIgplj4Q91rGO9luiw9ku4TB2r4+XEMD6BHq9WwwLRkGpRmThHFX/bnpD7
         Sit353ihVPwSBx69sLcgDoO5on+QpyPOIM2A354mkCuAMIaDbb0neJ+8VYT96CqEcj
         1KEaN9Pg3pnCA==
Date:   Sat, 3 Nov 2018 14:57:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20181103145752.6c1d10c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oJd5hFgelObjrczIjhkZed9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oJd5hFgelObjrczIjhkZed9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cda58c80fe27 ("ARM: OMAP1: ams-delta: Fix impossible .irq < 0")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/oJd5hFgelObjrczIjhkZed9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvdHMAACgkQAVBC80lX
0Gw6iAf/fJPpMfPSUQijptsXVb3gKdwwkvvctq5F5FcKM1ZSWwtTiXTC93DApQ5Y
i5NtDoyYJUkgQ4r+AToiVWbAodBH41qFhiy5fhk7KeonGDZLJ5+y0KRlYL5i3Yvz
sUXay9Or7BReviCz3DqlKCu+YzMH7j+hmZeK85CfthSWi719ecciPhzHyLbUIiDW
fQcJY4UX4kVJp6tUdTyPpsXCyRRYJzA7DRb2SCHw6YjiFT+v1n5+gtHiiB4U6NqU
p6do/LTcBAWoICBV33OwFmQdhEu/rVlMhpmKIPuA9QNiACPWBoqgXy4pWD/qas3B
NQ77Fz/UWpjHdjqwDAJNzjQZYJA2jg==
=5OkV
-----END PGP SIGNATURE-----

--Sig_/oJd5hFgelObjrczIjhkZed9--
