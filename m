Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCOHuO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:50:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46073 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeCOHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:50:12 -0400
X-Google-Smtp-Source: AG47ELvCmvaVsqcMrYOP7YV6h+oyZsFYCP/ja3u3/humQFIAynr4viRzk/WvJ82vMzCMbTCtUKSVKw==
Date: Thu, 15 Mar 2018 16:50:06 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: linux-next: manual merge of the printk tree with the asm-generic
 tree
Message-ID: <20180315075006.GC3628@jagdpanzerIV>
References: <20180315114500.65daa865@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315114500.65daa865@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/15/18 11:45), Stephen Rothwell wrote:
> Hi Petr,
> 
> Today's linux-next merge of the printk tree got a conflict in:
> 
>   arch/blackfin/kernel/dumpstack.c
> 
> between commit:
> 
>   e7e57f690e38 ("arch: remove blackfin port")
> 
> from the asm-generic tree and commit:
> 
>   33251b634b4a ("dump_stack: convert generic dump_stack into a weak symbol")
> 
> from the printk tree.

If blackfin is gone and nds32 was fixed then we can drop my patch.

	-ss
