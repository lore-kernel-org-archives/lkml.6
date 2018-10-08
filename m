Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C5C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4142064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="a0bwpWKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4142064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJHRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:25:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ICtrL6OFaypuwGaTLgHqyAdZfd5BpManm30pPFSxdq8=; b=a0bwpWKkbtmEr5iU6q/VnSFlN
        KO19vIhjswccuiao+VEHYqGnS9p/WDrERvWyBt8Wf1u0lId+oL2ohG9EmRqFmIUJF4Mpo3RLx827e
        3aPaSHgprTEUehedKoli2o1twGmX0Y+RjGGEJbY+OyHbPGkD66hGCG4Rddj4vzeoaejVc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9SYx-0002Ox-L8; Mon, 08 Oct 2018 10:14:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2AAC31122338; Mon,  8 Oct 2018 11:14:55 +0100 (BST)
Date:   Mon, 8 Oct 2018 11:14:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
Message-ID: <20181008101455.GC5684@sirena.org.uk>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
 <20181007225613.GZ32577@ZenIV.linux.org.uk>
 <CAPM=9tzU_wy77j=sx9u9gFsJp-M4ktH7hLQE5=_wKbow9p+iuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <CAPM=9tzU_wy77j=sx9u9gFsJp-M4ktH7hLQE5=_wKbow9p+iuQ@mail.gmail.com>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 08, 2018 at 09:37:59AM +1000, Dave Airlie wrote:
> On Mon, 8 Oct 2018 at 08:56, Al Viro <viro@zeniv.linux.org.uk> wrote:

> > We can surround it with "explanations" until we get something that more or
> > less fits, but then we'd need to reanalyse them every time an upstream
> > change gets merged.  And the lack of textual conflicts is not a good thing
> > in such situations, obviously.

> We do this already for the GPL (hence the GPLv2 only, and syscall exceptions).

That works reasonably well for licenses because people reading licenses
tend to do so in a rather detail oriented fashion so it's not that big
an obstacle to have something that's a bit harder to follow.  It's not
clear to me that the same thing is going to apply to people reading
codes of conduct, especially those looking for reassurance from them.
It might be OK but it's probably worth thinking about.

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7Lh4ACgkQJNaLcl1U
h9BlGgf+Jd5yIlAzK7IXrz8w956FmPTkmDOrFMDyp5IKt/nNOYYYI8LgnvSRysUW
UF6MJN+yr3cCaKjPAhfdV/IuBojliG5E/ooSqijwKFVB8eGdLQ+4i319T1tpNNcM
jCb2yfTaVuexPS8fNVEVURre8XF11Z8TvmELROVZN5Eih2EL5BecdZ2gUGtBCM19
CWwmhrKWOxYcZ4sPuYqWLUo39PSDSEs1EL2QSww6q+E1LT5hkhir+j7X5ehLGqYL
aHyNJ8haLbPFNn0guJHeGPbZ5D89jb+018UNPcR/xIegxWSHhrylghaV0LiRBtle
07A7WB0QUzP3ojoGnitbPwPeHJoqeA==
=hXVf
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
