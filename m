Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D15BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BAC20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BAC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeGTW7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:59:21 -0400
Received: from sauhun.de ([88.99.104.3]:59740 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeGTW7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:59:21 -0400
Received: from localhost (p54B33241.dip0.t-ipconnect.de [84.179.50.65])
        by pokefinder.org (Postfix) with ESMTPSA id 80EB25E000F;
        Sat, 21 Jul 2018 00:09:06 +0200 (CEST)
Date:   Sat, 21 Jul 2018 00:09:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v12 0/8] i2c: Add FSI-attached I2C master algorithm
Message-ID: <20180720220906.qwkzucuhvuhmjske@ninjato>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ryrzjg2gu4kdrjr6"
Content-Disposition: inline
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ryrzjg2gu4kdrjr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 10:30:58AM -0500, Eddie James wrote:
> This series adds an algorithm for an I2C master physically located on an =
FSI
> slave device. The I2C master has multiple ports, each of which may be con=
nected
> to an I2C slave. Access to the I2C master registers is achieved over FSI =
bus.
>=20
> Due to the multi-port nature of the I2C master, the driver instantiates a=
 new
> I2C adapter for each port connected to a slave. The connected ports shoul=
d be
> defined in the device tree under the I2C master device.

Applied to for-next with Joel's tags.

I left the patches as is and did not squash them.

Thanks for the reviews and testing!


--ryrzjg2gu4kdrjr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSXYEACgkQFA3kzBSg
KbY+cg//fDcU6AmjH46Pckp1sA4vsvkVxiiEYz9TNZITwSBTB7vsPAY4hPmE8iFb
xjmY94CcLX0cyPCeOYQ7NGhBiPG3tAsHqmhFo87ZENgiZbnfgU3Yy424DGN8wrWE
oyVisjGaw5ewFDaG3PYruW978ARIbQhS46X4LbMA7iWAKUZIxY5Js8A4urfePEby
3OvgNul3ouoIl8WNi55ExBZX8CzTn1Q8j220Xl1/Dj4nNSw9xqV5ytgU+qXH+Xa7
30voAZIQhe28ahA6DZmo4jTtLX8WZKv/ySLXe6VV/tEr2GKXc/g1KdkNtNwLTLEK
r3M+ls/gR5DHw7dzxH4STyzNGur9VBaEMs9e62oiDNDhmafSBKPU1Clqp/GF1z1q
rVzeKPgCPJDlxxNG12uiDYR3QA2mUAp+KeZIttTe8Va/SGC9935dOEP2FktN9Txd
ZKWpv+6ezL3zjXSkt6qEBOCjVACnmvJDZhRSGkpxPK3J2dF61B3TzWjXmHatHTnw
R+8Fiv6lrsDaixmHPqA6pdsFncUyUqt3+XCpzZI4tTnA8tCyjtVA8NuWjlzWmWCT
DaMTg02FtFcp55EosqrnW+8X8O6G4HrOzeegHoS3Pkhyn5uZISMeOwGa+p5XVOza
elcKuH25eMj1GrurXWQzcwUpL4LFH8Cb+zeij/Qa8dt7s60/QvY=
=807b
-----END PGP SIGNATURE-----

--ryrzjg2gu4kdrjr6--
