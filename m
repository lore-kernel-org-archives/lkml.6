Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427339AbeCBRZW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:25:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53573 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424699AbeCBRZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:25:21 -0500
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for v4.16-rc4
Date: Fri,  2 Mar 2018 18:25:18 +0100
Message-Id: <20180302172518.16501-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.16a-rc4-tag

xen: fixes for v4.16-rc4

It contains 5 minor fixes for Xen-specific drivers.


Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c      |  6 ++++--
 drivers/net/xen-netfront.c       |  7 ++++++-
 drivers/xen/events/events_base.c |  4 ++--
 drivers/xen/pvcalls-back.c       |  2 +-
 drivers/xen/pvcalls-front.c      | 11 ++++++++---
 5 files changed, 21 insertions(+), 9 deletions(-)

Colin Ian King (1):
      xen/pvcalls: fix null pointer dereference on map->sock

Jason Andryuk (1):
      xen-netfront: Fix hang on device removal

Juergen Gross (2):
      x86/xen: add tty0 and hvc0 as preferred consoles for dom0

Roger Pau Monne (1):
      xen/pirq: fix error path cleanup when binding MSIs

Stefano Stabellini (1):
      pvcalls-front: 64-bit align flags
