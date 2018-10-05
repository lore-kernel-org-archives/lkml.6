Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD8C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616EA2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616EA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeJESmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:42:13 -0400
Received: from sauhun.de ([88.99.104.3]:38658 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeJESmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:42:12 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id C6B4E2C7EC3;
        Fri,  5 Oct 2018 13:43:47 +0200 (CEST)
Date:   Fri, 5 Oct 2018 13:43:47 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Luca Ceresoli <lucaceresoli77@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 3/3] i2c: mux: mlxcpld: simplify code to reach the
 adapter
Message-ID: <20181005114347.GD5433@kunai>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
 <20181003155024.16024-3-lucaceresoli77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20181003155024.16024-3-lucaceresoli77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 05:50:24PM +0200, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> struct i2c_client has a direct pointer to the adapter, no need to dig
> it out of the struct device tree.
>=20
> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3TnMACgkQFA3kzBSg
Kba+vw/8CTJlV9gd7nykfq/kB8eIED292pPk4oEmwa5WNy7URJngtKoxTYRcxUYC
omHDLeNscTF2LZ+Dpoqm1W7aI9dG12JSl5YEPxBJNXTKUWfvYFt0daaVU9L2SyZ+
JULXcuZCBLOTmvzvArJOvJO09tc4MJwExVlN5+FAyn+UpbhAOHxdW6rNbmkxUg4Q
aZznZ1KYC61liY6VJF05EODu5Hz9gRmZ26b8EMcc7v7bIdifT1pY/R1QMy5kqGJy
qS8SRlO1tbuaVc3HIL/I7XIOo6kI3OSqrZuRzBn9rCdo58K8adsB/1pj9BFbTam5
NMm1+IC7ib0oJWSWDr6owmJPk9vgLz5JsxVM/n0KRJ7WI+scP5MGDw9U53ksvWE3
9sihWdzJI2IOkafu05nfzBchTLzWeNcGk4j1DyWUZQTD1MWq7KYPQZDAOUaEBeYW
3B0mA67g+1iCErdZpTgMxCV9QPp2T2X1Ssd6sL3n0UHUfvZ26czKN6byFh64LsNC
mjhEjzWUHh3dLX8n8iwFhLZhBo6u9o/uavREaqqJLZYGnYfBrkPCp3NSDJHO/PPt
v93IdzJEyIn1Bm2jD2YSntmUrqUE27OVhHouErKIrfpQddHsFF3A8Wo6WeAv9o25
nRlGT9qRmBzyaYDTCNWxvnCoJuG5GRrMZ8/biy/lsWj6BpbV3lY=
=XVRz
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
