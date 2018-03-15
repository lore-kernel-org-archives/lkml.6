Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933021AbeCOXXs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:23:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeCOXXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:23:47 -0400
Date: Fri, 16 Mar 2018 00:23:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] x86/microcode/AMD: Check microcode file sanity
 before loading it
Message-ID: <20180315232306.GA31610@pd.tnic>
References: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:07:34AM +0100, Maciej S. Szmigiero wrote:
> Currently, it is very easy to make the AMD microcode update driver crash
> or spin on a malformed microcode container file since it does very little
> consistency checking on data loaded from such file.

Ok, a couple of tips for the next time:

* please send your reworked patchset for review after review of your
current patchset has been completed. We normally send patchsets once a
week. You've sent yours two days after and that's kinda too fast. I'm
sure you can imagine reviewers have other work to do too.

So please be patient before resending next time.

If in doubt, the whole process is documented in Documentation/process/ -
might wanna skim through it.

* when sending your patchset, make sure all mails are sent as a reply to
the 0/N message.

Your 0/N has:

Message-ID: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>

but your 1/N has

References: <cover.1521150415.git.mail@maciej.szmigiero.name>

so something went wrong there. Normally git send-email does this
correctly.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
