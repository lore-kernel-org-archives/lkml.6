Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5177FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83E420850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83E420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbeGTRXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:23:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:51959 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbeGTRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:23:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 09:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,380,1526367600"; 
   d="scan'208";a="66224835"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2018 09:34:20 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1fgYMG-0007lx-20; Fri, 20 Jul 2018 19:34:20 +0300
Date:   Fri, 20 Jul 2018 19:34:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.18-2
Message-ID: <20180720163420.GA29856@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Simple one liner regression fix which has no conflicts with current master.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.18-2

for you to fetch changes up to 2502e5a025935b7b476b69eda4959b3c4022c72b:

  platform/x86: dell-laptop: Fix backlight detection (2018-07-20 15:29:59 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v4.18-2

The Dell laptop ACPI video brightness control is now back
after fixing a regression brought by SMM refactoring.

The following is an automated git shortlog grouped by driver:

dell-laptop:
 -  Fix backlight detection

----------------------------------------------------------------
Damien Thébault (1):
      platform/x86: dell-laptop: Fix backlight detection

 drivers/platform/x86/dell-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
With Best Regards,
Andy Shevchenko


