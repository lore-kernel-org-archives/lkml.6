Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E59AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146BF207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EORurmrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146BF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeJ0FK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:10:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35452 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeJ0FK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QWb+3x/U+n8WXWQoSAO7xOhrKRdYbcAlsCHRQsVRf/M=; b=EORurmrcTHXtI8GGhGNjwQzBP
        YujIoeX3pEoK5Mbhp30kXPU6RMotdFcaRbgG+XE++pL2iuS1184afoyQTAN7aJYWKZ4SWEuv6ww/F
        0/xmJdxSqGszLNQ7tuxZTh1rM0gEErf+9V5BiHAQEnazcOyQkf4V1P2qXN3fiqLoOQHLA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gG8mO-00043u-Bp; Fri, 26 Oct 2018 20:32:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 540F91122667; Fri, 26 Oct 2018 21:32:23 +0100 (BST)
Date:   Fri, 26 Oct 2018 21:32:23 +0100
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
Message-ID: <20181026203223.GC27137@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20181026080051.GK4870@dell>
X-Cookie: Kin, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 26, 2018 at 09:00:51AM +0100, Lee Jones wrote:
> On Thu, 25 Oct 2018, Richard Fitzgerald wrote:

> > Largely the point. How long do you think it would take to populate the
> > cache if you had to read thousands of registers over I2C? Boot time matters.
> > Deferring it until it's touched can create various unpredictable and
> > annoying behaviour later, for example if a lot of cache entries are
> > written while the chip is asleep and the initial values weren't known
> > then a suspend/resume cannot filter out writes that are setting the
> > register to its default (which regmap does to avoid unnecessary bus traffic).
> > So the resume could have a large amount of unnecessary overhead writing
> > registers to a value they already have or reading the initial values of
> > those registers.

> One more register read when initially writing to a register and one
> more when resuming doesn't sound like a vast amount of over-head.

Especially on resume extra register I/O really adds up - people really
care how long their system takes to come back from suspend, and how
quickly individual devices come back.  For devices that are on slow
buses like I2C this means that every register operation counts.  Boot
can be similarly pressured of course, though it's a less frequent issue
for these devices.

> Not sure what you think I was suggesting above.  If the default values
> are actually non-zero that's fine - we'll either leave them as they
> are (if they are never changed, in which case Regmap doesn't even need
> to know about them), document only those (non-zero) ones or wait until
> they are read for the first time, then populate the cache.

You can't assume that the device is in power on reset state unless the
driver reset it itself which may or may not be a good idea or even
possible, sometimes it's what you want but at other times even if it's
possible it can cause user visible disruption during the boot process
which is undesirable.

> Setting up the cache manually also sounds like a vector for potential
> failure.  At least if you were to cache dynamically on first write
> (either on start-up or after sleep) then the actual value will be
> cached, rather than what a piece of C code says it should be.

Even where there's no problem getting the hardware into a clean state it
can rapidly get very, very expensive to do this with larger register
sets on slow buses, and at the framework level we can't assume that
readback support is even present on the device (the earliest versions of
cache support were written to support such devices).  Some of the
userspaces that regmap devices get used with end up wanting to apply a
bunch of configuration at startup, if we can cut down on the amount of
I/O that's involved in doing that it can help them quite a bit.  You
also get userspaces that want to enumerate device state at startup,
that's a bit easier to change in userspace but it's not an unreasonable
thing to want to do and can also get very I/O heavy.

There is some potential for errors to be introduced but equally these
tables can be both generated and verified mechanically, tasks that are
particularly straightforward for the device vendors to do.  There are
also potential risks in doing this at runtime if we didn't get the
device reset, if we don't accurately mark the volatile registers as
volatile or if there's otherwise bugs in the code.

> Precisely my point.  Lochnagar is a small device yet it's required to
> submit hundreds of lines of Regmap tables.  Imagine what that would
> look like for a large device.

There's no *requirement* to provide the data even if you're using the
cache (and the cache support is entirely optional), there's just costs
to not providing it in terms of what features you can get from the
regmap API and the performance of the system.  Not every device is going
to be bothered by those costs, many devices don't provide all of the
data they could.

I'm not clear to me that Lochnagar will particularly benefit from
providing the cache defaults but it sounds like you've raised concerns
about other devices which would, and it seems clear that the readability
information is very useful for this device if there's registers that
it's unsafe to try to read from.

> > > Even if it is absolutely critical that you have to supply these to
> > > Regmap up-front, instead of on first use/read, why can't you just
> > > supply the oddball non-zero ones?

That doesn't work, we need to know both if the register has a default
value and what that value is - there's no great value in only supplying
the defaults for registers with non-zero values.

> > If you aren't happy with the regmap subsystem you could send some
> > patches to change it to what you would be happy with (and patch the ~1300
> > drivers that use it)

> That may well happen.  This is the pre-patch discussion.

> Apologies that it had to happen on your submission, but this is that
> alerted me to the issue(s).

The regmap cache API has been this way since it was introduced in 2011
FWIW, we did add range based support later which is purely data driven.

> > Like any kernel subsystem it has an API that we have to obey to be able to
> > use it.

> Again, this isn't about Lochnagar.

I think from the perspective of Richard and Charles who are just trying
to get their driver merged this is something of an abstract distinction.
If the driver were merged and this discussion were happening separately
their perspective would most likely be different.

> > > The API is obscene and needs a re-work IMHO.

> > > I really hope we do not really have to list every register, but *if we
> > > absolutely must*, let's do it once:

> > >    REG_ADDRESS, WRV, INITIAL_VALUE

There is the option to specify range based access tables instead of a
function, for a lot of devices this is a nice, easy way to specify
things that makes more sense so we support it.  We don't combine the
tables because they're range based and if there is 100% overlap you can
always just point at the same table.

We allow the functions partly because it lets people handle weird cases
but also because it turned out when I looked at this that a lot of the
time the compiler output for switch statements was pretty efficient with
sparse register maps and it makes the code incredibly simple, much
simpler than trying to parse access tables into a more efficient data
structure and IIRC more compact too.  It's possible that those tradeoffs
have changed since but at the time there was a class of devices where it
wasn't clear that putting more effort in would result in substantially
better outcomes.

> > To re-iterate, regmap is a standard kernel subsystem. It's not owned by Cirrus,
> > so it's not our responsibility if you don't like it. Mark Brown is the maintainer.

> Sounds very much like you are saying, "it's not Cirrus' fault,
> therefore it is not my problem"?  Which is a terrible attitude.

I think from the perspective of Charles and Richard this is sounding an
awful lot like you want them (or someone else) to rewrite a very widely
used kernel API before they can get their driver merged.  To me that
would be a completely disproportionate amount of effort for their goal
but unfortunately people do get asked to do things like that so it's not
an unreasonable fear for them to have.

> Remember that the Linux kernel is an open community.  Anyone should be
> free to discuss any relevant issue.  If we decide to take this
> off-line, which is likely, then so be it.  In the mean time, as a
> contributor to this community project, it's absolutely your
> responsibly to help discuss and potentially solve wider issues than
> just your lines of code.

It's also a community of people with differing amounts of ability to
contribute, due to things like time, energy and so on.  Not everyone can
work on everything they want to, let alone other things people ask them
to look at.

> > As above, if one subsystem owner doesn't like another subsystem then those
> > subsystem owners should talk to each other and sort something out. It shouldn't
> > block patches that are just trying to use the subsystem as it currently exists
> > in the kernel.

> Again, no one is blocking this patch.

> This driver was submitted for review/discussion.  We are discussing.

I kind of said this above but just to be clear this driver seems to me
like an idiomatic user of the regmap API as it is today.  My guess is
that we could probably loose the defaults tables and not suffer too much
but equally well they don't hurt from a regmap point of view.

Reviwed-by: Mark Brown <broonie@kernel.org>

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvTedYACgkQJNaLcl1U
h9Dy/gf+IWGkOx2z6VrGgX6MVSxByvgRL6zFyYl/utyNdrjTfHk8RXlDk0v5b2r4
LwRzZ2jHUUrcZ64X280vKQ5saIdikGlb6z0GWt0X6X5BBLooPwD7V0uMm3LZDttb
41AyZ74fQmfTgICe80FuumK0IiRHPr+jYVcPI2p/mQBV5lfchZH/3fZ+QZ23MJY7
g4Dik9mvkbIX0tz/un8N5C5flr8YwaPTC9kH0dGYrO1yB7qh6jq87H9fqMa4jDXo
ISBr3edxfZdrHE3tj9b8fqUOLOOIfJGbKvL6pEi17ixq7yZJsmp+d0UsCWGBU0Xv
qo6Br/xw7MjZwAa63NykvEiFtfg0sA==
=VKBt
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
