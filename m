Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeERInK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:43:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41733 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753575AbeERInI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:43:08 -0400
Date: Fri, 18 May 2018 10:43:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] printk: Remove pr_fmt duplicate logging prefixes
Message-ID: <20180518084306.akhmxfbxl5bk5vsj@pathway.suse.cz>
References: <cover.1525964381.git.joe@perches.com>
 <fdcd68ac1b1c8d5e51fa04e65862c838767c04c3.1525964385.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdcd68ac1b1c8d5e51fa04e65862c838767c04c3.1525964385.git.joe@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-10 08:45:39, Joe Perches wrote:
> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
