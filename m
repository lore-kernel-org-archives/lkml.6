Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932425AbeCIS2c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:28:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:48867 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeCIS2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:28:31 -0500
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fix for V4.16-rc5
Date: Fri,  9 Mar 2018 19:28:28 +0100
Message-Id: <20180309182828.20103-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.16a-rc5-tag

xen: fix for V4.16-rc5

It contains just one fix for the correct error handling after a negative
rc from device_register().


Thanks.

Juergen

 drivers/xen/xenbus/xenbus_probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Arvind Yadav (1):
      xen: xenbus: use put_device() instead of kfree()
