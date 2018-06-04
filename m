Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbeFDOQo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:16:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753634AbeFDOQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:16:41 -0400
From: Miroslav Benes <mbenes@suse.cz>
To: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org
Cc: pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/2] Periodic fake signal
Date: Mon,  4 Jun 2018 16:16:34 +0200
Message-Id: <20180604141636.11523-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is what we have in SLES and I wondered if upstream would be
interested as well.

Miroslav Benes (2):
  livepatch: Send a fake signal periodically
  livepatch: Remove signal sysfs attribute

 .../ABI/testing/sysfs-kernel-livepatch        | 12 ---
 Documentation/livepatch/livepatch.txt         | 15 ++--
 kernel/livepatch/core.c                       | 32 -------
 kernel/livepatch/transition.c                 | 89 ++++++++++---------
 kernel/livepatch/transition.h                 |  1 -
 5 files changed, 55 insertions(+), 94 deletions(-)

-- 
2.17.0
