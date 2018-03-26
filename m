Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeCZVaR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:30:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeCZVaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:30:15 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] Small HMM fixes
Date: Mon, 26 Mar 2018 17:30:07 -0400
Message-Id: <20180326213009.2460-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Two small fixes on top of what i already sent. First one fix a real
dumb mistake (i did). Second one fix fault logic to be consistant in
respect to all combinations.

No cc-ing stable for lack of current upstream user.

Kudos to Ralph for catching those.

Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>

Ralph Campbell (2):
  mm/hmm: do not ignore specific pte fault flag in hmm_vma_fault()
  mm/hmm: clarify fault logic for device private memory

 mm/hmm.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.14.3
