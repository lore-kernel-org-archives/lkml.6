Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968042AbeE2XWR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:22:17 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42678 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965249AbeE2XWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:22:15 -0400
X-Google-Smtp-Source: ADUXVKI8dCxBnvKs2hKni7g2EIZG5kVx/cIUOJRCXTSYBubUN7th2FTcXTRkjOYsz63j3GJq061klr4wFzqYgKaaS1M=
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XBPjcGCbK2L_ELjMVVSO34BeJQv8cSiC6M_r7MDVFLvQ@mail.gmail.com>
References: <CAB=NE6XGCM0nZqvq74JPnSKgvL37Nkwvr3H3cAQ=ooTYJt7Rdg@mail.gmail.com>
 <20180529192643.GA3487@kmo-pixel> <20180529205143.GB7381@thunk.org>
 <20180529210025.GB3487@kmo-pixel> <20180529225928.GI31712@garbanzo.do-not-panic.com>
 <CAB=NE6XBPjcGCbK2L_ELjMVVSO34BeJQv8cSiC6M_r7MDVFLvQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 02:22:14 +0300
Message-ID: <CAHp75Vefx7zwrn4CwhDYZrMSLdaaqta1uJHJrqD7c40MQ_N0ZA@mail.gmail.com>
Subject: Re: PostgreSQL licensed code on Linux
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Tso Ted <tytso@mit.edu>,
        Coly Li <colyli@suse.de>, Ciaran Farrell <ciaran.farrell@suse.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        linux-bcache@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonas Oberg <jonas@fsfe.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 2:12 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> It would seem I did follow up with a v3 patch and Rusty noted that although
> I may be right, its hard to care [0]. But of relevance here is again if one
> of the MODULE_LICENSE() dual tags should be used or the GPL tag. I'll
> continue to side recommending with the MODULE_LICENSE("GPL") tag even on
> files with permissive licenses, and even if it we haven't clarified this in
> documentation as I think scaling these tags further is just silly.
>
> [0] http://lkml.kernel.org/r/87bom0hf0f.fsf@rustcorp.com.au

https://www.spinics.net/lists/linux-bcache/msg06048.html

https://www.spinics.net/lists/linux-bcache/msg06058.html

-- 
With Best Regards,
Andy Shevchenko
