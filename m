Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeDZBpC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:45:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34101 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeDZBpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:45:01 -0400
X-Google-Smtp-Source: AB8JxZr85hSHEJkmPBvno67cDwxojaK0Hd+7Cg1L/7SYnG3oIntbWUO19MqGcOzydhKMO8MfsPCuOA==
Date: Thu, 26 Apr 2018 10:44:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] printk: wake up klogd in vprintk_emit
Message-ID: <20180426014457.GC3282@jagdpanzerIV>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
 <20180419014250.5692-1-sergey.senozhatsky@gmail.com>
 <20180419100248.rflodqcvpvnve5vl@pathway.suse.cz>
 <20180420015221.GA6397@jagdpanzerIV>
 <20180425132352.cs22ak5jzwr2f4v4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425132352.cs22ak5jzwr2f4v4@pathway.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/18 15:23), Petr Mladek wrote:
> > 
> > Looks good. Do you want me to resend the patch?
> 
> JFYI, I have updated the commit message and pushed the patch into
> printk.git, for-4.18 branch.

Thanks!

	-ss
