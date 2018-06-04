Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbeFDSo6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751010AbeFDSo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:44:57 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 0/2] faddr2line fix and MAINTAINERS update
Date: Mon,  4 Jun 2018 13:42:12 -0500
Message-Id: <cover.1528137452.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, would you be willing to pick these up directly, or would you
rather me route them through somebody else?

Patch 1 reverts faddr2line's default output to its original
non-code-listing output, and makes the code listing an optional feature.

Patch 2 gives faddr2line a real maintainer, so get_maintainer.pl will
actually CC me on future patches.

Josh Poimboeuf (1):
  MAINTAINERS: add Josh Poimboeuf as faddr2line maintainer

Peter Zijlstra (Intel) (1):
  scripts/faddr2line: make the new code listing format optional

 MAINTAINERS        |  5 +++++
 scripts/faddr2line | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.0
