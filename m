Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBTIxc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:53:32 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38646 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBTIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:53:30 -0500
X-Google-Smtp-Source: AH8x226bUL6XUB05kCpKD8RTrdn0+NlXaSF48aoBk+GWrHdEOOXrwJI5ROeRtgnQ5I/vMGUAsGWrlQ==
From: minchan@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH RESEND 0/2] swap readahead clean up
Date: Tue, 20 Feb 2018 17:52:47 +0900
Message-Id: <20180220085249.151400-1-minchan@kernel.org>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minchan Kim <minchan@kernel.org>

This patchset cleans up recent added vma-based readahead code via
unifying cluster-based readahead.

Resent based on mmotm-2018-02-06-16-41.

Minchan Kim (2):
  mm: swap: clean up swap readahead
  mm: swap: unify cluster-based and vma-based swap readahead

 include/linux/swap.h |  38 +++---------
 mm/memory.c          |  33 +++--------
 mm/shmem.c           |   5 +-
 mm/swap_state.c      | 137 +++++++++++++++++++++++++++----------------
 4 files changed, 105 insertions(+), 108 deletions(-)

-- 
2.16.1.291.g4437f3f132-goog
