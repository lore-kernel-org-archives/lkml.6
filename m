Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDRXJN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:46838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753146AbeDRXJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:09:12 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 19 Apr 2018 09:09:05 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] rhashtable: remove outdated comments about grow_decision etc
In-Reply-To: <20180418142940.qd34y2ykjvmyjjh5@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble> <152403402187.16895.84802790561768231.stgit2@noble> <20180418142940.qd34y2ykjvmyjjh5@gondor.apana.org.au>
Message-ID: <878t9kqfhq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18 2018, Herbert Xu wrote:

> On Wed, Apr 18, 2018 at 04:47:01PM +1000, NeilBrown wrote:
>> grow_decision and shink_decision no longer exist, so remove
>> the remaining references to them.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks.  Is that Ack sufficient for this patch to go upstream, or is
there something else that I need to do?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrX0BEACgkQOeye3VZi
gbng0Q//XDvEOmoazxs0/J7XxadbkZzs4zmmKjpk92IlAsLQsynlNeJTO8gbLH7Z
MzSksfGDU52RcObZxYDgbQ4VtRW3qM7Y7psfUNIeWdtrZtXL3BkoJ6JkaCPCWf+O
6+0oJ3wbbFYU0e3QB9whvjbgXcmskdR8QsQ6Gzri1Bg4NZxpzReAczYq4M2yQ2yX
Z+rOb6y5ornTutSaw33xrxOs7fXulxieoQZT/uWa2shP5eM/p+InP+xZU65GzCbY
i3T6jwGgGXP+t5Veoum75j50ijQoUl8WlQMJb1C4psUtxaZiesr7s3EQVwNpstCw
jdBsfwl9OPLUg4DTPmREr5GTHwPk6kMPpsQNS63xjW/PZq7IntN8sEtM+8m0/3dv
YQZgYwd4sqfJswIupPc0HOFQCUTrniO7VX9TLrkygUzpKzmMSVyuYs2m2iYHzoK8
MjmjbyI+SdvuGECo38HbMjBPmLFRFDWEzl0OgQnH1Lu23zQICkviGwBBRbRekq1i
zIbGXsgDqFqpbh+C1gj+aAtCWVFQoRxzHjdfC7W1sORCgZ3cL3CX0z12dOUpadHR
VVmWgPyLNT7PszwG+DY50ng4eddgKh1HlFM2nC/rgg5bzXPt+yLjVY4Ml7jueRvM
F+flXSSoD32WOgup7EHeoF/epfBluXZqI009gXOsXvbf3/9rOYw=
=F9Y+
-----END PGP SIGNATURE-----
--=-=-=--
