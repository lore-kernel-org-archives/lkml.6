Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeBZQBz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:01:55 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36510 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbeBZQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:01:53 -0500
X-Google-Smtp-Source: AH8x224KhOtji53rV6Lcl9BWwyWmhWlhagORq+WJyZgJrVZmSxpUvy1ZkESzji7GDqczm4SdeGKTPA==
Date: Tue, 27 Feb 2018 01:01:47 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180226160147.GA1198@tigerII.localdomain>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180219155817.yfo7yrnz4vyzxerx@pathway.suse.cz>
 <20180219160122.upqkpbbffm3rth6p@pathway.suse.cz>
 <20180226063735.GC12539@jagdpanzerIV>
 <20180226155734.dzwg3aovqnwtvkoy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226155734.dzwg3aovqnwtvkoy@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/26/18 16:57), Petr Mladek wrote:
[..]
> 
> Okay, what about the following patch for 4.16-rc4?

Looks good!

[..]
> Fixes: dbdda842fe96f8932 ("printk: Add console owner and waiter logic to load balance console writes")
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
