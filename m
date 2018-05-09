Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935029AbeEIM7d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934689AbeEIM7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:59:32 -0400
Date: Wed, 9 May 2018 08:59:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180509085929.180d1a93@gandalf.local.home>
In-Reply-To: <20180509120050.eyuprdh75grhdsh4@pathway.suse.cz>
References: <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
        <20180420101751.6c1c70e8@gandalf.local.home>
        <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
        <20180420111307.44008fc7@gandalf.local.home>
        <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
        <20180423073603.6b3294ba@gandalf.local.home>
        <20180423124502.423fb57thvbf3zet@pathway.suse.cz>
        <20180425053146.GA25288@jagdpanzerIV>
        <20180426094211.okftwdzgfn72rik3@pathway.suse.cz>
        <20180427102245.GA591@jagdpanzerIV>
        <20180509120050.eyuprdh75grhdsh4@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 14:00:50 +0200
Petr Mladek <pmladek@suse.com> wrote:

> IMHO, if con->write() wants to add more than 1000 (or 100 or whatever
> sane limit) new lines then something is really wrong and we should
> stop it. It is that simple.
> 

+1

-- Steve
