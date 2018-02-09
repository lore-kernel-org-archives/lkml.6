Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeBIINd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:13:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeBIINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:13:32 -0500
Date: Fri, 9 Feb 2018 09:13:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 0/2] objtool fixes on top of Peter's WARN UD2 patch
Message-ID: <20180209081322.GJ25201@hirez.programming.kicks-ass.net>
References: <20180208203146.GF577@pd.tnic>
 <cover.1518130694.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518130694.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 05:09:24PM -0600, Josh Poimboeuf wrote:
> Josh Poimboeuf (2):
>   objtool: Fix seg fault in ignore_unreachable_insn()
>   x86: Annotate WARN-related UD2 as reachable

Ah, thanks for saving me the trouble of digging these out of history. I
did remember you did them back then, now I don't even have to go find
them ;-)
