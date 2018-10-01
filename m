Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8993C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7399720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7399720666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeJAWSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:18:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47344 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJAWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:18:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g70IN-0007IN-7y; Mon, 01 Oct 2018 11:39:39 -0400
Message-ID: <a43fc0dcf83c077b1df08ba0e9aaa9c9bf65d5a3.camel@surriel.com>
Subject: Re: [PATCH 1/2] mm, numa: Remove rate-limiting of automatic numa
 balancing migration
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Jirka Hladky <jhladky@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Mon, 01 Oct 2018 11:39:38 -0400
In-Reply-To: <20181001100525.29789-2-mgorman@techsingularity.net>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
         <20181001100525.29789-2-mgorman@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-b8SOSbGpPkVSzD2HHy3s"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b8SOSbGpPkVSzD2HHy3s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-10-01 at 11:05 +0100, Mel Gorman wrote:
>=20
> STREAM on 2-socket machine
>                          4.19.0-rc5             4.19.0-rc5
>                          numab-v1r1       noratelimit-v1r1
> MB/sec copy     43298.52 (   0.00%)    44673.38 (   3.18%)
> MB/sec scale    30115.06 (   0.00%)    31293.06 (   3.91%)
> MB/sec add      32825.12 (   0.00%)    34883.62 (   6.27%)
> MB/sec triad    32549.52 (   0.00%)    34906.60 (   7.24%
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-b8SOSbGpPkVSzD2HHy3s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluyP7oACgkQznnekoTE
3oOQvwgAl8N5coXoRiC8EPbZWHxKYiA95wq1lkYJ0lE18HgqQ70Oq3j84qPjN503
v5tb8xHk0+BJxwTQzWRWo/9MLhHlBwIgoJHKS+k9kCm7KJxps/ntExCC0FDbmRs+
4rrfj/ReNyyJjZEfNeapZKgWf33MXIoO/DXr6a7+GWeAOHkanyzlGxAqDMalelk+
8OdgviZ2Ib7aNOS/gyrJ2WBmiVrcPJhikMzC+X4iaKSt6ZAYdrlSvKyHPHUyqUSM
DhomgmtpUKDqjbRhXYqPlztYERITI1EwtHdrzZpFQaTA9/r+3khxE+I6un4mPsZp
/5xh5t3mt28fBawHL7fgeHuxUsM1vQ==
=OgZv
-----END PGP SIGNATURE-----

--=-b8SOSbGpPkVSzD2HHy3s--

