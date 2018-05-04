Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeEDJeV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:34:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:40529 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbeEDJeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:34:20 -0400
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: one cleanup for 4.17-rc4
Date: Fri,  4 May 2018 11:34:17 +0200
Message-Id: <20180504093417.9425-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.17-rc4-tag

xen: one cleanup for 4.17-rc4

It contains one cleanup to remove VLAs from the kernel.


Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c | 86 ++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 55 deletions(-)

Laura Abbott (1):
      x86/xen: Remove use of VLAs
