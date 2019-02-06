Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D382C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0716D2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfBFHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:24:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:5368 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfBFHYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:24:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 23:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="316707545"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2019 23:24:42 -0800
Subject: [PATCH 0/2] mm/shuffle: Fix + default enable
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 23:12:05 -0800
Message-ID: <154943712485.3858443.4491117952728936852.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please fold patch1 into:
mm-shuffle-initial-free-memory-to-improve-memory-side-cache-utilization.patch

Patch2, as marked, is the "always-on" shuffle patch for -mm only.

---

Dan Williams (2):
      mm/shuffle: Fix shuffle enable
      [-mm only] mm/shuffle: Default enable all shuffling


 init/Kconfig |    4 ++--
 mm/shuffle.c |   20 +++++++++++++++++---
 mm/shuffle.h |    2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)
