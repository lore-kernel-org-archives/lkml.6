Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeFDQ2K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:28:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53496 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeFDQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:28:07 -0400
Message-ID: <1528129685.7898.108.camel@surriel.com>
Subject: Re: [PATCH 06/19] sched/debug: Reverse the order of printing faults
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 12:28:05 -0400
In-Reply-To: <1528106428-19992-7-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-7-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9y5+sdOMRzZUDqGwXwdq"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9y5+sdOMRzZUDqGwXwdq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> Fix the order in which the private and shared numa faults are getting
> printed.
>=20
> Shouldn't have any performance impact.
>=20
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-9y5+sdOMRzZUDqGwXwdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVaJUACgkQznnekoTE
3oN24gf/YfUOjN9u4aK+zdwApBvL9VdhMXtemAu0E9JhXaidobBiwy1/S3kboqHd
LmdayTylsvrr38ruGkA72dnSikSVkq3tPAPErAqejMKWkmrwlfTNCzjUMn7L2A5U
qySLLjq1ABsBNnch7Kjc01K5cEaOVPS+eB63KW1Tw9UXTorg79DfpQ1BQ1FDDbhQ
bp3SRwxj75qHqnq9fsE4nxiiwdT3ktUmcr+7D+F9x2Zi3FQISMa35pigfxcmXPMm
blX63bqYhZ5+hf/dZXMZb6OAJBzNfD5tul6swRw7OMUWeCpBvJUI8PmoDpUnlZy4
EvXCKWmRZeydlBlIoTWyi0B0X7jA/g==
=I1hH
-----END PGP SIGNATURE-----

--=-9y5+sdOMRzZUDqGwXwdq--
