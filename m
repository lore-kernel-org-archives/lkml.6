Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBANkj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:40:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeBANke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:40:34 -0500
Date: Thu, 1 Feb 2018 13:40:35 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] tools/memory-model: clarify the origin/scope of the
 tool name
Message-ID: <20180201134035.GD9182@arm.com>
References: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 01:03:29PM +0100, Andrea Parri wrote:
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
> ---
>  tools/memory-model/MAINTAINERS       |  2 +-
>  tools/memory-model/README            | 14 +++++++-------
>  tools/memory-model/linux-kernel.bell |  2 +-
>  tools/memory-model/linux-kernel.cat  |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
