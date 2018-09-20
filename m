Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958BCECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F60214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="QUvkm7lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F60214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbeITItB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:49:01 -0400
Received: from imap.thunk.org ([74.207.234.97]:53062 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732171AbeITItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DOM+L0kfI9GhFO1nJSc6/GwyTqOwf24jjsCgzkAhFVs=; b=QUvkm7lOdS9YQp7VtJCmtAWsC8
        tGVOoVj9S+thtNfRjzPu1OjGVeUUwQCeBazV2spz6J+8UXGPTo6QS8INHtu9nSrEOnzoKkxYz85ot
        rSIuVWYRFc6R2L7TwuuaCPvs+Ct1uGvp9pzFv3GO5Vlgu1SYw3n3S8LGS90K5FSvJAjk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g2pJn-0003uT-Cs; Thu, 20 Sep 2018 03:07:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BBF197A0187; Wed, 19 Sep 2018 23:07:49 -0400 (EDT)
Date:   Wed, 19 Sep 2018 23:07:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Olof Johansson <olof@lixom.net>
Cc:     Edward Cree <ec429@cantab.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180920030749.GA29741@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Olof Johansson <olof@lixom.net>, Edward Cree <ec429@cantab.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 02:16:40AM +0100, Olof Johansson wrote:
> > But there are too many ways this can go wrong, maybe not now or next
> >  week but in five or ten years, when maybe a different kind of person
> >  is on the TAB, or maybe external pressure is brought to bear on TAB
> >  members.
> 
> One thing to keep in mind is that we all want what is best for Linux,
> to make the best possible kernel. None of this has changed that.
> 
> I personally find it unlikely that relevant pressure could be applied
> on TAB members; I don't find it a prestigious role such that it is
> worth holding on to against my own values or best judgement.

Even *if* pressure could be applied to TAB members, it's important to
remember that the TAB as a body gets its influence and moral authority
from the people who have agreed to serve on it, and not the other way
around.  People join the TAB because they want to serve.  It's not
because being on the TAB grants some kind of mystical power, because
it doesn't.  Ultimately, the "A" in TAB stands for Advisory.

The TAB does not get to control whether patches gets accepted into the
linux-media git tree.  Mauro gets to decide that.  The TAB does not
get to control whether or not Linus accepts pull requests from a
subsystem maintainer; that's up to Linus.  The TAB doesn't run
vger.kernel.org.  That's done by David Miller.

Look at what happened when a particular developer decided to do the
anti-social thing and become a copyright troll.  It was not the TAB
which decided that no further code contributions should be accepted
from that particular person.  It was the Netfilter team.

Linux Maintainers have always had the power to reject patches for any
reason.  It isn't just for technical reasons, as the Netfilter team
demonstrated with the copyright troll.  (Of course, the person whose
patch has been rejected can always appeal to Linus, by sending the
patch directly to Linus.  None of this has changed; it always has been
this way.)

The TAB can make a recommendation, but the decision to act on that
recommendation resides with the Maintainers in general, and
ultimately, Linus.

						- Ted
