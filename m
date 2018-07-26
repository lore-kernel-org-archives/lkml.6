Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F35BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D37E2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D37E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeGZPgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:36:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGZPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:36:12 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A30E8A95;
        Thu, 26 Jul 2018 14:19:06 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:19:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core fix for 4.18-rc7
Message-ID: <20180726141901.GA14000@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.18-rc7

for you to fetch changes up to 722e5f2b1eec7de61117b7c0a7914761e3da2eda:

  driver core: Partially revert "driver core: correct device's shutdown order" (2018-07-10 17:47:43 +0200)

----------------------------------------------------------------
Driver core fixes for 4.18-rc7

This is a single driver core fix for 4.18-rc7.  It partially reverts a
previous commit to resolve some reported issues.

It has been in linux-next for a while now with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Rafael J. Wysocki (1):
      driver core: Partially revert "driver core: correct device's shutdown order"

 drivers/base/dd.c | 8 --------
 1 file changed, 8 deletions(-)
