Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeBVUVp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:21:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBVUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:21:44 -0500
Date: Thu, 22 Feb 2018 12:21:40 -0800
From: Darren Hart <dvhart@infradead.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] platform/x86: Only activate tablet mode switch on
 2-in-1's
Message-ID: <20180222202140.GF19843@fury>
References: <1519329522-16919-1-git-send-email-mario.limonciello@dell.com>
 <01000161bf28670e-bfeaa576-853c-4760-a362-d6abdaa474f1-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000161bf28670e-bfeaa576-853c-4760-a362-d6abdaa474f1-000000@email.amazonses.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 08:15:51PM +0000, Jeremy Cline wrote:
> On Thu, Feb 22, 2018 at 01:58:42PM -0600, Mario Limonciello wrote:
> > Some laptops such as the XPS 9360 support the intel-vbtn INT33D6
> > interface but don't initialize the bit that intel-vbtn uses to
> > represent switching tablet mode.
> > 
> > By running this only on real 2-in-1's it shouldn't cause false
> > positives.
> > 
> > Fixes: 30323fb6d5 ("Support tablet mode switch")
> > Reported-by: Jeremy Cline <jeremy@jcline.org>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> > Note: I also moved the code for detecting tablet into it's own
> > function.  To keep things under 80 lines with if statements was
> > making the code very unreadable otherwise.
> > 
...
> 
> Tested-by: Jeremy Cline <jeremy@jcline.org>

Wow, incredible turn around time Mario and Jeremy. Doing some
confirmation on my end, and will queue up to Fixes for 4.16 RC cycle.

-- 
Darren Hart
VMware Open Source Technology Center
