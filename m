Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE847C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60FD2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60FD2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeHPB3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:29:00 -0400
Received: from namei.org ([65.99.196.166]:43372 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbeHPB3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:29:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7FMYoBW020332;
        Wed, 15 Aug 2018 22:34:50 GMT
Date:   Thu, 16 Aug 2018 08:34:50 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security subsystem: Smack updates for v4.19
Message-ID: <alpine.LRH.2.21.1808160831490.19586@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these Smack updates for v4.19, all of which are minor fixes 
from Piotr Sawicki.


The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to df6b4e6608eebc2ff18113706f4e3b9d9a972e68:

  Merge branch 'smack-for-4.19-a' of https://github.com/cschaufler/next-smack into next-smack (2018-07-30 10:31:54 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge branch 'smack-for-4.19-a' of https://github.com/cschaufler/next-smack into next-smack

Piotr Sawicki (3):
      Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets
      Smack: Check UDP-Lite and DCCP protocols during IPv6 handling
      Smack: Inform peer that IPv6 traffic has been blocked

 security/smack/smack_lsm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
James Morris
<jmorris@namei.org>

