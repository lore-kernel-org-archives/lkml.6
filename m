Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeCWTPe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:15:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeCWTPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:15:32 -0400
Date: Fri, 23 Mar 2018 12:15:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Huacai Chen <chenhc@lemote.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Rich Felker <dalias@libc.org>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-omap@vger.kernel.org,
        James Hogan <james.hogan@mips.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression with arm in next with stack protector
Message-Id: <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
In-Reply-To: <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
References: <20180323181452.GJ5799@atomide.com>
        <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 15:45:27 -0300 Fabio Estevam <festevam@gmail.com> wrote:

> On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > compressed boot phase") breaks booting on arm.
> 
> Yes, almost all imx are broken in linux-next due to this commit:
> https://kernelci.org/soc/imx/job/next/kernel/next-20180323/

Thanks, I dropped it and I expect Stephen will also do that.
