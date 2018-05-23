Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934008AbeEWSc6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:32:58 -0400
Received: from muru.com ([72.249.23.125]:44234 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933897AbeEWScy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:32:54 -0400
Date: Wed, 23 May 2018 11:32:50 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180523183250.GQ98604@atomide.com>
References: <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
 <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
 <20180517193008.GV25808@atomide.com>
 <CAHp75Ve56pyEC41XZ9i9yxBNberQe=ee2miQL0v9T4vRtkWPBQ@mail.gmail.com>
 <20180523175859.GO98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523175859.GO98604@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180523 10:58]:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180522 21:42]:
> > Have you seen entire series which I keep here:
> > https://bitbucket.org/andy-shev/linux/branch/topic/uart/rpm?
> > Among other things it gets rid of those specific callbacks entirely.
> 
> Well I was not Cc:ed on it, I browsed it in some archive and it
> seemed unsafe to me. But if you figured out a way to do it conditionally
> based on console.idle without causing regressions.

Sorry incomplete sentence here.. If you have some branch that
based on console.idle I'd be happy to test it.

Regards,

Tony
