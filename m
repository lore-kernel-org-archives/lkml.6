Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeFDSHO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:07:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53696 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeFDSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:07:13 -0400
Message-ID: <1528135631.7898.114.camel@surriel.com>
Subject: Re: [PATCH 12/19] sched:numa Remove numa_has_capacity
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 14:07:11 -0400
In-Reply-To: <1528106428-19992-13-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-13-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-D9Le25u1GuKC6qK0YXpz"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D9Le25u1GuKC6qK0YXpz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> task_numa_find_cpu helps to find the cpu to swap/move the task.
> Its guarded by numa_has_capacity(). However node not having capacity
> shouldn't deter a task swapping if it helps numa placement.
>=20
> Further load_too_imbalanced, which evaluates possibilities of
> move/swap,
> provides similar checks as numa_has_capacity.
>=20
> Hence remove numa_has_capacity() to enhance possibilities of task
> swapping even if load is imbalanced.

> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-D9Le25u1GuKC6qK0YXpz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVf88ACgkQznnekoTE
3oPHggf+LSwqqS4ENa3MIjfzkkejKH6aZRCf7oa+MNHCtdw9TIllgnzowXARtxzA
hOTvceVfKk7I38ktewatJhj6wJqwoB2xfJTSdsFB1iVb7zoORMzIfBt81cN2tybY
TopJe95+FAlla6DZjGNyMKFqniadkuomWW3jEBmqw6/H1eMdvRJ2BRaqHGWio7tS
inokceCPZvPyOofmIZXVwCX56wsmyTt8QBgNLEIBVHPm1GF2YzI51YzAQhHaORYC
Jz9iSzzJTbA1JcOOeTRE+Y+kvZoJ74xTxql6GAlTeB/MgX3XSvMDe7STGTkla8q7
5wqDLQqhTWHz7T+6S6HKfYu1AMYOXQ==
=cvV7
-----END PGP SIGNATURE-----

--=-D9Le25u1GuKC6qK0YXpz--
