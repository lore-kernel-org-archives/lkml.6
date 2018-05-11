Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeEKK5E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41085 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeEKK5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:57:03 -0400
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fix for 4.17-rc5
Date: Fri, 11 May 2018 12:57:01 +0200
Message-Id: <20180511105701.22827-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.17-rc5-tag

xen: fix for 4.17-rc5

It contains one fix for the kernel running as a fully virtualized
guest using PV drivers on old Xen hypervisor versions.


Thanks.

Juergen

 arch/x86/xen/enlighten_hvm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

Juergen Gross (1):
      Merge tag 'for-linus-4.17-rc5-tag' of gitolite.kernel.org:pub/scm/linux/kernel/git/xen/tip into __for-linus-4.17-rc5-tag

van der Linden, Frank (1):
      x86/xen: Reset VCPU0 info pointer after shared_info remap
