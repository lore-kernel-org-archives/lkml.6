Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeBANoB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:44:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbeBANoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:44:00 -0500
Date: Thu, 1 Feb 2018 13:44:01 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 2/2] MAINTAINERS: add the Memory Consistency Model
 subsystem
Message-ID: <20180201134401.GE9182@arm.com>
References: <1517486666-11011-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517486666-11011-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 01:04:26PM +0100, Andrea Parri wrote:
> Integrate (and then remove) tools/memory-model/MAINTAINERS into the
> main MAINTAINERS file. This way get_maintainer.pl can give a "right
> answer" for tools/memory-model/.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  MAINTAINERS                    | 16 ++++++++++++++++
>  tools/memory-model/MAINTAINERS | 15 ---------------
>  2 files changed, 16 insertions(+), 15 deletions(-)
>  delete mode 100644 tools/memory-model/MAINTAINERS

Acked-by: Will Deacon <will.deacon@arm.com>

Makes a lot more sense having this in the top-level MAINTAINERS file.
It might also make sense to add:

  F:	Documentation/memory-barriers.txt

as a separate patch now that we have a hit-list of memory model people
who can help poor old Jon (who currently gets blamed by get_maintainer.pl).

Will
