Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91757C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CC32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gN8YbL2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CC32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIGQUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:20:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbeIGQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LQGvrxvUvTlhkTVP4C8rnk2LBpDm+C7OIxZPkjFSmNw=; b=gN8YbL2Nb2PUKshHoDR++cRXS
        wi8FTnLfKiN6nXg5zXUBbErBkotOIOalA+ZM7hJ07u4GfIldH5eJLa5nnBi9YtqAN2VXNL9GT+UAJ
        ARNaF4w8DwS5hr2trwyysthW9bj6o143o6jQi2e58AVbnP2tIiSh+kNqUHBgb6rKLWzMVd1B97R33
        Cl5BZkJeDxL2nVa+uaLY/DfEeuU04r1io6HfG6G5WdOqM90agsko8zZFW7fs/NLIUxnFNlentn3YG
        dI/u02E7A4mjOFPgfQGh3asEHg0DS5cuHJXdCEpI/njqryiRwkyz8fmHOYs8RUQY3abO0OhCQMnG4
        Bl2ksf/Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyF7F-0001V7-Ix; Fri, 07 Sep 2018 11:39:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3937320210312; Fri,  7 Sep 2018 13:39:56 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:39:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] jump_label: Fix typo in warning message
Message-ID: <20180907113956.GW24106@hirez.programming.kicks-ass.net>
References: <20180907103521.31344-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907103521.31344-1-bp@alien8.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:35:21PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> There's no 'allocatote' - use the next best thing: 'allocate' :-)

There damn well should be ;-)

Thanks!
