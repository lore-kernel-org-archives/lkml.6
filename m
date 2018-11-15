Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2134BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44752145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X0aiHYkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44752145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbeKPI3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:29:46 -0500
Received: from ozlabs.org ([203.11.71.1]:32775 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeKPI3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:29:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42wwll0T30z9s9G;
        Fri, 16 Nov 2018 09:20:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542320403;
        bh=/28aHOEVHfeDUn+cuWops52FcNr6c7HMAg7R6vXq9Jw=;
        h=Date:From:To:Cc:Subject:From;
        b=X0aiHYkd6ig83Z302Cy1tZsm+CUnj7SJMD8sKPifLFfdpgV2TgkwceJrwhhyhEJy2
         TAEMNRd0DAsg+1wnAq63o6+ftp5dThxm42JLgb0XjAaaO2xm3zqte/VQQ/BzTg0oLH
         /BhUtHbGQTaoWfzhMitPOVBSn6OTChfbqJ/xY+r6+Lzy9zQUEo+yV3Qb1L/g5G57JD
         tS+1xFb6y1dKhoVM5XU3SnCUS8XwTvwtVtLSTeNPJpzmofi9wHxdu1Ej4kKEzmIKiD
         kyEblz0oDo/l9h4o98AUq6kLbSLD0iz/Z6dbwSlDNpB2Zl7Pl0Pm+rjbO86RZXDmp4
         pRbofz1ScqCKw==
Date:   Fri, 16 Nov 2018 09:19:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20181116091957.4880b95d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8LQH=6XtSCEUE2wh11.Vgxb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8LQH=6XtSCEUE2wh11.Vgxb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  25b76c531970 ("gfs2: add a helper function to get_log_header that can be =
used elsewhere")
  14e81158a6d6 ("gfs2: add more timing info to journal recovery process")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8LQH=6XtSCEUE2wh11.Vgxb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvt8Q0ACgkQAVBC80lX
0GxOQgf/Rz/ccyhOt2dbNTkB9YhJZKvBXuS5XayI6v1DLTUl4szAIcyzNmyjJwhu
Z+FMEDOa4wJGaI2MuSTI2oFewlQhlWyhH+xgDdXppdJlz7DwHvyHckSbBIitEnpC
EYo6KKNNq6IqhalmwZDzD/B0D6s6EiDTftCcKk73YcyYe9DG2pcV+wb+SCfE4nCa
bDI+weIBBu8gIqmZEH4HnaD3azKlaLyLr9hsvWK2vrU9/bKkQ2+Yc7B+zKuE6NZa
RFKTixAdzyG6Bm0WDePww8nOah7nwTaMoe+SNBRbtRPy2GdiHKQXKzVO4x/zqhlQ
kB7s9TjEZa8Wl1NNXPNUKv4v7FUuLQ==
=EpR8
-----END PGP SIGNATURE-----

--Sig_/8LQH=6XtSCEUE2wh11.Vgxb--
