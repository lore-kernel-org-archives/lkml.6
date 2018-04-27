Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758951AbeD0RSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:18:41 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:41775 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758928AbeD0RSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:18:37 -0400
Date: Fri, 27 Apr 2018 10:18:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, Gwendal Grignou <gwendal@chromium.org>
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180427171835.GB628@roeck-us.net>
References: <20180417160032.46915216@seldlx21914.corpusers.net>
 <20180418101317.74abe632@seldlx21914.corpusers.net>
 <20180418160755.GA10227@roeck-us.net>
 <CAMJBoFO9ktEHK=e=Dkq99tNNKHM1iPuxUJ5bmyoX_bzjGwOmig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJBoFO9ktEHK=e=Dkq99tNNKHM1iPuxUJ5bmyoX_bzjGwOmig@mail.gmail.com>
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

Hi Vitaly,

On Thu, Apr 19, 2018 at 08:18:51AM +0000, Vitaly Wool wrote:
> Hi Guenter,
> 
> Den ons 18 apr. 2018 kl 18:07 skrev Guenter Roeck <linux@roeck-us.net>:
> 
> > On Wed, Apr 18, 2018 at 10:13:17AM +0200, Vitaly Wool wrote:
> > > Den tis 17 apr. 2018 kl 18:35 skrev Guenter Roeck <linux@roeck-us.net>:
> > >
> > > <snip>
> > >
> > > > Getting better; the log is much less noisy. Unfortunately, there are
> > still
> > > > locking problems, resulting in a hung task. I copied the log message
> > to [1].
> > > > This is with [2] applied on top of v4.17-rc1.
> > >
> > > Now this version (this is a full patch to be applied instead of the
> > previous one) should have the above problem resolved too:
> > >
> >
> > Excellent - I can not reproduce the problem with this patch
> > applied.
> >
> > thank you very much for testing and prompt feedback. I'll come up shortly
> with the final patch.
> 

Any updates ?

Thanks,
Guenter
