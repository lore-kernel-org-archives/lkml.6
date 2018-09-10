Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B90C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DB02087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DB02087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeIJVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:01:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58574 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeIJVB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:01:27 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lf0ERArjtTOl; Mon, 10 Sep 2018 18:06:39 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DC481EC04A6;
        Mon, 10 Sep 2018 18:06:39 +0200 (CEST)
Date:   Mon, 10 Sep 2018 18:06:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180910160633.GB4386@zn.tnic>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
 <20180910140710.GR5565@intel.com>
 <20180910144720.GA28349@zn.tnic>
 <20180910150910.GS5565@intel.com>
 <20180910152538.GA4386@zn.tnic>
 <20180910155112.GT5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910155112.GT5565@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:51:13PM +0300, Ville Syrjälä wrote:
> Sounds to me like the maintainer should figure out how to delegate some
> of the load a bit. Or just go on vacation and ignore all mails. I hear
> stress isn't good for you.

Bullshit.

> That's what all patches are. No should be applying unreviewed patches
> blindly.
> 
> Also often a revert is a perfect way to handle regressions. It gets
> the angry users off your back ASAP allowing you to fix the bug

More bullshit.

> Calm down. No one is out to revert all your patches.

Even more bullshit.

> Maybe you can propose a new git-regression tool then? And document that
> you want bugs reported using it? Ideally I'd say it should do almost
> exactly what git revert does except s/revert/regression/. Though I
> suppose it could include the original diff instead of the reverse.

Even even more bullshit.

> Now, how about we stop this pointless "logic" discussion and
> focus on the techinal stuff from now on?

That's the only constructive and serious thing you've said so far.
Let's.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
