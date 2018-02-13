Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965622AbeBMS4e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:56:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40244 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965525AbeBMSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:55:43 -0500
X-Google-Smtp-Source: AH8x225HXzmnJi47BKptoQXi08DregDmKDy201FCiCW+tNXMnSGyRWCkZh73WltHTIKhal9nghXzkw==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        juri.lelli@redhat.com
Subject: [PATCH 0/2] Update lockdep doc and add section about annotations
Date: Tue, 13 Feb 2018 19:55:17 +0100
Message-Id: <20180213185519.18186-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a couple of patches to lockdep docs.

First one is a small fix for that fact that Peter made documentation
stale (as usual :P).

Second one is an RFC. I thought that adding some info about lockdep
asserts might help spread adoption even wider (mostly regarding
lockdep_pin_lock stuff, which is pretty new and maybe got unnoticed
outside of the scheduler?).

Best,

- Juri 

Juri Lelli (2):
  Documentation/locking/lockdep: update info about states
  Documentation/locking/lockdep: Add section about available annotations

 Documentation/locking/lockdep-design.txt | 51 ++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

-- 
2.14.3
