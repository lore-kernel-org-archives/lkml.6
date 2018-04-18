Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeDRLms (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:42:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbeDRLmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:42:47 -0400
Date: Wed, 18 Apr 2018 13:42:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsprintf: Tweak pF/pf comment
Message-ID: <20180418114244.uhxdxhr4lhoryqrl@pathway.suse.cz>
References: <20180414030005.25831-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414030005.25831-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-04-14 12:00:05, Sergey Senozhatsky wrote:
> Reflect changes that have happened to pf/pF (deprecation)
> specifiers in pointer() comment section.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Good catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have pushed this into printk.git, branch for-4.18-vsprintf-cleanup.

Best Regards,
Petr
