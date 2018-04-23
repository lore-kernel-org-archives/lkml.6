Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeDWBlR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:41:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753443AbeDWBlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 21:41:16 -0400
From: NeilBrown <neilb@suse.com>
To: David Miller <davem@davemloft.net>
Date: Mon, 23 Apr 2018 11:41:08 +1000
Cc: herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] rhashtable: remove outdated comments about grow_decision etc
In-Reply-To: <20180418.214737.1146004592657647139.davem@davemloft.net>
References: <152403402187.16895.84802790561768231.stgit2@noble> <20180418142940.qd34y2ykjvmyjjh5@gondor.apana.org.au> <878t9kqfhq.fsf@notabene.neil.brown.name> <20180418.214737.1146004592657647139.davem@davemloft.net>
Message-ID: <87a7tuog23.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Thu, 19 Apr 2018 09:09:05 +1000
>
>> On Wed, Apr 18 2018, Herbert Xu wrote:
>>=20
>>> On Wed, Apr 18, 2018 at 04:47:01PM +1000, NeilBrown wrote:
>>>> grow_decision and shink_decision no longer exist, so remove
>>>> the remaining references to them.
>>>>=20
>>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>>
>>> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>>=20
>> Thanks.  Is that Ack sufficient for this patch to go upstream, or is
>> there something else that I need to do?
>
> One patch being ACK'd does not release the whole series to be applied
> and the whole series will be treated as a complete unit for that
> purpose.
>
> So if discussion is holding up one patch in the series, it holds up
> the entire series.
>
> So get the entire series in acceptable condition, or submit only one
> change at a time individually and wait for that one to be accepted
> before you submit and ask for feedback on the next one.
>
> I hope that makes things clear for you.

Yes, nice and clear.  Thanks a lot!

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrdObQACgkQOeye3VZi
gbmalBAAvq2/JIJcAlxyH6Ova3l0nuz6/8wZRpaEP27D19yy6hobqjkC6zYA13Wp
7C9smELfVR9J9/yLQgmWu5oETTnC3s6wmK+JhiAdAHElwwqm4XEIQBq76NMyipTn
gKGDNumStdXrHBHzvXZz6GmMFOJGY7Rg4/JGgs0uNaStxWJI60n/NjLbYpCB/84C
eSQQZqno8eZQQfQCqO6pzbJJ3mLmg2HYGQJ7TGedjpAcF0+OoO6gohBGmqbD6VYj
MusBwfObocteBQ/XrWSo/IHlDyzIJ0TWLqlnAe9TYeqK24qW+k2Fn4XJ5k6rS2tK
FMjuwRNHY2o9nhCRfDRG++CT7dg26qnVx8H9q0WmtNlyv6AKV2ji1+Edf4UlfQGu
BlVnhqzKTcsK6V7iDkeazhmOEQm0RWbmQ/f3xad0izfY0qu0Quvp17v4P5ImFNnx
AbO67MQT/zFGYYy4+9KJ4xY+1J7qiHTZa4BkcoECEYm0/fNeDZQsKb81vU43vrJ5
eRLi53VirAb5wGTIFuJW713r0RmOlUcNjB9P+4pE/Mg9y20aP86bL7EA2NzAXF6d
9cvBSAoZG6gPqHgWk+uUXHURpfI8Par99AlBpBN+T7mb+K/MeCbga8jAEe4zBM1X
AO9mEQYxnfjCuXLvsdQro/MheEnDAwIkW0dbqul6j1cGWaNs5dI=
=lZ4o
-----END PGP SIGNATURE-----
--=-=-=--
