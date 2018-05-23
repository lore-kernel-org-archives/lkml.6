Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933842AbeEWSA7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:00:59 -0400
Received: from muru.com ([72.249.23.125]:44216 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932757AbeEWSAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:00:55 -0400
Date: Wed, 23 May 2018 11:00:52 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180523180052.GP98604@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <20180517134820.GI98604@atomide.com>
 <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
 <20180517194834.GW25808@atomide.com>
 <CAHp75Vf7L3zsSgaj1vfoyNKdPo0w6Nu+mW5HuM97SKAK-1y2Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7L3zsSgaj1vfoyNKdPo0w6Nu+mW5HuM97SKAK-1y2Pg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180522 21:54]:
> On Thu, May 17, 2018 at 10:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:38]:
> >> On Thu, May 17, 2018 at 4:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180516 10:49]:
> 
> >> > The idea breaking PM seems silly to me considering that we've had
> >> > it working for years already.
> >>
> >> Same question  / note. World is much more complex than just being OMAP.
> >
> > Sorry but you are making assumptions about hardware being powered on
> > all the time.
> 
> Nope, other way around. The so called "support" _prevents_ our
> hardware to go to sleep.

Hmm sorry now I'm all confused what issues you're having.

I thought you said earlier the issue was that you wanted to keep
the console enabled all the time and never idle?

Regards,

Tony
