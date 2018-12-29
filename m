Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA767C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB59F2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeL2Tw7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:52:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:51319 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbeL2Tw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:52:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2018 11:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,414,1539673200"; 
   d="scan'208";a="110849482"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 29 Dec 2018 11:52:58 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 29 Dec 2018 11:52:57 -0800
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.51]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.85]) with mapi id 14.03.0415.000;
 Sat, 29 Dec 2018 11:52:57 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] dax fix for 4.21
Thread-Topic: [GIT PULL] dax fix for 4.21
Thread-Index: AQHUn7AXWHoyredGpkqAbTVar8Vytg==
Date:   Sat, 29 Dec 2018 19:52:56 +0000
Message-ID: <b7f5fe8af0fe10a9aeabf4b48a7cf8c126676c24.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.6.233]
Content-Type: text/plain; charset="utf-7"
Content-ID: <8B71ED7FF2DD1043A6A396D99AE992DF@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-4.21

...to receive a single fix for an issue you identified on the last dax
fix pull request. While I feel a bit silly sending a single-commit
pull-request there is nothing else queued up for dax this cycle. This
change has shipped in -next for multiple releases.

---

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-4.21

for you to fetch changes up to d8a706414af4827fc0b4b1c0c631c607351938b9:

  dax: Use non-exclusive wait in wait+AF8-entry+AF8-unlocked() (2018-12-21 11:35:53 -0800)

----------------------------------------------------------------
dax fix 4.21

+ACo- Clean up unnecessary usage of prepare+AF8-to+AF8-wait+AF8-exclusive()

----------------------------------------------------------------
Dan Williams (1):
      dax: Use non-exclusive wait in wait+AF8-entry+AF8-unlocked()

 fs/dax.c +AHw- 16 +-+-+-+-+-+-+----------
 1 file changed, 7 insertions(+-), 9 deletions(-)
