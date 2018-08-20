Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E42220C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E42220C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeHTMaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:30:24 -0400
Received: from sauhun.de ([88.99.104.3]:57722 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTMaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:30:24 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id 77BCB2D41AA;
        Mon, 20 Aug 2018 11:15:32 +0200 (CEST)
Date:   Mon, 20 Aug 2018 11:15:31 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm: dts: ls1021a: Enable I2C DMA support
Message-ID: <20180820091531.komc6ypyybnq22nw@ninjato>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
 <20180816084315.7857-4-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qusmn7mhub7xlmsj"
Content-Disposition: inline
In-Reply-To: <20180816084315.7857-4-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qusmn7mhub7xlmsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 10:43:14AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
>=20
> Gives substantial performance improvement for transfers larger than 16
> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
>=20
> Signed-off-by: Esben Haabendal <eha@deif.com>

This needs to go via arm-soc. The two other patches will be in v4.19
with my pull request later this week.


--qusmn7mhub7xlmsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6hrMACgkQFA3kzBSg
KbYi3hAAlkTYvh3KgXN65zQCR1k9LRHJUYwOBLwyRhrSHBspxnjiorSRk5mUDI7t
fnsfHkPbaiTbHBQpltJRy3rkmEkgqU/20DJLQsVwQGtGgjBvHgH/bqYPyA2cxjQh
lySVYZW2/a8ug88/v5AcrLQwe1QIvbXbyxO/Cabyv/WYeimjLahZr80Q7yGq+8OK
T1bVU467EEqPua91CJ5ORyWctb7Jx4h4qkHfvsIFafv/ltXKSWrMwQTCm18YLF2n
GLhbzJ+NBjtIqRM6mtv3KZfb+giiRMEnx1mfdet9N1T235rmcPtzqWtPe8csAkS2
w/gkHjiVi+ZSrBUS9koEAIG76PGXFxCVTxWszhFyOaIu/OFwwue5tPXeGMQk5Z1V
Mykhk6qeYpyWKcAPiR3nk/cX6/KKFjIzwoQOFpwsLGYCh6LA37oQYiNxYEgPtiAJ
xsIp69QPGy55ZI2qcTW99tTCwMIZD+M+zTD2RvW4davYczfeZ7j24mf75x3VYrQm
Wq9muxUJGu7+C4mrBCZFMxuTCq1erEREnGWpWdvHS+YyNf5erPewQhyHWfR1kAi7
DD0C8zXcuYTGN96enwXsYXuXlRv+QczHzNQZ8W1oq5rv8h3MxKBGTITZZ2lJigb3
6/AmRq5SvBYz8Cb0Y5mhkKYAZhVd+Rtn4NAEQ6USO20sVbyu26g=
=J5iM
-----END PGP SIGNATURE-----

--qusmn7mhub7xlmsj--
