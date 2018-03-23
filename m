Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeCWP0D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54717 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbeCWP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:26:01 -0400
Date: Fri, 23 Mar 2018 16:25:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: change message to pr_info
Message-ID: <20180323152559.gpdfsknsfk7vexqr@pathway.suse.cz>
References: <20180322135833.16602-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322135833.16602-1-tomeu.vizoso@collabora.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-03-22 14:58:33, Tomeu Vizoso wrote:
> To allow userspace to prevent this message from appearing in the
> console by changing the log priority.
> 
> This matches other informative messages that the power subsystem emits
> when the system changes power states.

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have pushed it into printk.git, branch for-4.17.

Best Regards,
Petr
