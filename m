Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeDBQoh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:44:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40962 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbeDBQog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:44:36 -0400
Date: Mon, 2 Apr 2018 18:43:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Khan M Rashedun-Naby <naby88@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        thomas.lendacky@amd.com, jgross@suse.com, r.marek@assembler.cz,
        qianyue.zj@alibaba-inc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed some style warnings and errors
Message-ID: <20180402164333.GB21609@pd.tnic>
References: <1522682263-11935-1-git-send-email-naby88@gmail.com>
 <20180402161708.GA22516@pd.tnic>
 <CANOsoeva82vod1QDHoJiJr2bBAmD7hULZVowebK9yrpF+5cpOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANOsoeva82vod1QDHoJiJr2bBAmD7hULZVowebK9yrpF+5cpOQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 10:24:36PM +0600, Khan M Rashedun-Naby wrote:
> Thanks Borislav, but what about the data type fix ? :)

First of all, please do not top-post when replying to lkml email and
also, when replying, hit reply-to-all so that all the people on CC can
get the answer. I've fixed that now.

For a more detailed discussion on the whole process, take a look at

Documentation/process/

or alternatively at a well-formatted version:

https://www.kernel.org/doc/html/latest/process/index.html

Now to your question: forget the "data type fix" - that will be
addressed when we touch that code at some point anyway. Pure checkpatch
patches only dilute git history and don't really help.

If you really want to get involved, try fixing real
bugs like fixing drivers in staging, for example.
https://kernelnewbies.org/FirstKernelPatch has a very detailed
explanation how to do that.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
