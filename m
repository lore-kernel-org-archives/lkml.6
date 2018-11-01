Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E192081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wxCepGSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E192081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeKAVHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:07:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+5Ol0FkgtUsBlmsV899qrV7t6L/m0ec1TMayPN265mA=; b=wxCepGSQPUdA31KzKBH2HFx7p
        3SxGr7/aQcNF+3Q29AvFZYHXEJqViHjGKgpGDAkSpGKuqQ8UDxSCi3CiOP+ZVRry/nXBR57udodoh
        +nhWxRS9oAIKMNR6Y9yLFne1Wk+k0dIbSsFvdNznhDINlN25dYceYlRomWh1m3ImCBJUQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gIBiE-0005T6-4o; Thu, 01 Nov 2018 12:04:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D4611112260E; Thu,  1 Nov 2018 12:04:33 +0000 (GMT)
Date:   Thu, 1 Nov 2018 12:04:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181101120433.GC6425@sirena.org.uk>
References: <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell>
 <20181026203223.GC27137@sirena.org.uk>
 <20181029110439.GS4870@dell>
 <20181101102828.GM16508@imbe.wolfsonmicro.main>
 <71938ce2-00da-8ee0-c010-58c2670ee327@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <71938ce2-00da-8ee0-c010-58c2670ee327@opensource.cirrus.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2018 at 11:40:01AM +0000, Richard Fitzgerald wrote:
> On 01/11/18 10:28, Charles Keepax wrote:

> > So pulling this out from earlier discussions in this thread,
> > it seems I can happily move all the child device registration
> > into device tree. I will also try this for the next version of
> > the patch, unless anyone wants to object? But it does change
> > the DT binding quite a lot as the individual sub drivers now
> > each require their own node rather than one single unified
> > Lochnagar node.

> We went through this discussion with the Madera MFD patches. I had
> originally implemented it using DT to register the child drivers and
> it was nice in some ways each driver having its own node. But Mark
> and Rob didn't like it so I went back to non-DT child registration with
> all sharing the parent MFD node. It would be nice if we could stick to
> one way of doing it so that Cirrus drivers don't flip-flop between
> different styles of DT binding.

The basic concern I have is encoding the current Linux idea of how to
split the subfunctions up into drivers into an ABI - the clocks in CODEC
drivers is the obvious example, they might want to be in the clock API
in future.  If there's a very direct mapping onto individual hardware
blocks that worries me a lot less since it's more obviously reflecting
how the hardware is designed.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlva69EACgkQJNaLcl1U
h9CNKQf+IE/F7jz5M6NjKEd2X3SqqJcqEP1+CXLXM3Ny1yMI272FpSrV6BiQczlY
Xjy0PP+Y+YsAHtyfaybjuf1s5E8iq8SN5XJk5Tw1pobUGjIKAnESL/0h3bf+jHtM
xXAxmCfZP8QjJ/Gy42AgUf7+UWjycAmBlwqecvsViEUWRVctxsGYRh7ZrYrs7kEz
/pjPMF2QG8mMkqSVGvMQuPtQrKL3Thd/IMlzUmMCF8hpKKjEYe6Yj3mKvOD4X7lx
dnxvYEnH5tlkHiaVQ7K3JIJKTftVPwxdXiTDj0RePWR9mMdbKXe6kn8f272Yyer2
fkAY/Ak3PYDPAH7NkXmYVp2xz1naAg==
=l5Yg
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
