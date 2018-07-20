Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D28ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C0B20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="xgvSFt/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C0B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeGTVdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:33:49 -0400
Received: from imap.thunk.org ([74.207.234.97]:39860 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbeGTVdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aBpIiEuf+EAeo/WY63YvLs5OyNSDKcW7QK2+8NFT1PY=; b=xgvSFt/jX6yTzD+++f9Vf2cUu2
        CL3BbrMhQ2z4krLn3RaBz8VdTifdIIHYcN3cYczB4FOKndOnNY7bjvfn03P7tVsPudQd1Am1wEe5n
        EsFeb5SSo/O+DXbWHWKqxrCU0ZCQ2kknFeFLQSURmcfInuVOMgeJhEudTPGmBFkFKGms=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fgcFg-00072h-Fn; Fri, 20 Jul 2018 20:43:48 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8DD1C7A6419; Fri, 20 Jul 2018 16:43:43 -0400 (EDT)
Date:   Fri, 20 Jul 2018 16:43:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sphinx version dependencies?
Message-ID: <20180720204343.GC27862@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180719181556.GA21435@thunk.org>
 <20180719190400.GB4800@magnolia>
 <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
 <20180720131206.GM30706@thunk.org>
 <d064f468ab9fc60a02242331e0dddc185d6556ba.camel@darmarit.de>
 <20180720145235.GA27862@thunk.org>
 <cd31ba58ac24851698e06628ceebce4648345ff6.camel@darmarit.de>
 <20180720164421.GG4800@magnolia>
 <93aa59853a491a5ba3d5c3bcc0c991a1b815a67d.camel@darmarit.de>
 <20180720171020.GI4800@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720171020.GI4800@magnolia>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:10:20AM -0700, Darrick J. Wong wrote:
> 
> Well yes, but it's the virtualenv workflow that produced build errors
> for Ted; that's what would seem to need fixing?

What would delight me if there was a fixed docutils and Sphinx version
which is the **only** thing which subsystem maintainers need to test
against.  If it fails for that version, then I reject the patch; and
if it works on that version (say, 1.4.9), and it fails on some other
version that a Distro wants to use for its hermetic build environment
(say, 1.7.5), I can tell them, "not my problem, feel free to send me a
patch that makes things work for 1.7.5, and doesn't break on 1.4.9 ---
or package 1.4.9 for your distro build systems."

I don't really care what the mandated version is --- although given
that Fedora and Debian seem to be using 1.7.5, maybe that's the right
answer, and too bad for the enterprise distro build systems --- that's
why they get paid the big bucks.  I just want to know what I'm obliged
to test against.

So if Documentation/sphinx/requirements.txt is the only thing which is
guaranteed to work, that's fine.  But it might be good to document
that somewhere.

						- Ted
