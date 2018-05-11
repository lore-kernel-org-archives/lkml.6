Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeEKByy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:54:54 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:40283 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKByx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:54:53 -0400
X-Google-Smtp-Source: AB8JxZqIqK3V/kqaPL8aD4UYGuYbIjXgK5RdOt5TF9By5Z6NH4zkJ4ZXc/Ki3ivh4FryeUfrDFkTSg==
Date: Fri, 11 May 2018 10:54:48 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] printk: Remove pr_fmt duplicate logging prefixes
Message-ID: <20180511015448.GC895@jagdpanzerIV>
References: <cover.1525964381.git.joe@perches.com>
 <fdcd68ac1b1c8d5e51fa04e65862c838767c04c3.1525964385.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdcd68ac1b1c8d5e51fa04e65862c838767c04c3.1525964385.git.joe@perches.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/18 08:45), Joe Perches wrote:
> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
