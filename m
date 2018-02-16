Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758083AbeBPPD6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:03:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755688AbeBPPD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:03:57 -0500
Date: Fri, 16 Feb 2018 09:03:56 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Progyan Bhattacharya <bprogyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] objtool/x86: Replace Non-standard Range Expression in
 Case
Message-ID: <20180216150356.qnxkr3jopfmt3o5q@treble>
References: <20180216142513.9520-1-progyanb@acm.org>
 <20180216143924.9918-1-progyanb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216143924.9918-1-progyanb@acm.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 08:09:24PM +0530, Progyan Bhattacharya wrote:
> Replace range expressions with seperate individual cases, i.e. convert case 1...3: to case 1: case 2: case 3
> Range expression within case statements are non-standard C code and can create issues over compiler and platform variety.
> 
> While compiling with gcc 4.8 (RHEL) I encountered this error on range expression in case statements:
> error: range expressions in switch statements are non-standard [-Werror=pedantic]
> 
> Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>

Progyan,

Please try to be respectful of reviewers' time by

  a) running scripts/checkpatch.pl and closely reviewing your patch
     before sending;

  b) not sending multiple revisions in a single day;

  c) when sending a new revision, add the version number in the subject
     line and clarify what has changed.


I'd also recommend reviewing the following resources:

  - https://www.youtube.com/watch?v=-3HNeoFuSH0

  - Documentation/process/submitting-patches.rst

-- 
Josh
