Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeCVQcd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:32:33 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41504 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:32:31 -0400
Message-ID: <1521736338.6308.24.camel@surriel.com>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 22 Mar 2018 12:32:18 -0400
In-Reply-To: <20180314120450.GT4043@hirez.programming.kicks-ass.net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan>
         <20180314120450.GT4043@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y/S5VnbKsioU0Ki6729l"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y/S5VnbKsioU0Ki6729l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:

> On x86 we don't have to use that time_check_counter thing,
> sched_clock()
> is really cheap, not sure if it makes sense on other platforms.

Are you sure? I saw a 5-10% increase in CPU use,
for a constant query rate to a memcache style
workload, with v3 of this patch.

--=20
All Rights Reversed.
--=-y/S5VnbKsioU0Ki6729l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqz2pIACgkQznnekoTE
3oOk5Af/VfL4eE2M6rJbZhTpCRtourZjqnlezSFHYSVBYgHedhzCp5uFpM+ZGkP6
fJ0CtF8cFyjue2wC8Wlv1BgpUq3zpyCXcU11S9owrr8ZgcKL3KDaFLhtJ40UHzfE
/AhPMV1lx0yyC05yI+aP92JvF7AEYOKkL0ZMWarEW+AeCF5i0LmxE2MY1qQ4PnKu
k0kcJ6NojmwuNK4YeHVx6451z8lCmenTbyZfnbMPbA8Le6Bj6r90+FV9+DIZXbkW
zRZt+t9BFEU002PCQQzHMY/TDWJzVBxk6TqzN2R/tCma24gwx01mi4uzfSVq59n0
a5CvF+xS3UG2F34TauO7kG6NFvfUnQ==
=BhvS
-----END PGP SIGNATURE-----

--=-y/S5VnbKsioU0Ki6729l--
