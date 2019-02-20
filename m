Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8379B218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBTR4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:56:42 -0500
Received: from anholt.net ([50.246.234.109]:50962 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTR4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:56:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id ACDD010A2D1A;
        Wed, 20 Feb 2019 09:56:41 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id M9rWLoXElLSb; Wed, 20 Feb 2019 09:56:40 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9ABDC10A047F;
        Wed, 20 Feb 2019 09:56:40 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2CFC62FE464C; Wed, 20 Feb 2019 09:56:40 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v5 0/3] drm/vc4: Add a load tracker
In-Reply-To: <20190220155124.25022-1-paul.kocialkowski@bootlin.com>
References: <20190220155124.25022-1-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 20 Feb 2019 09:56:39 -0800
Message-ID: <87sgwie42w.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> Here is a fourth iteration of the VC4 load tracking series, which was
> initially developed by Boris Brezillon and that I have now taken over.
>
> This new iteration takes in account comments from v3 and comes with a
> new approach for avoiding underrun reports when reconfiguring the
> pipeline. It is now based on detection instead of delaying the underrun
> interrupt unmasking.
>
> It can be tested with a dedicated IGT GPU Tools series:
>   VC4 load tracker testing

Series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks for persisting on this!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxtlNcACgkQtdYpNtH8
nujvWQ//cu0E43ojWue48mNWFOrvuzYjQJF7H/6lfK4bxR/lbdu0vfUCX44XX/gp
fPnwcDbdmwa0yFVGHqoevI94znUa3PCAu98byBihBbOe/YDFbl0zMwtioN+yVykr
aHJtN3TzDzhOiLwTyRuy/d7dE0yLiECk2VLJ6nEbI/sRyL8je0E+NJhdB7Foc2IZ
EEacN51CHXz9Un/4oBTVkXsTqBpiGX4LyGudgPbCuIXzv3hFjOgIrZcW0HCQsekk
vLopVaV9uKJfIeTY+41zmRL8L1CRAxkRYQ5XpBU2TJVgl3OdixzaORU8XQjxI5yq
ASpmYTdSx7femM8w3QjlXJVeW/c12VecA+tpj/32WGHS5kSJi6N3tBkzxhBRUtCk
0ndJI10UD+k7dOUMmUz39bVm8/kG94cNcezNgvikX9/EiqY43/NyX7X9O/0bjYy9
GSj3WG0wSVe5yiBikt2fnuUhKUEF9ZrNMo+5voOTN5JdWYo2nEImSWv6L8WXmMqX
TDLBo1lsliG4Q6N4hQubwPHf8a1QgE1H78HCybGqYp4DuZY00FHxtYJMA0nJ/bLv
Ep6iuMiiSLaWibkzOuKo9YEpbubjytUOjnVAo9go56rjcwH+iFkEBVy8bNap48t2
3vLn7MXx/thNXhZfnEcN+/huNi5+KhpWYg/5Qb43FjDLXocxTHU=
=U8fK
-----END PGP SIGNATURE-----
--=-=-=--
