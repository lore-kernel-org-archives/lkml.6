Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeCEPaz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:30:55 -0500
Received: from sauhun.de ([88.99.104.3]:40012 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeCEPax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:30:53 -0500
Date: Mon, 5 Mar 2018 16:30:51 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH] i2c: core: report OF style module alias for devices
 registered via OF
Message-ID: <20180305153051.w3b7ern7u4e4fy23@ninjato>
References: <20171203214050.11482-1-javierm@redhat.com>
 <CABxcv=nQpd-RPPzWbCpdWQjK7VzZyXtWSCTB3JHBA-uLygoC+A@mail.gmail.com>
 <CABxcv=myJZw1zVtbkSW-5xhxeK71YtV3jOvBdGgoB92m67R4bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tiovcelid4cmgb57"
Content-Disposition: inline
In-Reply-To: <CABxcv=myJZw1zVtbkSW-5xhxeK71YtV3jOvBdGgoB92m67R4bw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tiovcelid4cmgb57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Is this patch under your radar? Should I keep pushing for it or just give up?

Applied to for-next, thanks for your patience and your preparational
work needed to get this upstream!

We will see in linux-next if there slipped in some new drivers which
need fixing, but we have a full cycle to get them adapted.

And hopefully the benefits will shine through right away.

Thanks again!


--tiovcelid4cmgb57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdYqcACgkQFA3kzBSg
KbZi5g//VOXpZz31mrqXxCY3f1K366PhyfmiYs7mJKsUTkS21hnHVyviSv4LOgQS
XmaDFY7uXuDey37z2KxW7AkrwjbUd+B2kxOkdwwJ8z9K6bu4VRsUoCZ4pM32SQuQ
XPptjScEKRyXMO0SbHwgihBrQDhuHCpGWccy63AgyhCQfpxI6hgx8ZYMEu108llU
YzQTTzUvYUxrxuWxFQMhSPxO6Irmpu85It5ttD2OECDDWODf9NfdrkdS/iPiYz5G
oOLirpI+FzN7CXYNU1kCybbkVEE7byGzb2Ux1LrAKBuJU+TRlRgmVb9ZcdBtwbQn
IIr3EQF7FqKNYWlOfGJvKsEkwds/vugVJ+KIEv6uw9dSVUhwB2BSSyZwboBooPVI
AEh5xcqPx0r9SQrXa1kAOoNm33M+l5mJ6oro0wpJpg9Qq4aAWSSG6MKTRTZLo8AS
97ksHkzkW8ozTG/zGsjnhZPYSjfbdN81t+mNcX1ZkFMFM4Vl6rYMEueUfkDKaFfk
vaDTKUzJr1uL4uc6BmtBnekXBeJSP7bBzGMwJnZFG7veuyNlosrsSyaw2gGcnjoZ
sxhCvERGyJdTFECVGwG9tqGBgcIdDQkprqT3AbMmyovDUbhQwDrqIYVy7fecy2lS
0t4eQOaFFBn17e81tRv6q9g/mRhzs9360RWR2CMfiLEseGHdFEY=
=1N9I
-----END PGP SIGNATURE-----

--tiovcelid4cmgb57--
