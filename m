Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D39C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DCA20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Sz/9pNab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DCA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeJWHGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:06:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:46902 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbeJWHGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BZ71YwHmVCdTGSDAI9Z53mZLPYsgH0FoLXN4uPG39zo=; b=Sz/9pNabCN7MfFwARx/Vkl5aHU
        OeInX4tOsvKTm7MXbzul0c567jau8xK00DG50/Jsf15isr+7ZiNM4jYUYAPwoFRpsDeOh2eSecmnU
        0Dt9s4Tobj8nKCaLSGaO+cuTJRwkDlKZQPD1fbr6GVSg6I9HzCyFKfcK2j7qDJeHFRWw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gEixa-0000RD-HH; Mon, 22 Oct 2018 22:46:06 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 690C77A2F4E; Mon, 22 Oct 2018 18:46:04 -0400 (EDT)
Date:   Mon, 22 Oct 2018 18:46:04 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     NeilBrown <neil@brown.name>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181022224604.GM1617@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        NeilBrown <neil@brown.name>, Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zxt919d.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

I disagree with your framing, and thus your analysis, and thus your
proposed solution.

On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> If, for example, Linus or Andrew said "if you cannot work with any given
> maintainer, I will consider your patch directly, but you need to point
> to where you tried, and why you failed - or to where the promise is
> inadequate".
> 
> Currently if a maintainer is rude to you, there is no where else that
> you can go and *that* is why it hurts.  It isn't the abuse so much as
> the powerlessness associated with it.  If you can (metaphorically) say
> to that maintainer "I don't care about your toilet mouth, you've just
> given me the right to take my petition to caesar" - then the emotional
> response will be quite different to pain.

No.  That's just not how things work.  Patches don't get rejected
because maintainers are being rude.  Patches don't get accepted
because they are not of a sufficiently high technical quality.  And if
you spam a maintainer with bad quality patches, and they tell you what
you should do to make them better, and you actively ignore requests
about how to write better code[1], it is perfectly acceptable for
maintainers to decide to ignore said bad patch committer.  Putting bad
patch commiters on a blacklist is not a CoC violation.

[1] And no, this is not a hypothetical example.  This particular
kernel newcomer continually spammed maintainers with patches that
wouldn't even compile, and were clearly never tested.  And when the
newcomer started giving bad advice to users reporting bugs, he
ultimately got banned from LKML...

After all, we all want to make the kernel to be better.  So if someone
submits good quality code, Maintainers are going to want that code to
improve their subsystem.  Thinking that people want to go off on power
trips by rejecting perfectly sound code is a complete misdiagnosis of
the problem.

						- Ted
