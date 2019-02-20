Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE69C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7B92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBTVJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:09:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:59754 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfBTVJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:09:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C92232DC;
        Wed, 20 Feb 2019 21:09:00 +0000 (UTC)
Date:   Wed, 20 Feb 2019 14:08:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] One 5.0 docs fix
Message-ID: <20190220140859.122694ba@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.0-fix

for you to fetch changes up to 0358affb5cd8bbd685a6ab163a36dd28a818da73:

  Documentation: change linux-4.x references to 5.x (2019-02-17 15:41:05 -0700)

----------------------------------------------------------------
A single patch from Arnd bringing some top-level docs into the 5.0 era.

----------------------------------------------------------------
Arnd Bergmann (1):
      Documentation: change linux-4.x references to 5.x

 Documentation/admin-guide/README.rst               |  32 +++---
 Documentation/process/applying-patches.rst         | 117 +++++++++++----------
 .../translations/it_IT/admin-guide/README.rst      |   2 +-
 3 files changed, 78 insertions(+), 73 deletions(-)
