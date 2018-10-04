Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B197C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAD12084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="os4CQv+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAD12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeJEEsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:48:31 -0400
Received: from ozlabs.org ([203.11.71.1]:36305 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbeJEEsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:48:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42R68453Brz9s9m;
        Fri,  5 Oct 2018 07:53:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538689988;
        bh=Z1weWdNXpq5CAaDyafp3XqLkk3WYe5+xmsj6rfa96Ys=;
        h=Date:From:To:Cc:Subject:From;
        b=os4CQv+OHQKpLgQmwcggvLtd8AjvV+vJCB/yVFM3TeQIqSWNgtm5h1RvYuIQ+MINe
         eEEtceX1IFpWyXNj/c2PKnscrLbLNoGv17PPpVOkZece54+m2dnA2Y3wSHIpS0wD+Y
         7yXEpwFVFurMXCKswrgLfI5+OdS99zVt8waex0uQMxUpXC0XX7NGGy4nsoKsA02/jt
         bx+WQ02AN2BdpZGp2S7xYCqqOIQ8JWpRnKPi54XY6drQK7VDWBRgd39ZxRtubU3LTO
         b9FyB6AU+asYNX3TYVJw78MPTTQeyCrUHsY4Fzs/MQAG+2YpJHjqJbQ1W87/LVcMl5
         fVwYhIXM239jw==
Date:   Fri, 5 Oct 2018 07:52:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-msm tree
Message-ID: <20181005075256.50f06745@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4iJMsux.lLYDaVgkiApjxum"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4iJMsux.lLYDaVgkiApjxum
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commit

  c693ecbd6357 ("WIP: drm/msm: update generated headers")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/4iJMsux.lLYDaVgkiApjxum
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2i7gACgkQAVBC80lX
0GxKuAf9ESWeeA/byThJO2USLxLY+mS0i8fCsghROBtIyIYTUI+SF4XZeq/G3Xbi
E44Sboo41SYfy3Bz9toXiWL0uraoI7zs4kW6n1HCgvL6UKgDIw5PUiRT2HenH8x6
dpc9CRT/Ev3TF4Xn+2STpBWU5HR8bJ48Sl0kpSiz8pVTRLD0a2q02Za3zopfQ2WZ
cEAUVXwFZxdMUvrcGhMuUcBq1FoiyZh1lUdtaldaM1qtWVRX3HK/18zaboteCnxJ
yL3C7Eh7mMij4wURms6zBDyv8MbXPbyVeQQHTBbG4pHofdFv0X8cpgCk+dO6+4sn
aXlV49CADMNNSKihUs8P/vaALlT76Q==
=RfwS
-----END PGP SIGNATURE-----

--Sig_/4iJMsux.lLYDaVgkiApjxum--
