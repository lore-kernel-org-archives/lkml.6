Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2247TtSws67UiW/0xk1yte4POar20MPJ/72bx5b3uSZ/MkvGHZ9qsaqPMxJ4POQOVh4IcG1i
ARC-Seal: i=1; a=rsa-sha256; t=1519291636; cv=none;
        d=google.com; s=arc-20160816;
        b=ua2ZW0D/hQG//HY9OnwYfbWAaBeLets8iUewM8PCUAhB9iBgcwk9Wz2kd9nowHm+wu
         JUi0wyD/A8DxoPMWa4s6do0uZdf4APFlQkwRKFW6q0nxl239JndZEkh7Gjg+yhgubXCf
         Iga5P9qKRr8MGOUvhdOTmiwxwvGOE9/Ka9zBExXyQsIMLw2o7FitMcOiJ7pgeGh42OkZ
         zPyeriu8L4SSpRDmNsuvPPxiRg+Axx/n4c+MfZXBar9hkRZJs9SDjDvdh0iJJFtvs9Wg
         PvdXNFfnDNn6GXtKwEvfnK3z0gjLEKMzGP18inYbUAcG9cmp+8xf38r3Ae7YxCr9RHPm
         6FEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=zpgB4wJESiDnfID8Ke3Q9Sl8TaugtvmOkDmrk2xMFIg=;
        b=xO7ICPfvMaL+XlXDPglnDEXCQTl3ldf7dIda6paHg5I+Ou4U/d6DpZTjaiqdsw8PIw
         jREGV6YCaK+uREneOLHa4q5CQJ8OvtKnXb3ST9al9iMn4979IUfpPgy/vVbB9v6G3X+c
         9XgANK1SJHjwpi5VMuSGm1BFZcMZlG38DTPC5fFa0p3jUHaD07JYoATlxzX9Ewt7YKI4
         C+zzczMlcGla12Q0JGwhWgXWYgEaLVfgthwSdEd7rLDYMpead9ZyfILl58YJPC1PEFLv
         WnUgTjvQ8d7xL2p1CGhTucdkmPI9hl07zOkVJKc8v0TdhKkz8qpeldd9A6q+/jYdM/OF
         K7lg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=UthkLaKn;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=UthkLaKn;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 22 Feb 2018 10:26:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 00/13] Remove metag architecture
Message-ID: <20180222092654.GN25201@hirez.programming.kicks-ass.net>
References: <20180221233825.10024-1-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593055859238851284?=
X-GMAIL-MSGID: =?utf-8?q?1593092747535482215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:38:12PM +0000, James Hogan wrote:
> So lets call it a day and drop the Meta architecture port from the
> kernel. RIP Meta.

So long, and thanks for all the fish!

Nice cleanup though, most welcome :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
