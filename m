Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755304AbeEaNzD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:55:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:4655 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755155AbeEaNzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:55:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="233274568"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] mm/page_ext: Trivial cleanups
Date: Thu, 31 May 2018 16:54:55 +0300
Message-Id: <20180531135457.20167-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pair of trivial cleanups in preparation for memory encryption.

Kirill A. Shutemov (2):
  mm/page_ext: Drop definition of unused PAGE_EXT_DEBUG_POISON
  mm/page_ext: Constify lookup_page_ext() argument

 include/linux/page_ext.h | 15 ++-------------
 mm/page_ext.c            |  4 ++--
 2 files changed, 4 insertions(+), 15 deletions(-)

-- 
2.17.0
