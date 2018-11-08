Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229EBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE80D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eN8pZyRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE80D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKICJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:09:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nWUmcxJREPkVczjOBBt9QiQXBGzqI5x22O4jZKmxUZc=; b=eN8pZyRnsZoRQ/TmP6F01yQvJ
        UdFfPKDw9NgISjBE/+LidMlI5nQetx/zJJ8RdhKsmbsxZMFkSOCUZCkCbf+mo/ZiGbynIwExwVZqt
        Egrt7NDqZyynK5E81GvW6gQQCCnzG4oirHYXh9Goq8qtxTozkG2mFg+3qnm2siDOrs5EQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKnEF-0000EQ-S7; Thu, 08 Nov 2018 16:32:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7B5E61124D9E; Thu,  8 Nov 2018 16:32:23 +0000 (GMT)
Date:   Thu, 8 Nov 2018 16:32:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181108163223.GH6675@sirena.org.uk>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
 <20181108150517.GV9761@hirez.programming.kicks-ass.net>
 <20181108162133.GC1080@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
In-Reply-To: <20181108162133.GC1080@thunk.org>
X-Cookie: I'm having a BIG BANG THEORY!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 11:21:33AM -0500, Theodore Y. Ts'o wrote:
> On Thu, Nov 08, 2018 at 04:05:17PM +0100, Peter Zijlstra wrote:

> > My plumbers schedule is already 100% booked with MCs and other things.
> > There is no kernel-summit schedule details available as of yet, but it
> > is already almost certain that I will not have time for anything in that
> > track anyway :/

> I thought there was a slot already scheduled on the refereed track,
> "Towards a Linux Kernel Mainainer Handbook" (Tuesday at 4:45pm) for
> this purpose?

I'm not 100% sure that people will pick up that the topic is about a
handbook for working with maintainers rather than a handbook for being a
maintainer from that title...

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkZRYACgkQJNaLcl1U
h9D1Dgf5ARhRnEG6IlCfGB+sMyyWHQe3QOVKC14HDtdPBh+gdRJxJNsR9UCORtHp
gIjGlffUFpPH4YvbXXN2UPTI2ucfliyXvDtCY8/Co8ZWkqQejl2KihlPEWFurNpi
8Dm6v9RZqTJBUvxsaqYB9VPl0YwQKExu5khalnc/c8NtOUCs0/kX3e1L9NlGAwmK
xxQN93Dxo2xhJBjFzCqwvauna61f99c1WZjZkXJWrywtBUEjtk8KE3DtERowQYLA
2W51UpISqzkxBXZPppxcK1NFtR5K1fPQb4+wZugydIf4uvfjEsG9HwYCJdUdiXkd
UIIExyXW4PRLkZ50DT1r4IlWTOGd+g==
=60l2
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
