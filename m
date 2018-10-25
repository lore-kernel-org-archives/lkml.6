Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5532064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5532064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJYSJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:09:39 -0400
Received: from namei.org ([65.99.196.166]:49102 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeJYSJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:09:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9P9bf5a031528;
        Thu, 25 Oct 2018 09:37:41 GMT
Date:   Thu, 25 Oct 2018 20:37:41 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security: Smack updates for v4.20
Message-ID: <alpine.LRH.2.21.1810252035220.30470@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull.

From Casey: "Here are three patches for Smack for 4.20. Two clean up 
warnings and one is a rarely encountered ptrace capability check."

---

The following changes since commit 0d42d73a37ff91028785e42a6bf12fc020a277c1:

  seccomp: remove unnecessary unlikely() (2018-09-06 13:29:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to f0f9756b7260f4e78a2e4e412a55167178721ca2:

  Merge branch 'smack-for-4.20' of https://github.com/cschaufler/next-smack into next-smack (2018-09-25 11:15:12 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: ptrace capability use fixes

Gustavo A. R. Silva (1):
      Smack: Mark expected switch fall-through

James Morris (1):
      Merge branch 'smack-for-4.20' of https://github.com/cschaufler/next-smack into next-smack

YueHaibing (1):
      Smack: remove set but not used variable 'root_inode'

 security/smack/smack_lsm.c | 15 +++++++++++----
 security/smack/smackfs.c   |  3 ---
 2 files changed, 11 insertions(+), 7 deletions(-)
