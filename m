Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94994ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C51920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wrcYVu6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C51920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJYSpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:45:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52884 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeJYSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b5E7QjQfDDGJfTZb23d4dz34oPR/kFGmLT8xj+lJ4WA=; b=wrcYVu6V/PJQjyx55IJbXtx+t
        mxj8a5PBKMSd/zhTPtp+MSPXcR4s65f2QWBf3+sTPVbRIFf9sNHS/ZazipVtoIK/p18T+/qnf3f8O
        8zomZApK6C7g87dG1B0244xUgTgi7pqsThmRzN7cuQMzzk7gDD2Su2btcmtbgFpOH1Fuk=;
Received: from [185.7.230.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gFcdG-0002Ey-AS; Thu, 25 Oct 2018 10:12:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 99158440078; Thu, 25 Oct 2018 12:12:48 +0200 (CEST)
Date:   Thu, 25 Oct 2018 11:12:48 +0100
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
Message-ID: <20181025101248.GT2103@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xFAlB6MquX7/xpZD"
Content-Disposition: inline
In-Reply-To: <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xFAlB6MquX7/xpZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25, 2018 at 10:28:16AM +0100, Richard Fitzgerald wrote:
> On 25/10/18 09:26, Charles Keepax wrote:
> > On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:

> > > I'm really not a fan of these so call 'patches'.

> > > Can't you set the registers up proper way?

> > I will see if we could move any out of here or define any of the
> > registers but as we have discussed before it is not always possible.

> Also patches generally come out of hardware tuning/qualification/tools
> as this list of address,value. So it's easy for people to dump an update
> into the driver as a trivial copy-paste but more work if they have to
> reverse-engineer the patch list from hardware/datasheet into what each
> line "means" and then find the relevant lines of code to change. It's also
> much easier to answer the question "Have these hardware patches been
> applied to the driver?" if we have them in the original documented format.
> It just makes people's lives more difficult if they have to search around
> the code to try to find something that looks like the originally specified
> patch list. We don't use them just as a lazy way to setup some registers.

Further, the main intended use for register patches is for registers
that the device manufacturer has no intention of documenting beyond
providing a list of register writes to be done on device startup.  The
common example is test registers with chicken bits that turn out to have
been needed, it's not realistic to expect that vendors are going to
start documenting their test registers.  It's normal to see these
applied only on early revisions of parts (eg, rev A needs a patch to
adjust things to match rev B which is the mass production version).

> > I really feel this isn't the driver you are objecting to as such
> > but the way regmap operates and also we seem to always have the same
> > discussions around regmap every time we push a driver. Is there
> > any way me, you and Mark could hash this out and find out a way to
> > handle regmaps that is acceptable to you? I don't suppose you are
> > in Edinburgh at the moment for ELCE?

> I suppose if Mark was willing to promote the regmap drivers to be a
> top-level subsystem that could contain the regmap definitions of devices
> then we could dump our regmap definitions in there, where Mark can review
> it as he's familiar with regmap and the chips and the reasons why things
> are done the way they are, rather than Lee having to stress about it every
> time we need to create an MFD device that uses regmap. Though that would
> make the initialization of an MFD rather awkward with the code required
> to init the MFD it not actually being in the MFD tree.

I'm not totally against dumping the data tables in some other directory
(we could do ../regmap/tables or whatever) but I fear it's going to
cause otherwise needless cross tree issues.

--xFAlB6MquX7/xpZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvRlx0ACgkQJNaLcl1U
h9DPFQf/cSBA75O2AECIb92W4m3AIRaVsRSzNCzhKdSW4q0UKfU/W6EYBJmzBf+J
+6y1ob7KRu6M8QvfCdo7k98ccymhfLkz6htYoDGPr8GNoeBaSw2Q5leE5db0uXWX
81U+e1+bLp4UoPX2eLN1jq40l/swUiTDksnA3N+4si5LeiyOHq6mZaprIER6N1bQ
XF4QlzEedOdquIDW3NsRm7A8Rhw2Jhu4Gd5kwO6DvYl8TzI//EKp+1XqxdyqorbY
t4QwAwf/cLcepVhWNM6ej9y1ZuHiQiu9lcsU+AciM+Nmo2lghBcE/92L2oh6U84n
df6D7KQaYEowq8jlwDOmRJyvpj9+XA==
=gjfa
-----END PGP SIGNATURE-----

--xFAlB6MquX7/xpZD--
