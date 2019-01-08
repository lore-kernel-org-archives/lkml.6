Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3990DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0827320675
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfAHAJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:09:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:38367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAHAJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:09:23 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1tv-1h0ewS1r27-00Lj9n; Tue, 08
 Jan 2019 01:08:55 +0100
Date:   Tue, 8 Jan 2019 01:08:54 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kernel/sys.c: Fix UNAME26 for 5.0
Message-ID: <20190108000854.GD3987@latitude>
References: <20190107180306.16602-1-j.neuschaefer@gmx.net>
 <CAHk-=wgAH7QZrAyzaTV1-6MecaSdVkiowSZEM7qwa0L2oegpLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgAH7QZrAyzaTV1-6MecaSdVkiowSZEM7qwa0L2oegpLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:5q0ClxGSAqgtzwimn0uuqPnpoAa/ktzsZjRmFaBBZ6H/DdQpbD1
 wRc6YItH1q54Yc0rk4jHdD4+DDXvhY3WI3ZbAfReRHpMNtY+1xF3/UIBMt9NQMmH0IUm/i7
 54QRhsWI0U6h70qW/XhYk8/SLq4ADXnb4Jve6LePlRriTBv7woa7U23U8L0VPzjic+sYXVP
 CFGbakEAKkis1RNQoojyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lNqdgVyKOyg=:9wXSg8Adj4Sn+trvfdoWp4
 dBeoiSIj8hMfW/2opiGPLuVXbjT7Ginh5MaEzvwdFvbI7uCn8Hn654ttq1bpM45ttX+xRrpSs
 slXQGjgVv9R4+RXiBBIZSxukHZt4/HGjy/pbLEMdoRxn6T5BbSRF6AbfoiakfDpSKzG40COy3
 ha1Kbst9vZI6xDxhUTDkj7LhdX5T3U5s1MQtLGpFEAWg5WcZC3zwjgTcUhKJQRSV4PXW9YthX
 IC0zrotQ2brShlQNvnNjjEDPUhLY19dX8Kc8kDh+RtCjlg/hyCxTOHm/MCBF7q+iYxG8hYsH1
 pwpbzFNFxr2R0++XKgv0HfCbkl79/zxYE2677r43ghwI+3Y1sIgDX9zRRu7oMzXYkYhIRyIhT
 lmolIorM3u4oeV/FBEBkpEhro0T6MWSgNEG5Uze0Df4bRvHXgMxFSyUYrBW6+Rrc1wG/LouHy
 xtKElaeRFU6v2iC6OSVYJhzCPp27RF2Du4jnfITmIJ+zvD4NiOC7ebIMDxI2BxN0/JFSYIB1T
 C2Z6nQPAKFjA3C4GRjzJFSn1AGtatMG1CUZR3Uj8Fcf64oSTCANwGxtAZ5CDLOL+DrRzW5G4r
 LVIiKKhnyYVPZykxCx9cJrR+R3vj+Oijlx7qxeeAw7T6i/8hWI7z3YMekbGqzIrpTkT66U9zt
 31d//0WZiXtgortciQMXa5gR64qAvYK/q99FC98TzTzeN+EdoMgv05Z9FIdGKXuJq6ncPGbMs
 nXzwSSTOF9nrBkkp0mmeVPpoNKfkalhBdN1XSPgWgpYUjKSg3bEhfvcpRn12ycrtbujqlYLwO
 kbojLLzbAHo/XREcK+eZ3blGIUGr3g/S1bC4sYoKcKXXjyF98UL+MNRBeAZposG6ThX66UGD4
 Ab5hwzlca6nZgAzePa33VCKTWayzbbkuT/wrwd0cmm65N1HA7dfKMn77rDHRzL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 10:10:31AM -0800, Linus Torvalds wrote:
> On Mon, Jan 7, 2019 at 10:03 AM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > UNAME26 is a mechanism to report Linux's version as 2.6.x, for
> > compatibility with old/broken software. Because of the way it is
> > implemented, it needs to be adjusted to handle version 5.0.
>=20
> Do we actually need this?

I don't run any such old software, so I don't have a strong opinion
here; I just sent this patch because I knew UNAME26 version strings
would jump back without it.

> I'd rather let it bitrot, and just let it return random versions. It
> will just start again at 2.4.60, won't it?

Correct.
(Well, it's 2.6, not 2.4, but yes)

> Anybody who uses UNAME26 for a 5.x kernel might as well think it's
> still 4.x. The user space is so old that it can't possibly care about
> differences between 4.x and 5.x, can it?
>=20
> The only thing that matters is that it shows "2.4.<largeenough>",
> which it will do regardless.

Good point, I guess that's a valid appraoch.



Jonathan Neusch=C3=A4fer

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwz6g4ACgkQCDBEmo7z
X9tnPQ/8DrchH8ol/s3F9fk2ak3Wvu68ACF13dJTptlAzZJSdRkaFNGBKGoqkhVA
UvYhmsu3JFFxGlcarrtqV6OS41ReLVrmtTvscCfrKtXZKlQ5AW2vXnEpJpVUTKMA
3wJk9S59sYVQ04IArWtgOa6Eaoupul9G0/ferm8cgb78ZtxpFszlMPvXmuDpauNh
R1gfkL2qDXyOjVhgnobpFma8I+RBhJWIQrKJgGr1oZ+8qhtE9hBwRgiHobNmQ4YH
H9h22ZIDG4tOAsjSTXhvTsMkl/Tozql1UAypSZ4/dLsP8hAjobidDhk9Cg9qKjYI
8MdHY8dzlXzFfRuRyJU4JxNLHy4O5n5PsWZN/I8dJdhMepqsg13+elENxTXWoxct
z8/VSeeB0lG+Ipg7CarXVSbLxU9909JCkQk09bu9SjIPoc2tiQnjjVMmXlZzH/F8
tcZYAfov24e4Ciop6I1aAhHOcqhQzPb4SG5HQ6fwlM2R2QfL4gtJ+jhv0KZRJJlB
I/K4AbOwpuSmmWHX9TUwUApjyCCqi6saav9afdKgWEfi2Cxo2wqjkRpVjTimBWcO
wyrKg9lGTTXfroV5KEMmDWwQn69L08UlSus+B3k9mUXrnTB86oHPMK230VHivNLC
Yobf7EVHYqlvOfMhsu45wXh5wzx3TtX19zttpR908gE0O4dUJPE=
=XkwY
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
