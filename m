Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBISqd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:46:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39218 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751004AbeBISqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:46:31 -0500
Date: Fri, 9 Feb 2018 13:46:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, <mingo@kernel.org>,
        <parri.andrea@gmail.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <akiyks@gmail.com>
Subject: Re: [PATCH RFC tip/lkmm 04/10] EXP litmus_tests:  Add comments
 explaining tests' purposes
In-Reply-To: <1518186031-17997-4-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802091345180.1460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018, Paul E. McKenney wrote:

> This commit adds comments to the litmus tests summarizing what these
> tests are intended to demonstrate.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [ paulmck: Apply Andrea's and Alan's feedback. ]
> ---

> --- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> +++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> @@ -1,5 +1,15 @@
>  C IRIW+poonceonces+OnceOnce
>  
> +(*
> + * Result: Never
> + *
> + * Test of independent reads from independent writes with nothing
> + * between each pairs of reads.  In other words, is anything at all
> + * needed to cause two different reading processes to agree on the order
> + * of a pair of writes, where each write is to a different variable by a
> + * different process?
> + *)

The result should be Sometimes.

Alan
