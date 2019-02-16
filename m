Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB8CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6731222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfBPAxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:53:22 -0500
Received: from anholt.net ([50.246.234.109]:56108 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfBPAxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:53:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E7DDC10A2CCA;
        Fri, 15 Feb 2019 16:53:20 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IGwYmO8CJtSQ; Fri, 15 Feb 2019 16:53:19 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8C07B10A2A79;
        Fri, 15 Feb 2019 16:53:19 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 11BAE2FE464C; Fri, 15 Feb 2019 16:53:19 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm: Remove set but not used variable 'gem'
In-Reply-To: <20190215033507.103232-1-yuehaibing@huawei.com>
References: <20190215033507.103232-1-yuehaibing@huawei.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 15 Feb 2019 16:53:18 -0800
Message-ID: <87sgwowo3l.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

YueHaibing <yuehaibing@huawei.com> writes:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/vc4/vc4_txp.c: In function 'vc4_txp_connector_atomic_check':
> drivers/gpu/drm/vc4/vc4_txp.c:252:29: warning:
>  variable 'gem' set but not used [-Wunused-but-set-variable]
>   struct drm_gem_cma_object *gem;
>                              ^
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Pushed to drm-misc-next. Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxnXv4ACgkQtdYpNtH8
nugKehAAjTju4cJ6fEKTf7p7P9vo0gKzTV8/A69CykEWmN3N8vBf6wGefP3BmlZw
vFafNsFqv3Wrpa6EHfwxGiCOhpVaioNWhW/oTpzUvZvuAV6K59MwMxU+faAfOWXl
0+n8HLmfrLlzdbcCPDl9JpFtUJA/mpLn4sDyTCvTCpLzk3G9yrqA0hArGrZ7lvHe
s6/C9ViytSHpiGoGielkiC/r6WEqV3GO2RcK1ozOngCMrXiKdIYSySCYwXEYNUwz
tnTIGURkQuw5DnN+N7qj0HvMDvku/3qS7LTXHaBOr6Bqd7qwCD3zlxRn+sFnbnZZ
EfM6mdB9JyhEgMzpyRzECAH1bDyVSvD2oKgoOIcRQhEayB+zgK41SsOgYYOwRR65
7obqVZcR1h3YME6GW1HVeoQiviSO9DT/5sfLAVz4sZF+b+uIy5AKd27c2KvxcniB
oWYr6NCfvETyxt0FpefeNQiabRMEbhtu+Mk6uSfhN1z7hvUuSIRPnHxquIYT2pbW
fwHu94qcH6Q/UmAmT+rLvI01/ChyXCijS1xEcq6IVKqDpavzIlhQYCUY/ImsA/rc
Q2q6yH58d7x4wVndMv0iwmMWXSjLs16RGqO4W19eOr6RCH/PfOZFgVmaaFDVDPm1
t8fMHaegXMUBb6Jrou33PxvAvdliSZDJWK4oCZochUGbLidfnMw=
=Ydk4
-----END PGP SIGNATURE-----
--=-=-=--
