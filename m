Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EBC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269AB215E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OJO0UC7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269AB215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeHSDzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 23:55:23 -0400
Received: from ozlabs.org ([203.11.71.1]:35309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbeHSDzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 23:55:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41tJBy4cnXz9s7X;
        Sun, 19 Aug 2018 10:45:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534639546;
        bh=RtbwtQBitfxIAlbizWaIKT3n/dRqATZYyrPNXG149L8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJO0UC7ZeZUhvLBh4lzuLl5U90gH+UkmaCyph8rfY/aC4WxFuDRN/uESPX6amsMM1
         M4M9Wi4AXQfM6OdKuSQmkz32YmbB/row38syTexfH9lET/OA+yUg51PYmdn2xrlwIu
         zROJ9w5WOX2l3XGGWddq45mR5l8MpAFeTPOzwT9EPNsXXagBQzQe5qtM5fcS/xX0Q1
         PKqxTOduIE4ee4tq2Gj2by2RiCrlQnj9f1rJjOHM5Q9F1sOLO7Hnjx1ZAl0gd771Z3
         gG/YX/DUgAOZ5kVKEXa57Nf84XcgoK4E+oTky3GGdr+OIHDHHw8y6GndUquJisNE/q
         bnXCk/OW1haMg==
Date:   Sun, 19 Aug 2018 10:45:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the h8300 tree
Message-ID: <20180819104545.183ee1bc@canb.auug.org.au>
In-Reply-To: <877ekneios.wl-ysato@users.sourceforge.jp>
References: <20180819003005.4a5792e8@canb.auug.org.au>
        <877ekneios.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OGbX_hASX3R6LDeXnlANMgi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OGbX_hASX3R6LDeXnlANMgi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

On Sun, 19 Aug 2018 01:35:47 +0900 Yoshinori Sato <ysato@users.sourceforge.=
jp> wrote:
>
> > Commit
> >=20
> >   85f866b60ba7 ("h8300: switch to NO_BOOTMEM")
> >=20
> > is missing a Signed-off-by from its committer. =20
>=20
> OK. Fixed it.

This last one is still missing your Signed-off-by ...
(it is commit 09c7c64733a2, now)

--=20
Cheers,
Stephen Rothwell

--Sig_/OGbX_hASX3R6LDeXnlANMgi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt4vbkACgkQAVBC80lX
0GyD4gf/YQRKGiOHhPCdQCyZ6iqc3gZka7AK1e6WQLPvnKACTeUwbG5c6G9GueHj
s7tQNHuv9Umm66lDOBR5xMeG2kRMGADlO0tJwL0yHAsmuBKjpXtT8ZyIZncWERTX
d6PrDPyC8qfpd4f2urOvdypceseGyQ4svv5SFpdT/9obV4FVfHmCNwal2ekPIwYC
8g1JUYNV8/WPzeUeEgFOueiWdNuvFax9/ZdzUKO0bTSXvMXU6t2EKaMhVIzDjYGp
ZSxjhE7WY1FoL21ix9aFDvjEd6M12lKJ3zjJwGWNNBQfFECnZlvvT8C8JXevBCoZ
k0csi05n2bFL/VresgG3CuS14zbMHw==
=Rh6t
-----END PGP SIGNATURE-----

--Sig_/OGbX_hASX3R6LDeXnlANMgi--
