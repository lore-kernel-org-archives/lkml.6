Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4441BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E863D2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eYDE/pRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E863D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJHTOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:14:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeJHTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4zM7joX3kGQmn2PkKa8CCXCvpW50J8l8UNfGvZ8tZkY=; b=eYDE/pRTdCn65NVawh0a//30E
        LtM5kZPtLWhB1TNYCoQVanHfgnoCs2Qv+zo1BrDQLFa3ry14jBWCIs+pmynhIYXa7gyWmj9xgqIb6
        P6DV9YgXg3NEV4/A3V+pFde3e9Y5AtxBPGUyUGdlS1itWFhStTeEWogTIKsvSZ164joDw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9UFB-0002XX-75; Mon, 08 Oct 2018 12:02:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A45AF1122339; Mon,  8 Oct 2018 13:02:36 +0100 (BST)
Date:   Mon, 8 Oct 2018 13:02:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181008120236.GD5684@sirena.org.uk>
References: <20181007085102.17795-1-geert@linux-m68k.org>
 <20181007113514.GA21217@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20181007113514.GA21217@localhost>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 07, 2018 at 04:35:14AM -0700, Josh Triplett wrote:
> On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.

> > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > experience for everyone", period.

> I would suggest reading the commit message that added this in the first
> place. "Explicit guidelines have demonstrated success in other projects
> and other areas of the kernel." See also various comparisons of codes of
> conduct, which make the same point. The point of this list is precisely
> to serve as one such explicit guideline; removing it would rather defeat
> the purpose.

The Debian code of conduct also omits the explicit list of factors.  In
their case it was a deliberate decision due to a real fear that people
involved in and adjacent to the project would try to rules lawyer an
explict list and wanting to make the code of conduct robust against
that.  The communities seem similar enough that it's worth thinking
about for the kernel as well, Debian has had to deal with some serious
problems in the past so there's some experience behind the decisions
there.

> In any case, this is not the appropriate place for such patches, any
> more than it's the place for patches to the GPL.

We do need some way to talk about what we're trying to do here.

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7R1sACgkQJNaLcl1U
h9DSlgf/TrAjyhsy9c4hZmukCHV26ymNY8mSxDTh5O7+Nuu+GljrpWBax57/Iuye
TJvuTKYrKvVyHSUxeoiNlBNCzGJumO8zOwQ4T0PcjvbSr3Bb49TcFpU2dVUsrmy6
wtFG+xd8UujJunnp/2Ij2vLIznOCdijqhiJjZUTG+hm3yUrWNr6r9f+JkZYy7cM8
+JH+vME2UTErPAQ9iOaSmdTgEClD6ILMzBVLQkZ43CZsz+ppAs0HKL+zBowvULtD
EG9+0gH84qhM41+7TEufY/H2no1uwsMPalM4DfELJ6K7OqwcO0+uQPjBquriJRAS
YBZf0ImvUPzNbK1NL0QXdz16lMUmFw==
=lPR7
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
