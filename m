Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBWVd5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:33:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751527AbeBWVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:33:54 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: [PATCH v0 0/3] additional cumulative livepatch doc/samples
Date: Fri, 23 Feb 2018 16:33:47 -0500
Message-Id: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miroslav,

This is a follow up to my comment on "Re: [PATCH v8 8/8] livepatch:
Atomic replace and cumulative patches documentation".

Here's what I was working on today, I can update for v9 and squash into
a single patch or two if that fits into the patchset better.  (Or Petr,
feel free to grab these and run with them if you prefer.)

I definitely agree that the complexity of the scenarios and cornercases
is starting to get out of hand, at least in keeping it all in my brain
for any period of time :)

I like the idea of transforming the growing sample set into a testsuite
of some kind.  Having regression tests would ease the burden of
reviewing patches and accounting for all these use cases!

Hope these help, let me know if you'd like any modification or other
tests.

Joe Lawrence (3):
  livepatch: add sample cumulative patch
  livepatch: update documentation/samples for callbacks
  livepatch: update documentation for shadow variables

 Documentation/livepatch/callbacks.txt         | 102 ++++++++++++
 Documentation/livepatch/shadow-vars.txt       |  24 +++
 samples/livepatch/Makefile                    |   2 +
 samples/livepatch/livepatch-callbacks-demo2.c | 162 +++++++++++++++++++
 samples/livepatch/livepatch-cumulative.c      | 216 ++++++++++++++++++++++++++
 5 files changed, 506 insertions(+)
 create mode 100644 samples/livepatch/livepatch-callbacks-demo2.c
 create mode 100644 samples/livepatch/livepatch-cumulative.c

-- 
1.8.3.1
