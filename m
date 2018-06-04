Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeFDOxH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:53:07 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50966 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeFDOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:53:06 -0400
Message-ID: <1528123985.7898.105.camel@surriel.com>
Subject: Re: [PATCH 01/19] sched/numa: Remove redundant field.
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 10:53:05 -0400
In-Reply-To: <1528106428-19992-2-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-2-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UQFk+EWufA9+v19Eyu5Z"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UQFk+EWufA9+v19Eyu5Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> numa_entry is a list_head defined in task_struct, but never used.
>=20
> No functional change
>=20
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

I guess we stopped using that when we figured out there
was no need to iterate over the tasks in a numa group.

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-UQFk+EWufA9+v19Eyu5Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVUlEACgkQznnekoTE
3oPtcwf/bz8NagZXPTXbPU9DLDxKSG2nd6e8OSpLwKNNnyR3DSZMLPWFWY4GW0Dl
QZXeg9H+XJetlwfCxKZpVo8b1atNNjrBRJ4MgyK2GmHju5AiSa0djBPoMLGV0ogJ
RSq0Rg2D07+MLcFCV37Lx3c638uvz2PYwzyLVVr7It4vVU1mUxg3ZVfg90RZKwtH
IgDmZ9I06kmZCXfPfGI+Q4ImqtzvZSPklruI2XtN9cKqwOkt1lBgzILUZ3F7kez4
CfOO0FbO2hAnQaZgViA9uKa7yC8Nl3UG8WFleUjoZhJxW5OXzN4SV39kD87BA3YK
btvZXtbBfZKdmiSUBwacO+y3kBfWig==
=wZBL
-----END PGP SIGNATURE-----

--=-UQFk+EWufA9+v19Eyu5Z--
