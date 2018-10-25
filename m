Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03754ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94DB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94DB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJYSLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:11:33 -0400
Received: from namei.org ([65.99.196.166]:49110 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeJYSLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:11:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9P9dZqI031680;
        Thu, 25 Oct 2018 09:39:35 GMT
Date:   Thu, 25 Oct 2018 20:39:35 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security: LoadPin changes for v4.20
Message-ID: <alpine.LRH.2.21.1810252038150.30470@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull.

From Kees: "This is a small reporting improvement and the param change 
needed for the ordering series (but since the loadpin change is desired 
and separable, I'm putting it here)."

---

The following changes since commit 3f6caaf5ff33073ca1a3a0b82edacab3c57c38f9:

  LSM: Don't ignore initialization failures (2018-10-10 20:40:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-loadpin

for you to fetch changes up to 85a585918fb4122ad26b6febaec5c3c90bf2535c:

  Merge tag 'loadpin-security-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-loadpin (2018-10-18 17:20:08 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge tag 'loadpin-security-next' of https://git.kernel.org/.../kees/linux into next-loadpin

Kees Cook (2):
      LoadPin: Report friendly block device name
      LoadPin: Rename boot param "enabled" to "enforce"

 security/loadpin/Kconfig   |  4 ++--
 security/loadpin/loadpin.c | 26 +++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)
