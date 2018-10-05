Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F6FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD572087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD572087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeJESmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:42:08 -0400
Received: from sauhun.de ([88.99.104.3]:38642 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeJESmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:42:08 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id 334502C7EB8;
        Fri,  5 Oct 2018 13:43:43 +0200 (CEST)
Date:   Fri, 5 Oct 2018 13:43:42 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Luca Ceresoli <lucaceresoli77@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 2/3] i2c: mux: ltc4306: simplify code to reach the
 adapter
Message-ID: <20181005114342.GC5433@kunai>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
 <20181003155024.16024-2-lucaceresoli77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20181003155024.16024-2-lucaceresoli77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 05:50:23PM +0200, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> struct i2c_client has a direct pointer to the adapter, no need to dig
> it out of the struct device tree.
>=20
> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3Tm4ACgkQFA3kzBSg
KbYqchAApTwR3RfHGkAFSxt15x1ZiLCI+PNHZyY+7iJbxtu3Pgr7IFpB5u4Zg64t
h8a7aCcr0NrV7c14Rl5KsP6aqVahfDPxp6KslF1zdeet3nW3s8RTfo8f4ETk6JbD
9BBKcR3SIMwBZ4whElH419CfR35PyjeRMZcJ5AtKT9w3AzTdeRl1/hI1P6PfqXtw
XgCNOikYmyVhJmNFPW5f7JiqZ1S2pysi8rpbChtw35C+OHlHap211mKlbYP8ylVH
nn1DjXymO8981+tm8o/5u2h4iDXtUttQ7PtscjEON+x/fJgtLrClx9Ry7uJLxHkX
d/zFpLpxPAKO1dYkbTGSwF4HUqljpX4oKOzquf/lmiwGsIkAXcCkynfONDdpvoGU
Fhm4nIjszBCZWLXky2uu+dasTEumUrbPLvTPQ63yQkt0sFCOIyhTeHFm0YJIr08C
/0RtAlKHrC3T/khWbN7cIqQXC+gPDMM/Gybp/bAPaXnASqmj33hDVL4XChWawtli
7H+lVUfDBdBfX348dgmitW05AORFp/4hyVleRTQaENNPtEk+pLd0Jhy8myAm92j8
7byFXIYFh6UxT/Td4WFWz5bv2VG0Md46Boa8Ol8yA/mPBWWcF6qNuMRx5/p6qHJt
3USUW63lmHvQrVdBgDug152gjoK4dp1w7Gop+wdCwUpPxQFnQ70=
=K/1k
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
