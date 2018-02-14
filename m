Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032904AbeBNQtV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:49:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:45977 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032526AbeBNQtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:49:19 -0500
Subject: Re: [PATCH 2/3] x86/xen: Remove inert tracepoint in __init code
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <e6d9f3b13f2a5a55a0b158e79dfc5a2d8dc40bd7.1518626149.git.jpoimboe@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <b5a49222-9555-d986-ebcf-ca102c631e23@suse.com>
Date: Wed, 14 Feb 2018 17:49:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e6d9f3b13f2a5a55a0b158e79dfc5a2d8dc40bd7.1518626149.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 17:40, Josh Poimboeuf wrote:
> The jump_label code doesn't patch init code, so this tracepoint can
> never be enabled.  Remove it.
> 
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
