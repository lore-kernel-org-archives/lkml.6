Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162496AbeBOPW4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:22:56 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40435 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:22:51 -0500
X-Google-Smtp-Source: AH8x226pIz5D1nNuLCrZCMYcSxMuc5ZaqapNaQYqIPYQh2L+NBWNvZ/wW5Tcik5l+XAmr1xZGWX3Kg==
Date: Thu, 15 Feb 2018 07:22:46 -0800
From: Tejun Heo <tj@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/3] percpu: Remove inert tracepoint in __init code
Message-ID: <20180215152246.GT695913@devbig577.frc2.facebook.com>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <42d6bf23a6d151b5d13778be969c7a063d60665a.1518626149.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d6bf23a6d151b5d13778be969c7a063d60665a.1518626149.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:40:43AM -0600, Josh Poimboeuf wrote:
> The jump_label code doesn't patch init code, so this tracepoint can
> never be enabled.  Remove it.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Applied to percpu/for-4.17.

Thanks.

-- 
tejun
