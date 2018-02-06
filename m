Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeBFAYs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:24:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeBFAYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:30 -0500
Date: Mon, 5 Feb 2018 16:24:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: bisected bd4c82c22c367e is the first bad commit (was [Bug
 198617] New: zswap causing random applications to crash)
Message-Id: <20180205162428.99efbedb5a6e19bee19ba954@linux-foundation.org>
In-Reply-To: <20180205123947.GA426@jagdpanzerIV>
References: <20180130114841.aa2d3bd99526c03c6a5b5810@linux-foundation.org>
        <20180203013455.GA739@jagdpanzerIV>
        <CAC=cRTPyh-JTY=uOQf2dgmyPDyY-4+ryxkedp-iZMcFQZtnaqw@mail.gmail.com>
        <20180205013758.GA648@jagdpanzerIV>
        <87d11j4pdy.fsf@yhuang-dev.intel.com>
        <20180205123947.GA426@jagdpanzerIV>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 21:39:47 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > ---------------------------------8<-------------------------------
> > From 4c52d531680f91572ebc6f4525a018e32a934ef0 Mon Sep 17 00:00:00 2001
> > From: Huang Ying <huang.ying.caritas@gmail.com>
> > Date: Mon, 5 Feb 2018 19:27:43 +0800
> > Subject: [PATCH] fontswap thp fix
> 
> Seems to be fixing the problem on my x86 box. Executed several tests, no
> crashes were observed. Can run more tests tomorrow.

Thanks.  I queued this for 4.16 with a cc:stable and a Fixes:
bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
out").

Can we please have a changelog ;)
