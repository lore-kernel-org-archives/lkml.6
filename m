Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeFDQ3A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:29:00 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53508 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeFDQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:28:59 -0400
Message-ID: <1528129738.7898.109.camel@surriel.com>
Subject: Re: [PATCH 08/19] sched/numa: Remove unused task_capacity from
 numa_stats
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 12:28:58 -0400
In-Reply-To: <1528106428-19992-9-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-9-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iyLhsyeC315BqW4Z/s0s"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iyLhsyeC315BqW4Z/s0s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> task_capacity field in struct numa_stats is redundant.
> Also move nr_running for better packing within the struct.
>=20
> No functional changes.
>=20
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-iyLhsyeC315BqW4Z/s0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVaMoACgkQznnekoTE
3oNSlQgAs0lZ49RHIej+7hRIODVa6i7c1hJCADXuDo1UlkEy6ILZTbkOWMr3Mv4l
j5r4izBpQjakecpavp6B/hTbpkjOeycyrM6DmgHvY9BeFom1Ba/YtW8b9QFZKEXt
7JJ/EN1MdCY5PffSo1SOxNzb08CcMDKppQPxkLX7+80B97uybi61zAs3vNvlqeWE
QqzEghUbI6Px+a/A8xe+rkczpADTDKRxKFgzsgY1MjirPJpdY4OTUqAg8Uu3zapR
d7FbuLIC4UXRrVj0TvGOuRqjr8Ve/Us3F1M9kVPeARypFfVwPdj8Nt9z8ieHx3Fi
zkpWDKcSzRA3JFWQadc2x/N5OTNNYA==
=wt/N
-----END PGP SIGNATURE-----

--=-iyLhsyeC315BqW4Z/s0s--
