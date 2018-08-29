Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B80C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B71C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH2Jxs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:53:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:43224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeH2Jxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:53:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 22:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="66799707"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.67])
  by fmsmga008.fm.intel.com with SMTP; 28 Aug 2018 22:58:29 -0700
Received: by ubuntu (sSMTP sendmail emulation); Wed, 29 Aug 2018 13:58:28 +0800
Message-ID: <1535522308.5357.6.camel@intel.com>
Subject: [GIT PULL] arch/nios2 update for v4.19-rc2
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>
Date:   Wed, 29 Aug 2018 13:58:28 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

There is one arch/nios2 update for v4.19-rc2.
Please consider pulling.

Regards
Ley Foon

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v4.19-rc2

for you to fetch changes up to c7c09dc187f0323ad40b5b6c57a6db673a386a7f:

  nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol defintions (2018-08-27 09:47:20 +0800)

----------------------------------------------------------------
nios2 fix for v4.19-rc2

nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol defintions

----------------------------------------------------------------
Tobias Klauser (1):
      nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol defintions

 arch/nios2/Kconfig.debug | 9 ---------
 1 file changed, 9 deletions(-)
