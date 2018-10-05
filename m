Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826982084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826982084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJETWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:22:40 -0400
Received: from sauhun.de ([88.99.104.3]:38926 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeJETWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:22:40 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id A18172C146C;
        Fri,  5 Oct 2018 14:24:09 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:24:09 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] i2c: omap: use core to detect 'no zero length'
 quirk
Message-ID: <20181005122409.GH5433@kunai>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-5-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:08PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ping.


--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3V+kACgkQFA3kzBSg
KbYnDg/+Liwiu1pXEl0lzisDoU6OD/RdtfHGufCJOMjMfYgDXp3/tRgSSyfXHUpc
3sRdLsqcG1r6YX79ItTMt9a2DN+TxWgGsiROIsHasWhddcHfPAianibo3uqJQeNd
8WojGRtiplYVDJbiLUUHfG2z4te0xhh/ryXadY738/PQEmTsaYjbLwHC2ii5dcK3
yO14ZY4lXPqXqNwl4A5BPxDE+urMuoTVCyS/fL0Uay+YSXJxSCWYBwArNw5/glpG
lL0d4Rl0Yfq5DZp01iA9OwkOriNfUbp1v+s9QhPzwHCsVChcfj+R1P8PFkd0kKZk
Sb7VCvZBw9zJQL/ABXGzWrixR58LhKQHJIl3jbE5Lo/pX9B77H/+ZM16BcG401RG
JC+lCueVHPR2UTCQ1X5CllVlLSJSGPpj1pGbWW/1zmqkit7U9OiUGMA0glle0dvh
hCI311WhgSoyogLYokNvtFN/u4LRNi6B8PSBXo3j8XweqU+caAFG59M8nZgH6oDQ
8DvxH2c0mXFK3fT/VtBBO4D9LDFLniSryzbNkQVs9/5ofhP9RHbLtpZmaBAUoeCv
nfJWa2PPgtZnnr826/ZZ9stEoUZq1Iy0Lr+mTulEd6t2qD3vEGS3agvhu9Z/mFQK
DWFhGPTE1R5hqRItWDiPJfci4RMz+yBBP7bizl8mbR5HTeBppgo=
=2cYe
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
