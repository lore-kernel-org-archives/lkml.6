Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeFDQ2D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:28:03 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53480 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeFDQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:46 -0400
Message-ID: <1528129663.7898.107.camel@surriel.com>
Subject: Re: [PATCH 07/19] sched/numa: Skip nodes that are at hoplimit
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 12:27:43 -0400
In-Reply-To: <1528106428-19992-8-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-8-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nfVV5vLjtX6glTRLtVcP"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nfVV5vLjtX6glTRLtVcP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> When comparing two nodes at a distance of hoplimit, we should
> consider
> nodes only upto hoplimit. Currently we also consider nodes at
> hoplimit
> distance too. Hence two nodes at a distance of "hoplimit" will have
> same
> groupweight. Fix this by skipping nodes at hoplimit.

> While there is a regression with this change, this change is needed
> from a
> correctness perspective. Also it helps consolidation as seen from
> perf bench
> output.
>=20
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Good catch.

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-nfVV5vLjtX6glTRLtVcP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVaH8ACgkQznnekoTE
3oMsEwgAnVvSPnvsokDx3a1zFlxXi0PzOOAsvvwEn2pqzKrHYr0/jgjBmS8CvC0J
5/6dYnGlAO456zYm45JntmLvPbEMz9BLTX/VKN0EdQzQ7gfQLbfcL4F9fX4Tt9t7
Vw66GPlwtqss99F5VX3ppbwxUXUtdAWnoUGlgwhl0OxOMlPjDmLmWmk/cISpK2d3
IZcownXLkcvCMnG0xs/fnQSo4cRpXVHEFjlxuZfqTemURdVoyMl6BwFOKcNzeCtZ
26nOBbeUNgry6oDyo9at5UuFYIvnUW+B5tjNico5iagCpQd6xr5NacqaaZDrKBdt
3aypcIEU8jFTVzbIRKiyGnoxV5UYKw==
=8bQt
-----END PGP SIGNATURE-----

--=-nfVV5vLjtX6glTRLtVcP--
