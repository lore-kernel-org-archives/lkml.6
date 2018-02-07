Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeBGCE1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 21:04:27 -0500
Received: from ozlabs.org ([103.22.144.67]:56461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbeBGCEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 21:04:25 -0500
Date: Wed, 7 Feb 2018 13:04:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Wang <wei.w.wang@intel.com>, Liang Li <liang.z.li@intel.com>
Subject: linux-next: build failure after merge of the vhost tree
Message-ID: <20180207130423.4f9c1ad0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

After merging the vhost tree, today's linux-next build (x86_64
allmodconfig) failed like this:


Caused by commit

  96bcd04462b9 ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")

I have used the vhost tree from next-20180206 for today.

-- 
Cheers,
Stephen Rothwell
