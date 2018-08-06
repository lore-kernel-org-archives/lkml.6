Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2868E21884
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DLQS4tTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2868E21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbeHFSOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:14:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47662 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbeHFSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1l2kTpL3fcWCU243cZZT2hUpFGkPsvcYEmhJN31zs00=; b=DLQS4tTP1DwmAWrbWLyDvedyt
        gj6ZMC4QUzkG/7lUVnetYrY4HgXC7aAkqb5EYwOpXt9XC+Rp9u39eQqr+21OHlIc+0ywwbamBuO3c
        YD2c76tZJDKKR90DDP7XfxE9VvH9YHwlOw0cw1Y45oZSOvLSC6N9nOmhpUhZI2dR5pxdI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fmhzH-000859-0Z; Mon, 06 Aug 2018 16:04:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 56211440078; Mon,  6 Aug 2018 17:04:02 +0100 (BST)
Date:   Mon, 6 Aug 2018 17:04:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "leonard.crestez@intel.com" <leonard.crestez@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180806160402.GR2414@sirena.org.uk>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
 <20180806143901.GP2414@sirena.org.uk>
 <1533569985.11050.9.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
Content-Disposition: inline
In-Reply-To: <1533569985.11050.9.camel@analog.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2018 at 03:39:53PM +0000, Popa, Stefan Serban wrote:
> On Lu, 2018-08-06 at 15:39 +0100, Mark Brown wrote:

> > I suggested having an explicit operation to check if a register supports
> > this mode of operation when I reviewed an earlier version, I didn't
> > notice a reply on that?

> Sorry, I got confused about what needs to be done. Should I add a new fie=
ld
> to the=A0regmap_config struct which will be checked during the function c=
all?
> Something like=A0can_multi_write? How do you suggest it should be called?=
 Is
> readable_noinc_reg ok?

Like I said last time I'd suggest making it more like the readable and
volatile checks - I'm fairly sure I've seen devices that don't
autoincrement only for some registers.

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltocXEACgkQJNaLcl1U
h9CPEwgAgJgNRHOcXvq09ljPcT1HbHSUubDS7V9azrcS1ep0ybNo22MQvjqIZnbU
8GZasf4D4qUuVuswM7kMLuJsgiq6JyY8CNJYWluZWXAmqYo6jSrX5fVwjimkSdjT
DJj6MqjheDNKEmkToR2NNLbWsVC34Ky8Fy7qOg/xiOTl9A9ZTIq1PIeQoFeafK27
sg6+IRkm1Mad9Eenxu79DXxj7wZaJMCX/e6syQSuw3yMYMBPdymPXibIuyS6EsCX
91r/8xKnhERTBDV65dNfoo+XNCk3kHAIrUFw6lr75G9qz/Vk9uM6p8RiQDoQjlzF
UKNfObAIqgWfy+WcqJoGVjCVYQLjGA==
=08kk
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--
