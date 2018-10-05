Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809F7C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524F120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524F120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJEXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:07:20 -0400
Received: from sauhun.de ([88.99.104.3]:40316 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:07:19 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id E1C692C7EC3;
        Fri,  5 Oct 2018 18:07:57 +0200 (CEST)
Date:   Fri, 5 Oct 2018 18:07:57 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] i2c: qup: use core to detect 'no zero length' quirk
Message-ID: <20181005160757.u3tndasxf2burb74@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bhtjd42horfsmg7w"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bhtjd42horfsmg7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:10PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--bhtjd42horfsmg7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3jF0ACgkQFA3kzBSg
KbZCGw//SE6mTYuSe6OfLNIuF/2L6CFT1VxnZGqJV4MoPvbHgBewEKW/ZGx8+6hO
aQdW/KoJCoPJPj5TD6wSod5RJVKk+aSX0lj2olKEtQOr/vgr0oWF7Gx83LjJ99Ur
WUj0KSTqGoqjRgC0n8pE4KYr0jA/vngjUinJsY5VwNStyHriII2qD256hWfrFpfS
1B0G0RS8RdeneQAUGcK+w7/UsBNUpeCrjxS0hB2Pf+0fSD9HpIgoVXpqyYQyF1r3
eJyNxIrYXunUHb9fUGSpmgaaUwCMILR4xZB8m2Ck6SWyuDkABxZmIkQ0uCI+7ICk
jNzg13HF3f1UbM9ODpKgTzEWfxnLidn7V8I5+1BopD/fFnNlN7sfePkdjxQYDUvy
d1QOXpYAZmn/bF8XEs84mLZllQPwjE4Ai2Xs9N4jGEeXo4meNzt56QIwqHbelDt4
7KV7B05CY6lWr8q8FaXg67GmrplpqDB7TLbF2qGao9rHk/pgdsZ5JVv8zgjbkrw8
OvZ4tSXlZRnwAtVb3DLPerICUQouyeIXyjaqBk6G5p0ie5hqWjvSX+wnKrOajUMn
CYLgJXe2xixuMadjJ5TYjW9+5Uinnv9d7KINuuVLce0apHNmYFS7D4rJC6zqmOUF
mg7I35/TlwE34S+OXBlfSDI1sH4z7ByeEf8ZSQ2WCPW5r6BnxWo=
=3wWn
-----END PGP SIGNATURE-----

--bhtjd42horfsmg7w--
