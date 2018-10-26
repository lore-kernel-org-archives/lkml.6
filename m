Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5323AECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1D20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oyxsJg8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD1D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJ0AZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:25:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0AZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wzv1EIHIo+xf7l4NuQvWMa9Y1tL7EVaHiE9dv/HkItQ=; b=oyxsJg8lYNhBrd36t4RcKr1sG
        utISkXj0D16nPsTZVegJuFOj0zBXcrgWrPnOISVgDNTb2hQEBv1ZiqFuJw6DuHhLtUo90GcrVzanL
        Bsb3vsF9+2CO+uHZFUv25u/ELdMnWq+HjhEoBbl0uIFiyT0/a9cSZ0VreX1apaWyBuLfo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gG4L1-0003oi-QV; Fri, 26 Oct 2018 15:47:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5A8C61122667; Fri, 26 Oct 2018 16:47:51 +0100 (BST)
Date:   Fri, 26 Oct 2018 16:47:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181026154751.GA27137@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <20181025124905.GF16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20181025124905.GF16508@imbe.wolfsonmicro.main>
X-Cookie: Kin, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25, 2018 at 01:49:05PM +0100, Charles Keepax wrote:

> I don't think you can sensibly get away with not supplying
> default values. You say most sane register layouts have zero
> values, alas again you may not be the biggest fan of our hardware
> guys. The Lochnagar actually does have mostly zero defaults but
> that is very much not generally the case with our hardware.

There's large classes of hardware where it's just not generally the
default over all manufacturers - things like audio CODECs and regulators
that have to represent continuous ranges of numerical values have to
decide between a helpful representation of numbers with a non-zero
default or having a more complicated representation of numbers which
manage to make zero correspond to whatever the default value is.  It's
also quite common for booleans you want to default on.

> One of the main aims of regmap is to avoid bus accesses when
> possible but I guess on the first write/read to any register you
> could insert a read to pull the default, although I do worry
> there is some corner case/flexibility that is going to cause
> headaches later.

It will actually populate the cache from I/O if you don't provide
defaults but it then can't tell what the physical defaults are, we could
read back from hardware but then we have to sync that with the hardware
being reset and if you read the whole thing back that gets super
expensive with slow buses.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvTNyQACgkQJNaLcl1U
h9AgVgf/XQjp7lDEmVFGgiTZTgLJZyMHMn1vB7lgsxxiFxVBlNiZr7Zg8BiK8cT5
1uTf6Z+Wn344YWwQ/Rx08GaLdcvfRKBPKQi6SGHpZ4pj5BJaOCobq3UlSyA9GXhO
UPyMpdJa3yzXaF0PV7w6kXkYi0fJe9jVe21b06fJweZmCF0fGaF4WIAUDDn3B947
Uj+hZywPa3UuH04sE/PybfrKrGtJz73U6tSo/FcXhKdPEfVy8KL0FgWXQiV5BPUi
xLU92y/gX8mS7L1aVPAoIkTgESA6sS0VKD4YLWjm9/1nWI1mghsTSSYfRqGJurvI
lXhYY+HkMGRV8jaOE4o/LIYmz+ow/A==
=EHBh
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
