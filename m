Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeEEK7J (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:59:09 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:44581 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:59:08 -0400
X-Google-Smtp-Source: AB8JxZocj70K/V5RGXOZOxLVFvWvgYfCDms9ygqwkqCfAQzaSAAq/WxdIOr0hhh2c1mp3pvkBaq0qQ==
Date: Sat, 5 May 2018 12:59:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics: Shorten the __atomic_op() defines to
 __op()
Message-ID: <20180505105904.wczhfmerx3pdfmpz@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090903.ebsf5vosgwckxooy@gmail.com>
 <20180505092911.GC12217@hirez.programming.kicks-ass.net>
 <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> If that's too then there's a few more things we could do - for example the 
              ^--too much
> attached patch renames a (very minor) misnomer to a shorter name and thus saves on 
> the longest lines, the column histogram now looks like this:

Thanks,

	Ingo
