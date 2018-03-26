Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbeCZFSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 01:18:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37835 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeCZFSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 01:18:51 -0400
X-Google-Smtp-Source: AG47ELvf8/gO/zzRDbReKPXthC1hysY/o64/luh2CXOMFTQHOYgLw2sI75Uscb8W/uVBzWJhbFx1aQ==
Date: Mon, 26 Mar 2018 14:18:45 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: bugzilla-daemon@bugzilla.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180326051845.GB7779@jagdpanzerIV>
References: <bug-199003-14532@https.bugzilla.kernel.org/>
 <bug-199003-14532-DgJdGAHEOE@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-199003-14532-DgJdGAHEOE@https.bugzilla.kernel.org/>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing the kernel list and printk people.

Wen Yang, any chance we can switch to email? Bugzilla is not very handful.


On (03/26/18 02:40), bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=199003
> 
> --- Comment #11 from Wen Yang (wen.yang99@zte.com.cn) ---
> Hello Steven,
> 
> +module_param_named(synchronous, printk_sync, bool, S_IRUGO);
> +MODULE_PARM_DESC(synchronous, "make printing to console synchronous");
> 
> It's depend on this kernel parameter(printk.synchronous), but this parameter is
> readonly.
> So we must change grub files, and alse need to restart the server for changes
> to take effect.
> If we can configure it dynamically, it will be more useful.

So you are testing printk_kthread now, right? May I ask why?
Did Steven's patch help?

	-ss
