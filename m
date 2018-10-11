Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8791BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0CC213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0CC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJKOz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:55:59 -0400
Received: from sauhun.de ([88.99.104.3]:37020 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJKOz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:55:59 -0400
Received: from localhost (p54B3377B.dip0.t-ipconnect.de [84.179.55.123])
        by pokefinder.org (Postfix) with ESMTPSA id B83532C78E1;
        Thu, 11 Oct 2018 09:29:57 +0200 (CEST)
Date:   Thu, 11 Oct 2018 09:29:53 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Input: elants_i2c - Use DMA safe i2c when possible
Message-ID: <20181011072953.ddkemhnntjisli3q@katana>
References: <20181010200017.255874-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwog3fv4rce4k2cs"
Content-Disposition: inline
In-Reply-To: <20181010200017.255874-1-swboyd@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zwog3fv4rce4k2cs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 01:00:17PM -0700, Stephen Boyd wrote:
> This irq handler is always reading bytes from the device into a
> kmalloced buffer, so it's safe to mark this transaction as DMA safe.
> This avoids bouncing the buffer when an i2c controller decides to use
> DMA for a transaction.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

For the record:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--zwog3fv4rce4k2cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu+++0ACgkQFA3kzBSg
Kba4NRAAofDHd5TAtWWErJsTokqVF22brVt3tiWWsFsvaUUUoY+sWFFxW+DUp6xz
VAHE9zRD01KC0V3M4ywoi/noKZFKA3Zt4eIPzqZ0h6Jpw/X+5sFP/74jtFxjYXR3
WBOQathe6ybSo89EOTBgH4xlJexE23md9gSHFACs09HvBdE7ZPexdnvwd8sEg5V9
BiEe7cqdipdhLWMNIa2jNiqAXEXib6FpwswZ6jSzNABDOG7kyt5B7aGDpFwzGufs
rvFD1iS6y3p2EDrEvkVoG1XK0m8H6aN9dlP2FvrLlfyMbwR/J2HzdUeLCSHd1pZS
KGLYCSZNIWs7aCEE4qQt3fJCv9+ovrn/2hrYi9GwLeZg/gogOmedPaWdBd+m8dHY
03lEbEmwZL4PggTXU0S0hHi7ILwRvkP3SI5cdD6T3YLOFO1/wJerNmIr0J5EFw5f
xvax0BTFz2DwBXPGZhuj0LuVE6seSWI/qd7T+OZRhhYoWxzXZpi9qVyHS7FaJ9Y8
Dn4MXH+uleTdzrCv/s1NEHRdm7kIbuUEGzE02VgH4cgS8a3eyi2ilPBeJWHWvKte
Ylj5BWZb9rYkdCB8Y2hSL9LnCCAbC152Cy6pneHzZI/BzMfFEnqfO0Rf42Cd3kj8
JsgYig65UkDljCbWM7+hN7WGNeveZ2fGaL2NfJkDMbe5U0p+WEY=
=rC5V
-----END PGP SIGNATURE-----

--zwog3fv4rce4k2cs--
