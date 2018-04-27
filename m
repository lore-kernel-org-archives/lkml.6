Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757862AbeD0JdT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:33:19 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35775 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757361AbeD0JdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:33:15 -0400
X-Google-Smtp-Source: AB8JxZqbE9BtZKI922575hkDMbNkleU0HvNZexD7dyP1DNlkz3g4pIVt3nJnv0uAH2F6Ncy1mB70+Q==
Date: Fri, 27 Apr 2018 11:33:11 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, boqun.feng@gmail.com,
        paulmck@linux.vnet.ibm.com, longman@redhat.com
Subject: Re: [PATCH v3 00/14] kernel/locking: qspinlock improvements
Message-ID: <20180427093311.nhvwulz5boqcq5ik@gmail.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <20180426155427.GM4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426155427.GM4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Ingo, please queue.

Applied to tip:locking/core, thanks guys!

	Ingo
