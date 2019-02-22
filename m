Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC1720657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfBVTBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:01:34 -0500
Received: from shelob.surriel.com ([96.67.55.147]:56522 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBVTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:01:34 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gxG4h-0005nI-SZ; Fri, 22 Feb 2019 14:01:31 -0500
Message-ID: <0cf441e7cb7cb4cd0ff2b455928497c9a1fecfbf.camel@surriel.com>
Subject: Re: [PATCH 3/5] mm/compaction: pass pgdat to too_many_isolated()
 instead of zone
From:   Rik van Riel <riel@surriel.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Fri, 22 Feb 2019 14:01:31 -0500
In-Reply-To: <20190222174337.26390-3-aryabinin@virtuozzo.com>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
         <20190222174337.26390-3-aryabinin@virtuozzo.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-b1FglSvBXlFgFSAciTne"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b1FglSvBXlFgFSAciTne
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-02-22 at 20:43 +0300, Andrey Ryabinin wrote:
> too_many_isolated() in mm/compaction.c looks only at node state,
> so it makes more sense to change argument to pgdat instead of zone.
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

--=-b1FglSvBXlFgFSAciTne
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlxwRwsACgkQznnekoTE
3oO+dwf+OtiXa8Llp5bfJjVguOx9HYLmnPFltiIVv3cApI8JcvWkY/iLuYytUqy5
LsjLY4zuKS6brYtDnlVtcn0sfprziCQqmXxnoI3G5PjGy+s1XVPSgMXVC0LAkqiY
un++1kK23CMAL825PXcNp5B9/dK/x83j152d6SfDfyCcFiz2jv3fA+zRL+IuoKa/
RL5F5EIL4juD8jU5AbfJbryuneQlRDHAx0FgHt/Wz/MNEJfPYGAo2KLkX1i7tw4k
Vz12WDXKfyRsHIpC+U+zHukg4lUAjhSYc2z2bGOQTpxX4A4BBYJWXy72hrngqPhc
UeVV5nBmae+0w+L+uRC9Om/NU645ZA==
=H6nL
-----END PGP SIGNATURE-----

--=-b1FglSvBXlFgFSAciTne--

