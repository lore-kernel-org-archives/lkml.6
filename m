Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeCZV71 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:59:27 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55458 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:59:26 -0400
Message-ID: <1522101564.6308.61.camel@surriel.com>
Subject: Re: [PATCH] sched/numa: Avoid trapping faults and attempting
 migration of file-backed dirty pages
From: Rik van Riel <riel@surriel.com>
To: Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 17:59:24 -0400
In-Reply-To: <20180326094334.zserdec62gwmmfqf@techsingularity.net>
References: <20180326094334.zserdec62gwmmfqf@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lkDaE80EkYbqJxgLlovg"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lkDaE80EkYbqJxgLlovg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-26 at 10:43 +0100, Mel Gorman wrote:
> change_pte_range is called from task work context to mark PTEs for
> receiving
> NUMA faulting hints. If the marked pages are dirty then migration may
> fail.
> Some filesystems cannot migrate dirty pages without blocking so are
> skipped
> in MIGRATE_ASYNC mode which just wastes CPU. Even when they can, it
> can
> be a waste of cycles when the pages are shared forcing higher scan
> rates.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-lkDaE80EkYbqJxgLlovg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq5bTwACgkQznnekoTE
3oO4GQgAska7SC8vKLTmrk/8EU21o2WNzG/XPPoHUtd3VnhdpfURDAM+vfX7NTko
axrtXsTPil7o8VIS1Ycu/bHASOBIQjOMpNXAOJ66AaEK68w19lgPgvpuSzwWvvqw
ajJtBmIuuDJW/DftIhf2IoC52oi7iMRN0aLTmYV6JBH5PH81HpQKMTPL7VmQQ9qx
EiYtlHr8r2AugK0qzH86XCGQ804TMvyof3rvNGwzxKkCta2ZYY9Q9EnkFTIFDFct
dq8xjGOHwsqle60tP5dRKV9vDs42KRHwC1NsL0YFZzKMl/TS3c9Qvbq4VykZoNqe
LCQlkn7MbsE/exnLrRtbHBU+izxblw==
=5Feq
-----END PGP SIGNATURE-----

--=-lkDaE80EkYbqJxgLlovg--
