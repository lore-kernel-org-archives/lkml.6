Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64CECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FDA214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="f8/vMp0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FDA214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeJRCds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:33:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbeJRCds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C3cGZaKoN0VJVUxyAopSe63xneJujRNqGUysllzFYe4=; b=f8/vMp0a0TOK0911+74vGcFOk
        aryG4UfD8KVDVwJtMOWqVXmuOtzpsKrqPeG4X1+Q/cGjVEAaCMK1BvRe9Cg+S5rl5J4kG5FlCtqQc
        1OfYV5vrVT1BRstKafDFQIHmt+7hoVHEhCJLSYdcSQBWWQl9pXNte/4pXNuB7H7qJJcJo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCqgX-0001mi-GQ; Wed, 17 Oct 2018 18:36:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2BCD111224C4; Wed, 17 Oct 2018 19:36:45 +0100 (BST)
Date:   Wed, 17 Oct 2018 19:36:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org, tomi.valkeinen@iki.fi
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181017183645.GF24097@sirena.org.uk>
References: <20181017071902.30102-1-geert@linux-m68k.org>
 <20181017091325.GA15991@localhost>
 <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
 <20181017152101.GA17531@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <20181017152101.GA17531@localhost>
X-Cookie: No passing zone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 08:21:02AM -0700, Josh Triplett wrote:
> On Wed, Oct 17, 2018 at 11:31:35AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Oct 17, 2018 at 11:13 AM Josh Triplett <josh@joshtriplett.org> wrote:

> > > it does, however, ensure that the listed cases *are*,
> > > and helps people know that they're covered.

> > So you agree people cannot know if the unlisted cases are covered or not?

> People in underrepresented and commonly marginalized groups, especially
> those more commonly overlooked, don't always know if a given group has
> taken their particular group into account or given any thought to it.
> Explicit inclusion helps, and this is a standard guideline often cited
> for good codes of conduct.

I have heard some complaints that the strong push to include these lists
has ended up devaluing them, it becomes hard for people to tell if the
list is just a cut'n'paste job or if the people responsible for the code
of conduct really understand the issues affecting the groups they
include and it can be extra disappointing if there are problems.  I
particularly remember a friend of mine getting into an argument with a
conference being hosted somewhere where being gay was a capital offence
questioning the inclusion of sexuality on their list, it seemed fairly
clear that the organizers meant well and were trying to do the right
thing but weren't really aware.

This doesn't mean don't try but it's definitely a factor to consider,
especially when using an off the shelf code of conduct - there's just
never going to be a single right answer with a lot of this stuff.

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHgTwACgkQJNaLcl1U
h9Bniwf+LC4ISLfH5qYEub4eZn4WnzXcdKyuXubvVrA1ngv4B3aYC+LDhhkPGuxG
QT34pKccnfWP1xlHzfX06HjzUauAn7U1V2tDolk/jTvPUDEsbLCwNxYP8PX7ZdUc
CMXlDCBucc3tklmb8U+gq9EN2Yd01BSBDf8El9zx6hbLlRFvbszVlMRTl4AO3l/i
qyefsKEJF3cqS1ZzKDxeGijUkzpCOjEEJVRnCq0wSrMTsoeLZotTw/5fngWxmkl7
slBVNhj1+Jc8edmlsoj6rbxMkkgdCAOoXYW7nUWfgrkNx6KMkOvq2Q4k8Z0Iwwp9
sujylZGyuoe5cBNVVOG4b60MwNyL1A==
=9Rke
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
