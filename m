Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeDTOTT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755109AbeDTOTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:19:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960A020C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 10:19:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180420101915.6cf5d4a4@gandalf.local.home>
In-Reply-To: <20180420101751.6c1c70e8@gandalf.local.home>
References: <20180413124704.19335-1-pmladek@suse.com>
        <20180413101233.0792ebf0@gandalf.local.home>
        <20180414023516.GA17806@tigerII.localdomain>
        <20180416014729.GB1034@jagdpanzerIV>
        <20180416042553.GA555@jagdpanzerIV>
        <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
        <20180420021511.GB6397@jagdpanzerIV>
        <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
        <20180420080428.622a8e7f@gandalf.local.home>
        <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
        <20180420101751.6c1c70e8@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 10:17:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> int git_context(void)

That should have been get_context(void) ;-)

-- Steve
