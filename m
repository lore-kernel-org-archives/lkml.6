Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B44ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C3320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C3320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbeGWQez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:34:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:54688 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGWQey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:34:54 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fhcpe-0003Zj-FJ; Mon, 23 Jul 2018 11:33:06 -0400
Message-ID: <1532359985.26425.10.camel@surriel.com>
Subject: Re: [PATCH v2 00/19]  Fixes for sched/numa_balancing
From:   Rik van Riel <riel@surriel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 23 Jul 2018 11:33:05 -0400
In-Reply-To: <20180723150954.GI30345@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
         <20180723135700.GX2458@hirez.programming.kicks-ass.net>
         <20180723150954.GI30345@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HKpoQF+MshVBjkKyg9gA"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HKpoQF+MshVBjkKyg9gA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-23 at 08:09 -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-07-23 15:57:00]:
>=20
> > On Wed, Jun 20, 2018 at 10:32:41PM +0530, Srikar Dronamraju wrote:
> > > Srikar Dronamraju (19):
> >=20
> > >   sched/numa: Stop multiple tasks from moving to the cpu at the
> > > same time
>=20
> This patch has go-ahead from Mel and Rik and no outstanding comments.
>=20
> In my analysis, I did find a lot of cases where the same cpu ended up
> being the target. + I am not sure you can apply "sched/numa: Restrict
> migrating in parallel to the same node" cleanly without this patch.
>=20
> So I am a bit confused. If possible, please clarify.

I believe that patch fixes a real issue, but it would
be nice if the code could be documented better so it
does not confuse people who look at the code later.


--=20
All Rights Reversed.
--=-HKpoQF+MshVBjkKyg9gA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltV9TEACgkQznnekoTE
3oP9aAf/ZCOeMKbziJHcBeXXwRPEFlOXwzkEZTOLj9mUqjaiA0xvYi1lPbpphLkb
Fr3NqCivkCoQq91FTIafAEGv/kqF1PQgpE5qYWC5eGy/WPI7N6Ymp2RtlO9j1wi5
/ZJ0mTOV26Z0qS5JDJJ7kdMGtk+X8Xwz/AKOBSaCN7oyPCcv1ksDyjvGEdR9aI/7
4TOMrVqXhkGIxUciNEKJXBKwZxno+z3qPNWpQPSL8zSUA06yeQGmgrvBGIJpD3Ir
rAWz3ZHl/YPE7X4mGIvErwpjZLBvf1giU9UueYn51D//jYO3PEcOWDxUQDH6WE7T
rB7DXVwr3mhC2TZk51ptF7ZmmKb83A==
=VPNF
-----END PGP SIGNATURE-----

--=-HKpoQF+MshVBjkKyg9gA--

