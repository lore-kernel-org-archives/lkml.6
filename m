Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCOMw4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:52:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCOMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:52:54 -0400
Date: Thu, 15 Mar 2018 13:52:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the printk tree with the asm-generic
 tree
Message-ID: <20180315125252.2igbbslfrmtp6kqq@pathway.suse.cz>
References: <20180315114500.65daa865@canb.auug.org.au>
 <20180315075006.GC3628@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315075006.GC3628@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-03-15 16:50:06, Sergey Senozhatsky wrote:
> On (03/15/18 11:45), Stephen Rothwell wrote:
> > Hi Petr,
> > 
> > Today's linux-next merge of the printk tree got a conflict in:
> > 
> >   arch/blackfin/kernel/dumpstack.c
> > 
> > between commit:
> > 
> >   e7e57f690e38 ("arch: remove blackfin port")
> > 
> > from the asm-generic tree and commit:
> > 
> >   33251b634b4a ("dump_stack: convert generic dump_stack into a weak symbol")
> > 
> > from the printk tree.
> 
> If blackfin is gone and nds32 was fixed then we can drop my patch.

I have just dropped the patch.

Thanks,
Petr
