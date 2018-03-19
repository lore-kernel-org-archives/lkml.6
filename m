Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755301AbeCSHL3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:11:29 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34286 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754531AbeCSHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:11:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.03234225|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.BMahwd9_1521443468;
Date: Mon, 19 Mar 2018 15:11:08 +0800
From: Guo Ren <ren_guo@c-sky.com>
To: Joe Perches <joe@perches.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net,
        arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Message-ID: <20180319071107.GD21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <1521404757.27411.46.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521404757.27411.46.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Joe,

On Sun, Mar 18, 2018 at 01:25:57PM -0700, Joe Perches wrote:
> On Mon, 2018-03-19 at 03:51 +0800, Guo Ren wrote:
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.16-rc5.
> > 
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)
> 
> []
> 
> > It's my first patchset to linux and any feedback is welcome :)
> 
> Hello.  You might try to do a git am <series>
> on a new branch and correct the various
> git whitespace messages that are produced.
> 
> It's also possible to run checkpatch and correct
> some of the linux-kernel code style conformance
> nits it lists.
> 
> Perhaps something like:
> 
> $ git ls-files arch/csky/ | \
>   while read file ; do \
>     ./scripts/checkpatch.pl --strict --terse --no-summary $file ; \
>   done
> 
> add --fix-inplace to the checkpatch line if desired.

OK

Best Regards
 Guo Ren
