Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A3AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80AE2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80AE2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbeGKLAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:00:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:00:50 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9AE8D91;
        Wed, 11 Jul 2018 10:57:04 +0000 (UTC)
Date:   Wed, 11 Jul 2018 12:57:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging driver fixes for 4.18-rc5
Message-ID: <20180711105702.GA18092@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.18-rc5

for you to fetch changes up to d59d2f9995d28974877750f429e821324bd603c7:

  staging: r8822be: Fix RTL8822be can't find any wireless AP (2018-07-06 17:44:35 +0200)

----------------------------------------------------------------
Staging fixes for 4.18-rc5

Here are two tiny staging driver fixes for reported issues for 4.18-rc5.

One fixes the r8822be driver to properly work on lots of new laptops,
the other is for the rtl8723bs driver to fix an underflow error.

Both have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Murray McAllister (1):
      staging: rtl8723bs: Prevent an underflow in rtw_check_beacon_data().

Ping-Ke Shih (1):
      staging: r8822be: Fix RTL8822be can't find any wireless AP

 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 drivers/staging/rtlwifi/rtl8822be/hw.c  | 2 +-
 drivers/staging/rtlwifi/wifi.h          | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
