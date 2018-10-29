Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89ECECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE6E2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tjjVBYG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE6E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJ2VqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:46:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55178 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeJ2VqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rwZTerRkiTKrimTWT9P4+qnY8A7FVLlaR0G8/88Z0mo=; b=tjjVBYG7thRpd1Ac5FL9f5Ycn
        TvfmjbVYdGfI/tB6JumxsIJvC4/tBwFZlw7KS3Z/9DTdqmUZJXvE0xqGUnD1+j9yKCK87LPZBXkkJ
        Sp1qhsmBv0mnrAgHJMAGVI1G4F9EdBgzkvmN0xbrpwLG/yEiEsYr0hWCuIiyXyDY08i1M=;
Received: from [87.246.78.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gH76o-00015a-1m; Mon, 29 Oct 2018 12:57:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5F4E9440078; Mon, 29 Oct 2018 13:57:29 +0100 (CET)
Date:   Mon, 29 Oct 2018 12:57:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181029125729.GW2103@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell>
 <20181026203223.GC27137@sirena.org.uk>
 <20181029110439.GS4870@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eV9cGEf2bJwTs/8b"
Content-Disposition: inline
In-Reply-To: <20181029110439.GS4870@dell>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eV9cGEf2bJwTs/8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2018 at 11:04:39AM +0000, Lee Jones wrote:
> On Fri, 26 Oct 2018, Mark Brown wrote:

> > There's no *requirement* to provide the data even if you're using the
> > cache (and the cache support is entirely optional), there's just costs
> > to not providing it in terms of what features you can get from the
> > regmap API and the performance of the system.  Not every device is going
> > to be bothered by those costs, many devices don't provide all of the
> > data they could.

> So what do we do in the case where, due to the size of the device, the
> amount of lines required by these tables go from crazy to grotesque?

My recommendation when the tables get in the way of the rest of the
driver is to move them into a separate file that contains only tables,
these get big but they're sitting in a separate file that only contains
big data tables so they're fairly simple to look at (and generate or
whatever) and people working on the active code don't need to look at
them.

> > That doesn't work, we need to know both if the register has a default
> > value and what that value is - there's no great value in only supplying
> > the defaults for registers with non-zero values.

> All registers have a default value.  Why can't we assume that if a
> register is writable and a default value was omitted then the default
> is zero?

There are volatile registers which can't be part of the cache as the
hardware might change the state, and we have things like device
identification registers which are fixed but which we want to read from
the device.  This second set of registers can usually be modelled quite
happily as volatile registers though, we don't tend to read them often.

There's also registers where the user just didn't tell us what's going
on, either through oversight or because there's some code that touches
undocumented test registers at runtime for quirk reasons using a read,
modify write cycle.  We could try to insist that the device drivers
always provide a default or mark things as volatile but that's likely to
be an uphill struggle and more error prone.

> Ah wait!  As I was typing the above, I just had a thought.  We don't
> actually provide a list of writable registers do we?  Only a the
> ability to verify if one is writable (presumably) before a write.

> That's frustrating!

You can provide the writability information either with the function or
with data.  The tables code doesn't currently scale very well to large,
sparse register maps but that could in theory be optimized.  Few devices
bother providing distinct writability information as it's not often an
issue.

--eV9cGEf2bJwTs/8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvXA7YACgkQJNaLcl1U
h9CxeQf/W/V27ESuSoJs3wMr5mCJ3gVVxZd4wQ3AdCL4pMP2+epl+aQnWUQNHwY5
PKJ2DINsrzAvtNq0fSdHVIzaRI4pEwftPxWdQvMOiGompOv3n0LMR9npUkdHEkOY
dlLL5pgmWyTlesYy9FJ0d0JKUg1Y1Dwpl0mkP5zqmUpXdLAYBWITE8pQiRzCgmXQ
ME8NjY92OdQQfuZqoIOkckO/PZa58z2VJzWpRWnCEmzsyPh2YcyWe+SFga0+9F2Z
2iO1mGcTa50Xh5ACebTjOCFClG9swwnkVaOAwOGfEkl7Z3KbK4+b1ctGFECCM9vy
pntQ6p9rm6cjs47nPc/thANV2xLGJA==
=rOR1
-----END PGP SIGNATURE-----

--eV9cGEf2bJwTs/8b--
