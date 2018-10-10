Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A92085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mM6RK+no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5A92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJJTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:49:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/RyiIqBenmYoKgcwOZD7iOC6N9mY5DROH0g28Aj6zIY=; b=mM6RK+noIlHdwxLmqQ4dh+Lh7
        W2Y+65y8mxTH5MSwIw0S79Zb8HB+cDwhwUkvEshd8SWVCSHR1iD+3KYnYczts1lE2+S6jK9UxEnyI
        9fo0syzmtybJmQvBvT5c5rwUcu2dlsbsAuO+a00e0StdbnYNml3i4ByrZyeLg2g0sV8Uo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gADa2-0007mb-Uj; Wed, 10 Oct 2018 12:27:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 84EEA1122395; Wed, 10 Oct 2018 13:27:10 +0100 (BST)
Date:   Wed, 10 Oct 2018 13:27:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "Shenhar, Talel" <talel@amazon.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Message-ID: <20181010122710.GE6294@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
 <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
 <20181010112753.GC6294@sirena.org.uk>
 <ba83a08073614d9244c01218da28fe3e23f3bbc2.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <ba83a08073614d9244c01218da28fe3e23f3bbc2.camel@amazon.co.uk>
X-Cookie: Phasers locked on target, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 11:58:40AM +0000, Woodhouse, David wrote:
> On Wed, 2018-10-10 at 12:27 +0100, Mark Brown wrote:

> > If this is a modified IP with additional features then it should be
> > given a new compatible string rather than having a property - it's not
> > just configuration of the existing IP, it's a new thing and we may find
> > there are other quirks that have to be taken care of for it.

> No.

> It's an extension of the existing IP which is explicitly designed to be
> compatible with existing drivers via an opt-in feature.

That's totally normal and something that there's already infrastructure
to handle, plenty of other IPs have new versions with new features - you
can just add a new compatible string and use that to decide which
features to enable, and if it's backwards compatible with old versions
of the driver supporting older hardware then you can list multiple
compatibles.  As we just discussed on IRC this is partly a policy thing
now I've been told that it's a modified version of the hardware rather
than a configuration or integration option, it's easier than having
implementations of new features trickle out from the vendor and needing
to enable them all one by one in device trees (which does happen).

> Which is exactly what we've spent the last decade or two trying to beat
> hardware designers into doing, instead of randomly breaking
> compatibility for no good reason.

That's great and we get to reuse all the driver code with a quirk (a
quirk which fixes the hardware to be more compatible with devices, this
is a really good hardware change).  Ideally we'd be able to enumerate
things like IP versions and options from hardware but that's a more
entertaining problem.

Having said all this if there are production systems using this
property, especially production systems where people other than the
system integrator can realistically deploy their own kernel separate to
the device tree, then supporting those existing DTs even if they're not
doing the ideal thing might be the best thing.  You mentioned that this
might be the case, can you check what the status is there please?

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu98B0ACgkQJNaLcl1U
h9CPmgf/QMp2J8iPAnRVpTDGziEgyOEXdplvLf6fW0m4v5MSMSHJwgyrloZCVcVf
xnb5GsQaR89mnaqqd8FRJJ+VR13+4JWkqZTe5W4ha9MrpovU3EttyeQUSa0LDpEL
CuOHEvsG5lUy9szgAc2MRlf0Vf1gnCF0JtCGLWnoVC9qCHDQxQPyruhomrFdGdI3
3rXFbStZd6RmWtlfgu7f2V66oOc2FZwcMw/4ElO5IIUM1msI5PPgR1wCzO5SOkgy
fIQeVsMPs8mD3tq25/SkrxXv+rzNthkLTCHIod3jgmorCo9X2MvdZyoL9PN4s71w
o+xEojB7gcFcnud/EsHARj/OvSnXGQ==
=vsxh
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
