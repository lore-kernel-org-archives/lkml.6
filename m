Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeEPDsH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 23:48:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeEPDsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 23:48:06 -0400
Date: Tue, 15 May 2018 22:48:02 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org, x86@kernel.org
Subject: Re: [RFC 0/8] Improving compiler inlining decisions
Message-ID: <20180516034802.nuf7ft65nvtgc65j@treble>
References: <20180515141124.84254-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 07:11:07AM -0700, Nadav Amit wrote:
> This patch-set deals with an interesting yet stupid problem: code that
> does not get inlined despite its simplicity.

I got the 0/8 patch twice, and didn't get the 1/8 patch.  Was there an
issue with the sending of the patches?

-- 
Josh
