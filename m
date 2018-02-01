Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBAP04 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:26:56 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48038 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751742AbeBAP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:26:51 -0500
Date: Thu, 1 Feb 2018 10:26:50 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrea Parri <parri.andrea@gmail.com>
cc: will.deacon@arm.com, <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <paulmck@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@kernel.org>
Subject: Re: [PATCH 1/2] tools/memory-model: clarify the origin/scope of the
 tool name
In-Reply-To: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1802011026250.1677-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018, Andrea Parri wrote:

> Ingo pointed out that:
> 
>   "The "memory model" name is overly generic, ambiguous and somewhat
>    misleading, as we usually mean the virtual memory layout/model
>    when we say "memory model". GCC too uses it in that sense [...]"
> 
> Make it clearer that, in the context of tools/memory-model/, the term
> "memory-model" is used as shorthand for "memory consistency model" by
> calling out this convention in tools/memory-model/README.
> 
> Stick to the full name in sources' headers and for the subsystem name.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

For both patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
