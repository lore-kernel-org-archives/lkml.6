Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8ECC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF36F21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF36F21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHXQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:22:15 -0400
Received: from sauhun.de ([88.99.104.3]:40366 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXQWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:22:15 -0400
Received: from localhost (p54B33931.dip0.t-ipconnect.de [84.179.57.49])
        by pokefinder.org (Postfix) with ESMTPSA id 4AD3E305899;
        Fri, 24 Aug 2018 14:47:42 +0200 (CEST)
Date:   Fri, 24 Aug 2018 14:47:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] macintosh: therm_windtunnel: drop using
 attach_adapter
Message-ID: <20180824124737.pdiktpor5ofpfo45@ninjato>
References: <20180821150240.19964-1-wsa@the-dreams.de>
 <20180821150240.19964-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exskspteuohzfyut"
Content-Disposition: inline
In-Reply-To: <20180821150240.19964-2-wsa@the-dreams.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--exskspteuohzfyut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 05:02:39PM +0200, Wolfram Sang wrote:
> As we now have deferred probing, we can use a custom mechanism and
> finally get rid of the legacy interface from the i2c core.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--exskspteuohzfyut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt//mUACgkQFA3kzBSg
KbZYGg//U81jqO+xJivJmJi18OYtguMoRFghC2VH4BjYdMP9yyy6JsXqr63AIRF4
IBkR4zmRtm5xU8IOL8LAHBIOHQ5blY1HvqXG7y4uV2X1L7vpSD7vneKR0noJg/OC
k2DFPyFdIahTkVvhYAbJLo/ypmpccWYP9ySkGIl7haLktoSGKkZJCT+lRl6qKRx+
Jw0aOykpHgVFt/Tg2WDcMwnM+jpQwZ0pGmzdZ69bQT4kH/bUJJDFa+fGHSzw0GOj
c6si5muNsw/Yj12IBRlXYJf7Xg8C7dZLkqqWeX7wYlvOSuAaTksJaZ2ZrNB22hiD
k5UsyNgONl6cfT2gvXdidVk5QPB5NkXgTLxejeLp9Lk8kD5jpqno+eOpD8xTVjQv
0POmu0fAkgla7Hmaq5xCj+8aXNUwogpInnUcE7R4/4tYs+nOcAYRdFMnTR/olHUP
LfEyYeX+0WX+04IVZY5BrxoyNJyRuxJuqQ1NggifYl9xPwMSSdSA0Ba6uvFh3G9F
HvpG/PYZmzHS3T7pmFVe25Jm0implMScwP7OrUcYeSMzOdz4+g7rEDVYGF+Jg9HP
oMLGrZRwnIg1ZPzRwVV7oOs73V03q3TSuJbN5W/aSb9vE4K9irhvL7+4JlwwaNfE
teacpRRlN3sboLv+k+jG23J4XcPXc/bjd4FIcdk6RRBKZTiuTWk=
=Qivk
-----END PGP SIGNATURE-----

--exskspteuohzfyut--
