Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5DEAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CAB2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CAB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755606AbeFOFcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:32:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755515AbeFOFcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:32:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E765BADBA;
        Fri, 15 Jun 2018 05:32:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@herbertland.com>
Date:   Fri, 15 Jun 2018 15:31:54 +1000
Cc:     Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH RFC v2] rhashtable: implement rhashtable_walk_peek() using rhashtable_walk_last_seen()
In-Reply-To: <20180615042331.3dmqi3bumzk6lu5c@gondor.apana.org.au>
References: <87sh63pakb.fsf@notabene.neil.brown.name> <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com> <87r2lmnj2c.fsf@notabene.neil.brown.name> <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com> <87in6wo636.fsf@notabene.neil.brown.name> <871sdjnwkr.fsf@notabene.neil.brown.name> <87y3frmhyx.fsf@notabene.neil.brown.name> <CALx6S35GgUOd0dPgv7P96wNNTv5pN7fij0pcAoccqcSWZhvY7Q@mail.gmail.com> <871sdck9ds.fsf@notabene.neil.brown.name> <CALx6S35Yr8th_LFoCLjEqfzti0cp7+7nKZC7KO3dzeQkU7c0nw@mail.gmail.com> <20180615042331.3dmqi3bumzk6lu5c@gondor.apana.org.au>
Message-ID: <874li4hayd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15 2018, Herbert Xu wrote:

> On Thu, Jun 14, 2018 at 10:41:05AM -0700, Tom Herbert wrote:
>> On Mon, Jun 11, 2018 at 7:48 PM, NeilBrown <neilb@suse.com> wrote:
>> >
>> > rhashtable_walk_last_seen() does most of the work that
>> > rhashtable_walk_peek() needs done, so use it and put
>> > it in a "static inline".
>> > Also update the documentation for rhashtable_walk_peek() to clarify
>> > the expected use case.
>> >
>> > Signed-off-by: NeilBrown <neilb@suse.com>
>>=20
>> Acked-by: Tom Herbert <tom@quantonium.net>
>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks to your both.
I assume this is an implicit Ack for
  rhashtable: add rhashtable_walk_last_seen()

I'll send out a patchset of all the acked patches shortly after the
merge window closes, and then see where we are up to.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsjT04ACgkQOeye3VZi
gbnIjRAAhoFgFxeVa1i9Tj4pNvweB7AJK/9cHwN1gIRqHR609tmU285IRy5wYsVK
HFJXBRDXLBwM+SCn7HfsmX5ykz4PsibbD0RaFY851UcOluHmAwa0l+CSI7+SWRjc
daFZ23cMOf8beQvf6POOfP7/jyZeAfqroakpwK/GQnlU5g6uzmUIaLclTk2rV24H
JC2CpBokwEoAnqWMYTNFQl3Oj7MKQRriUDCAwwxKzALe8aNIqj9ogh/IWF3N69Xk
9cwTWNKLTV1QjIV+jK5aezwghfFq6oYNLG2QgApz+9jcFykAwGDwXnxW4KOwbJdF
IRK+iPaDRQNu/Jvac5FC/dJS60FkDgSQ6scTHLjnxj59D/FWNZKBQ8O6TTW/nb5Y
/Zzy78doxZB6Koy4jgt+dt2cz9dllZwKAO20zr3+YIMy8GSw8pKfqrFdhW+5CQi/
DWkVtTY8ybMB+rMNgy2MFGLYDHNYxbsLgx9g8QPTdA8HRgKO/paBSaSkp5w5sDql
UbTAFG81x9AVTpjp6ds6DMNyYkbPHq0Im6kSf8y77Xh+1XqqkQtuD/3y4nEUeaFn
PehXt+ohu29JvHgMWnM/svqvHnQk7pdQt3wZTLfvrIvetctiEFSnOrB7+Rj4ErIc
awxn/FV6dCZtsy5uBqGK9NQC35/82fZ9vrPWgYQaWXthElGKUmE=
=8cXD
-----END PGP SIGNATURE-----
--=-=-=--
