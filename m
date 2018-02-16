Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeBPPSg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:18:36 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53620 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752192AbeBPPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:18:35 -0500
Date: Fri, 16 Feb 2018 10:18:34 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Akira Yokosawa <akiyks@gmail.com>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
        <parri.andrea@gmail.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: Trial of conflict resolution of Alan's patch
In-Reply-To: <fe361fba-d6ec-3a70-6ab9-e148bccb5833@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1802161015010.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Akira Yokosawa wrote:

> Hi,
> 
> My forward-port patch doesn't apply to the "lkmm" branch.
> It looks like "linux-kernel-hardware.cat" is intentionally omitted there.
> Am I guessing right?
> 
> If this is the case, I can prepare a patch to be applied to "lkmm".
> But I can't compose a proper change log. So I'd like Alan to post
> a patch with my SOB appended. Does this approach sound reasonable?

The patch is not yet ready to be merged.  At the very least, I need to
include an update to explanation.txt along with it.  When it is all 
ready, I will rebase it on Paul's repository and post it.

Which reminds me: Now that the material has been accepted into the 
kernel, do we need to keep the github repository?  It has the 
linux-kernel-hardware.cat file, but otherwise it seems to be redundant.

Alan
