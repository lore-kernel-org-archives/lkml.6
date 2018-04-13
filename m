Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeDMR4T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:56:19 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:45841 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeDMR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:56:17 -0400
Date: Fri, 13 Apr 2018 10:56:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180413175615.GA30242@roeck-us.net>
References: <20180412215501.GA16406@roeck-us.net>
 <CAMJBoFMq8DoWdcrajB_xyMrGXsUsbMjos_U60mOvf01MpK_9Kw@mail.gmail.com>
 <20180413173555.GA30587@roeck-us.net>
 <CAMJBoFPXObpXyQWz-zPJ7JnC-Z5FqqrLfr5BFWKdh+szZrPZ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJBoFPXObpXyQWz-zPJ7JnC-Z5FqqrLfr5BFWKdh+szZrPZ7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 05:40:18PM +0000, Vitaly Wool wrote:
> On Fri, Apr 13, 2018, 7:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Fri, Apr 13, 2018 at 05:21:02AM +0000, Vitaly Wool wrote:
> > > Hi Guenter,
> > >
> > >
> > > Den fre 13 apr. 2018 kl 00:01 skrev Guenter Roeck <linux@roeck-us.net>:
> > >
> > > > Hi all,
> > >
> > > > we are observing crashes with z3pool under memory pressure. The kernel
> > > version
> > > > used to reproduce the problem is v4.16-11827-g5d1365940a68, but the
> > > problem was
> > > > also seen with v4.14 based kernels.
> > >
> > >
> > > just before I dig into this, could you please try reproducing the errors
> > > you see with https://patchwork.kernel.org/patch/10210459/ applied?
> > >
> >
> > As mentioned above, I tested with v4.16-11827-g5d1365940a68, which already
> > includes this patch.
> >
> 
> Bah. Sorry. Expect an update after the weekend.
> 
NP; easy to miss. Thanks a lot for looking into it.

Guenter
