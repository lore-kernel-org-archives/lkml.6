Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeAaAO0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:14:26 -0500
Received: from ozlabs.org ([103.22.144.67]:51701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeAaAOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:14:25 -0500
Date: Wed, 31 Jan 2018 11:14:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20180131111422.7678db56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Commit

  4824751c76a6 ("virtio: make VIRTIO a menuconfig to ease disabling it all")

is missing a Signed-off-by from its committer.

It also has 2 sets of Reviewed-by/Tested-by tags from Randy Dunlap.

-- 
Cheers,
Stephen Rothwell
