Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC267C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965AD20657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBVTCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:02:03 -0500
Received: from shelob.surriel.com ([96.67.55.147]:56540 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBVTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:02:02 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gxG5B-0005nh-IE; Fri, 22 Feb 2019 14:02:01 -0500
Message-ID: <855102f6f7735ea71964fb14db00cf9552530cbf.camel@surriel.com>
Subject: Re: [PATCH 1/5] mm/workingset: remove unused @mapping argument in
 workingset_eviction()
From:   Rik van Riel <riel@surriel.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Fri, 22 Feb 2019 14:02:01 -0500
In-Reply-To: <20190222174337.26390-1-aryabinin@virtuozzo.com>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GYX4p7ewd54zuNzzNR82"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GYX4p7ewd54zuNzzNR82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-02-22 at 20:43 +0300, Andrey Ryabinin wrote:
> workingset_eviction() doesn't use and never did use the @mapping
> argument.
> Remove it.
>=20
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-GYX4p7ewd54zuNzzNR82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlxwRykACgkQznnekoTE
3oPODggAjpaOQ1aAPR8IS2tINpinSdPLB7xQ4tCR2+VEBqToEdIz6fcuRFb3cAJL
ZIflsoTCDvpQqFzkv1pUsf5fQsuMLbTiEgc/KvxH6s7ysIx6sbeXrfQIYalYHwGT
yU4TzK7FKJjGHX6LEjDoUSVKNzklPQWLFzqRuWvMj1P64DWyQhDAZUo0a6mJ2cEc
T2TchsJvN0X62vJCgWTcZ+sbOqCopA4LRdOzcc0TVfba3h5nN292PLMVgneq8stn
P9xi8Kwg2VtBqLOv1S4gy4Py1X8r5dXlk1YpCw1Iy+013XFgGBwhE5YKUOJDdUnR
9gIvwU3gyoJUvRszdPsYeyGzMuQqOw==
=cbTd
-----END PGP SIGNATURE-----

--=-GYX4p7ewd54zuNzzNR82--

