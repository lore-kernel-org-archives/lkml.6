Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66B8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCC32086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCC32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeIJUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:20:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeIJUUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:20:22 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0fbPcAnT5dWh; Mon, 10 Sep 2018 17:25:44 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D9B81EC01F6;
        Mon, 10 Sep 2018 17:25:44 +0200 (CEST)
Date:   Mon, 10 Sep 2018 17:25:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180910152538.GA4386@zn.tnic>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
 <20180910140710.GR5565@intel.com>
 <20180910144720.GA28349@zn.tnic>
 <20180910150910.GS5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910150910.GS5565@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:09:10PM +0300, Ville Syrjälä wrote:
> But it is a patch, and if it happens to get accepted as is so be
> it. If not, it's a good place where to start the conversation on
> how to fix the bug in another way.

Uh, more of that "logic".

It is a patch but not really, if it is applied, good, if not, also good.
WTF dude?

> You guys seem to have a notion that anything which says '[PATCH]'
> is somehow final. In my book any patch is up for debate. Nothing
> special about this one in that regard.

Well, let's see: imagine you're a maintainer. You get gazillion patches
a day. And you think, oh well, I need to review and possibly apply this.
And then move on to the next one. Because everyone is asking, when is
she/he going to apply my damn patches...

But nooo, *some* of the patches are special - they're a conversation
starter *only*! But also if applied, that's fine too.

What a bunch of bull!

What's wrong with sending a mail tagged with "[REGRESSION]" - this looks
like the tag people have adopted - and explain what the problem is, what
you've bisected it to and what your observations are? Like everyone else
reporting bugs/regressions/...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
