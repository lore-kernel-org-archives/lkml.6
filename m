Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CCAECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5844020836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OcWqm1D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5844020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJSU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:27:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=faQiBSpR0QmwjrLMPUvKhOP6fjDzGqi+Sqy0bsHPjlg=; b=OcWqm1D290UzhN+vZ7NMFvpnj
        dHnYg7Re4RPv8YuA0fPPZg89RMxQwZrl/xj/SRyffVcY46tjdy4bPg4HMOyWGPz64F3aq7ZqKSY7a
        pJSBXeY23UqwTFVKdLFKAG8t6nFeCnurPViumbfsnJiV+pnlaAYPDZrjnXtXi9JvD2T7w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTmJ-0008TT-68; Fri, 19 Oct 2018 12:21:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D36051122548; Fri, 19 Oct 2018 13:21:18 +0100 (BST)
Date:   Fri, 19 Oct 2018 13:21:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] regulator: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181019122118.GI5895@sirena.org.uk>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
 <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
 <20181019112622.GB5895@sirena.org.uk>
 <20181019121920.GL1653@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline
In-Reply-To: <20181019121920.GL1653@imbe.wolfsonmicro.main>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 01:19:20PM +0100, Charles Keepax wrote:
> On Fri, Oct 19, 2018 at 12:26:22PM +0100, Mark Brown wrote:

> > Please do not submit new versions of already applied patches, please
> > submit incremental updates to the existing code.  Modifying existing
> > commits creates problems for other users building on top of those
> > commits so it's best practice to only change pubished git commits if
> > absolutely essential.

> I don't think any of this has been applied anywhere yet.

It looks a lot like

bef9391cbec547351c6a13e52f3a26bb2d271ec7 regulator: lochnagar: Add support for the Cirrus Logic Lochnagar

in -next.

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJzD4ACgkQJNaLcl1U
h9AKnwf/UDfl1GLXVqX2b9G5IuHvIFzmhxgxkZdhFkTn+1So7ZJHnPi8Xokpa69C
ZgL8GAuIu7ZtvTJyOgNKcZQisyZnNRhAzn59ZFec4eOkl2KahYhB88iST4BPmQ5E
axOdt6c2/3wTJlvZjwmclUdulp5GGR7HB0omIhDPGaKu/5RDMyPrVNLl+qqZIXmH
x4mjWvnNd9i5BeczEl4UkmqVXx1fGIbBSDbMHq3sfSRyjyTAwTQBN0+tfOB4Zpon
muXfHs1x4cyTecQngjhlKQoXl5KhGX36eNrjaPqxrCMjQ3UIVUxDa2CvdPqFV5lv
FBbsC/EwWntiepoQS2f6XT0XtpJjaA==
=FmEB
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
