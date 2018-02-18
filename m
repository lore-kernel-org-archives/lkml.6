Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeBRSHu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 13:07:50 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35009 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeBRSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 13:07:49 -0500
X-Google-Smtp-Source: AH8x225bOO8D4Y6FQYHrvXOGLygprZM1CqGu7iWwNEA/BL2mrl+WtX4cY90hSEVzL1MJSWHKcHKnQQ==
Date: Sun, 18 Feb 2018 20:07:45 +0200
From: Mykola Golub <to.my.trociny@gmail.com>
To: Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@kernel.dk>
Cc: Jason Dillaman <jdillama@redhat.com>, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: nbd: on-the-fly resize does not work any more
Message-ID: <20180218180744.GC28602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like after the recent changes to nbd driver, on-the-fly
resize has stopped working for rbd-nbd. Particularly this change [1]
breaks how NBD_SET_SIZE is used for rbd-nbd on-the-fly resize [2].

Could this be fixed?

[1] https://github.com/torvalds/linux/commit/639812a1ed9bf49ae2c026086fbf975339cd1eef
[2] https://github.com/ceph/ceph/blob/483f14c/src/tools/rbd_nbd/rbd-nbd.cc#L488

-- 
Mykola Golub
