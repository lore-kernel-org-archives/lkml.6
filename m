Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5983C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B862087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfADWCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:02:40 -0500
Received: from ms.lwn.net ([45.79.88.28]:36644 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfADWCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:02:40 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E00DB8AF;
        Fri,  4 Jan 2019 22:02:39 +0000 (UTC)
Date:   Fri, 4 Jan 2019 15:02:39 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes
Message-ID: <20190104150239.174f0f8a@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
942104a21ce4951420ddf6c6b3179a0627301f7e:

  docs: improve pathname-lookup document structure (2018-12-20 08:47:18 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.0-fixes

for you to fetch changes up to 93fb7f19985a08bbe3b76da0b35e97b6e472e4a5:

  doc: filesystems: fix bad references to nonexistent ext4.rst file (2019-01-03 09:28:45 -0700)

----------------------------------------------------------------
A handful of late-arriving documentation fixes.

----------------------------------------------------------------
Marcos Paulo de Souza (1):
      Docs/kernel-api.rst: Remove blk-tag.c reference

Otto Sabart (1):
      doc: filesystems: fix bad references to nonexistent ext4.rst file

Ramunas Geciauskas (1):
      Documentation/admin-guide: update URL of LKML information link

 Documentation/admin-guide/reporting-bugs.rst | 2 +-
 Documentation/core-api/kernel-api.rst        | 6 ------
 Documentation/filesystems/dax.txt            | 2 +-
 Documentation/filesystems/ext2.txt           | 2 +-
 MAINTAINERS                                  | 2 +-
 5 files changed, 4 insertions(+), 10 deletions(-)
