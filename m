Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeBIO2E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:28:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:54509 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbeBIO2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:28:03 -0500
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.16 rc1
Date: Fri,  9 Feb 2018 15:28:00 +0100
Message-Id: <20180209142800.25485-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.16-rc1-tag

xen: fixes for 4.16 rc1

This time only 5 small fixes for issues when running under Xen.


Thanks.

Juergen

 arch/x86/xen/p2m.c         |  6 ++++++
 arch/x86/xen/xen-head.S    | 16 ++++++++++++++++
 drivers/net/xen-netfront.c | 46 ++++++++++++++++++++++++----------------------
 drivers/xen/grant-table.c  |  4 ++--
 drivers/xen/pvcalls-back.c |  2 +-
 5 files changed, 49 insertions(+), 25 deletions(-)

Juergen Gross (1):
      x86/xen: init %gs very early to avoid page faults with stack protector

Ross Lagerwall (2):
      xen/grant-table: Use put_page instead of free_page
      xen-netfront: Fix race between device setup and open

Simon Gaiser (1):
      xen: Fix {set,clear}_foreign_p2m_mapping on autotranslating guests

Stefano Stabellini (1):
      pvcalls-back: do not return error on inet_accept EAGAIN
