Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758263AbeBPPrP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:47:15 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39026 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756578AbeBPPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:47:13 -0500
X-Google-Smtp-Source: AH8x2263Lnha64jLlFBmuSJPDkZwd5bXKJ37jTcNYUu+hwFSnhPaiHVsTpW5j0kzDqYqIUPo7zY3Xw==
Date: Fri, 16 Feb 2018 16:47:04 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: Trial of conflict resolution of Alan's patch
Message-ID: <20180216154704.GA29493@andrea>
References: <fe361fba-d6ec-3a70-6ab9-e148bccb5833@gmail.com>
 <Pine.LNX.4.44L0.1802161015010.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802161015010.1402-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:18:34AM -0500, Alan Stern wrote:
> On Fri, 16 Feb 2018, Akira Yokosawa wrote:
> 
> > Hi,
> > 
> > My forward-port patch doesn't apply to the "lkmm" branch.
> > It looks like "linux-kernel-hardware.cat" is intentionally omitted there.
> > Am I guessing right?
> > 
> > If this is the case, I can prepare a patch to be applied to "lkmm".
> > But I can't compose a proper change log. So I'd like Alan to post
> > a patch with my SOB appended. Does this approach sound reasonable?
> 
> The patch is not yet ready to be merged.  At the very least, I need to
> include an update to explanation.txt along with it.  When it is all 
> ready, I will rebase it on Paul's repository and post it.
> 
> Which reminds me: Now that the material has been accepted into the 
> kernel, do we need to keep the github repository?  It has the 
> linux-kernel-hardware.cat file, but otherwise it seems to be redundant.

If you mean "to keep up-to-date", I'd say "No, we don't..."  ;-)

My plan/hope is to add such a disclaimer together with a pointer
to Linus's tree ASAP...

  Andrea


> 
> Alan
> 
