Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0129F2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfAAKXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 05:23:36 -0500
Received: from sauhun.de ([88.99.104.3]:37988 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfAAKXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 05:23:35 -0500
Received: from localhost (p4FC2385E.dip0.t-ipconnect.de [79.194.56.94])
        by pokefinder.org (Postfix) with ESMTPSA id 1D11D4A577E;
        Tue,  1 Jan 2019 11:23:32 +0100 (CET)
Date:   Tue, 1 Jan 2019 11:23:31 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        Juergen Fitschen <jfi@ssv-embedded.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190101102331.GA1687@kunai>
References: <20181227151311.20107-1-ludovic.desroches@microchip.com>
 <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <20181231105348.GV10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20181231105348.GV10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Perhaps, you can use SPDX instead of boiler plate license text in the files?

I think we can do this incrementally.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwrP54ACgkQFA3kzBSg
KbbE2A/+PijOZlG7bdPITEsWTqpQPCRFC3Q/mIjNjArm2EVWEkEOT4fIdD/O3X/h
DLv9TfpHkoJeaqywzO3/Ej6KHGCKlugAnBoddd6PeVVZd/2bm0wEwu9CoyOwsv19
bFiUaRad2VZHO4cZgfefYQ58Hsc0Iir5NAsyC4Je09Um1rZDoVK//Mal43UJRLFw
HCeN7IDnmCCBa1/GKMcYNIsLVhwprmx1sQEF1Z6YWPnf3ro9cSACLSSxbug8a1sX
N1XTOm9D3OpM1NAbD831dZqz+YEGeUx6TKg89DA24E5EXYsHJu5EsrJ9doEb//3O
tk4ngskiv/Rxlt/+IZsQELV9pnTBOhDUPOMal+/TVvQOkTAb5TrUn9aNO90AdqIX
YxKqffIhBX7e4MAZ23nEKr1BASf2dNpExpUSqrYDlhyXR2LKT8qlMAWzi18pzSU9
XYDl+q6okz8Fe0d7pJVK44G96hw1X5ZlQX5e4z54XG7kv7JdD2CajTWS1XMkoQ4G
oIk3waB5IpZmCdi6hw5BONRoYu7/hnm+rZzYn3Dn93mcNO8vjnDVvoN/2v1SmXE7
SXWP2L6OVckmZ17cPI6HiQmDG26oel7/AcKeHX3b7oQUqV521acifR7LHps4+tST
qCzIJ4vMrbCRMSYComRORM3yR+zMYp7FaayA1sX0Gqk3w5WsxyA=
=JbS7
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
