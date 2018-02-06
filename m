Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeBFCbL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:31:11 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35480 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBFCbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:31:06 -0500
X-Google-Smtp-Source: AH8x224fPKqDSUJ2tXpzhm8f3++3MNwzicviCG4WMxlY0/ZJcJqBY4eRz3s9164ToXqzAFep3r+8zw==
Date: Tue, 6 Feb 2018 11:31:00 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: bisected bd4c82c22c367e is the first bad commit (was [Bug
 198617] New: zswap causing random applications to crash)
Message-ID: <20180206023100.GA462@jagdpanzerIV>
References: <20180130114841.aa2d3bd99526c03c6a5b5810@linux-foundation.org>
 <20180203013455.GA739@jagdpanzerIV>
 <CAC=cRTPyh-JTY=uOQf2dgmyPDyY-4+ryxkedp-iZMcFQZtnaqw@mail.gmail.com>
 <20180205013758.GA648@jagdpanzerIV>
 <87d11j4pdy.fsf@yhuang-dev.intel.com>
 <20180205123947.GA426@jagdpanzerIV>
 <20180205162428.99efbedb5a6e19bee19ba954@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205162428.99efbedb5a6e19bee19ba954@linux-foundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/05/18 16:24), Andrew Morton wrote:
> On Mon, 5 Feb 2018 21:39:47 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > > ---------------------------------8<-------------------------------
> > > From 4c52d531680f91572ebc6f4525a018e32a934ef0 Mon Sep 17 00:00:00 2001
> > > From: Huang Ying <huang.ying.caritas@gmail.com>
> > > Date: Mon, 5 Feb 2018 19:27:43 +0800
> > > Subject: [PATCH] fontswap thp fix
> > 
> > Seems to be fixing the problem on my x86 box. Executed several tests, no
> > crashes were observed. Can run more tests tomorrow.
> 
> Thanks.  I queued this for 4.16 with a cc:stable and a Fixes:
> bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
> out").
> 
> Can we please have a changelog ;)

Thanks!

Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
