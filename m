Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XVX1ISJxGVshbAAAmS7hNA
	; Thu, 07 Jun 2018 17:54:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9563A6074D; Thu,  7 Jun 2018 17:54:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6573F601C3;
	Thu,  7 Jun 2018 17:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6573F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935168AbeFGRx6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:53:58 -0400
Received: from namei.org ([65.99.196.166]:58486 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933639AbeFGRx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w57Hru1x031734;
        Thu, 7 Jun 2018 17:53:56 GMT
Date: Fri, 8 Jun 2018 03:53:56 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Security subsystem: Smack updates for v4.18
Message-ID: <alpine.LRH.2.21.1806080351390.27121@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull this bugfix for the Smack subsystem.

>From Casey: "It's one simple patch that fixes a memory leak in kernfs and 
labeled NFS."

---

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to 2531a0cd2dd9dc2b0da9fabb950e2db308ce78b8:

  Merge branch 'smack-for-4.18' of https://github.com/cschaufler/next-smack into next-smack (2018-06-05 13:18:58 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Fix memory leak in smack_inode_getsecctx

James Morris (1):
      Merge branch 'smack-for-4.18' of https://github.com/cschaufler/next-smack into next-smack

 security/smack/smack_lsm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
