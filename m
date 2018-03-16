Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeCPJFP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:05:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38108 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeCPJFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:05:14 -0400
Date: Fri, 16 Mar 2018 10:04:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] x86/microcode/AMD: Check microcode file sanity
 before loading it
Message-ID: <20180316090435.GB5852@pd.tnic>
References: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>
 <20180315232306.GA31610@pd.tnic>
 <ec44a74e-9017-b6bf-7397-862eca48026e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec44a74e-9017-b6bf-7397-862eca48026e@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:40:40AM +0100, Maciej S. Szmigiero wrote:
> I thought the one week absolute minimum resend time is for the case that
> there are no comments to a patch, or, more generally, when there is no
> action and not for "normal process" respins.
> 
> submitting-patches.rst says:
> > Once upon a time, patches used to disappear into the void without comment,
> > but the development process works more smoothly than that now.  You should
> > receive comments within a week or so;

Well, it says that *exactly* - you should receive comments within a
week. In your case, you got some of them even earlier.

Think of it this way: one week is more or less ok period when reviewers
have time to go through a patchset and give their comments. Keep in mind
that maintainers/reviewers get other patchsets to review too and they
can't always react immediately. In *addition* to the other crap they
have on their plate.

So patience is a good idea here :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
