Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbeDWMqL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:46:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754802AbeDWMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:46:10 -0400
Date: Mon, 23 Apr 2018 14:45:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        dan.j.williams@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180423124552.GY4064@hirez.programming.kicks-ass.net>
References: <20180419051510.GA21898@mwanda>
 <20180420120044.GN4064@hirez.programming.kicks-ass.net>
 <fb72fc65-085b-65dc-c965-492d6d0902ea@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb72fc65-085b-65dc-c965-492d6d0902ea@embeddedor.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 07:31:03AM -0500, Gustavo A. R. Silva wrote:
> Hi Peter,
> 
> On 04/20/2018 07:00 AM, Peter Zijlstra wrote:
> > 
> > Hi Dan,
> > 
> > awesome stuff...
> > 
> > So I fear that many are actually things we want to fix. Our policy was
> > to kill the speculation on the first load and not worry if it can be
> > completed with a dependent load/store.
> > 
> I wonder if there is any thread where I can read the discussion about that
> policy that you mention.
> 
> Could you share it here, please?

I think it was somewhere in the many spectre variant1 threads when Linus
Alexei and Dan W were hashing out the mitigation thing. I cannot quickly
find the specific email.

Clarifying that position was one reason for the patches I did, Linus and
Dan W are on Cc and I figure that if they all agree we should maybe add
a little something to Documentation/speculation.txt.
