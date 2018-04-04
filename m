Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeDDRPM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbeDDRPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:15:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857D820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 13:15:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] lockdep: Do not record irq state in
 debug_check_no_locks_freed()
Message-ID: <20180404131501.0eeb0139@gandalf.local.home>
In-Reply-To: <20180404162305.GK4043@hirez.programming.kicks-ass.net>
References: <20180404121904.6713fb9d@gandalf.local.home>
        <20180404162305.GK4043@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 18:23:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Makes sense, could you convert all of them just to make sure there
> aren't any left?

There's a few others. I'll send another patch.

-- Steve
