Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCOMwE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:52:04 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52099 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751508AbeCOMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:52:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>, linux-kernel@vger.kernel.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180315123202.419618431@infradead.org>
Cc: "Dan Williams" <dan.j.williams@intel.com>,
        "David Howells" <dhowells@redhat.com>,
        "Daniel Vetter" <daniel.vetter@intel.com>,
        "David Airlie" <airlied@linux.ie>,
        "Stanimir Varbanov" <stanimir.varbanov@linaro.org>,
        "Chris Mason" <clm@fb.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Joel Becker" <jlbec@evilplan.org>, "James Hogan" <jhogan@kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "George Spelvin" <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20180315121902.942902000@infradead.org>
 <20180315123202.419618431@infradead.org>
Message-ID: <152111822018.25315.4881212793091836591@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH 02/11] sched/wait,drm: Replace wait_on_atomic_t usage
Date: Thu, 15 Mar 2018 12:50:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Zijlstra (2018-03-15 12:19:04)
> Convert the wait_on_atomic_t() usage to the new wait_var_event() API.
> 
> Unlike the wake_up_atomic_t(), wake_up_var() will issue the wakeup
> even if the variable is not 0.
> 
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
