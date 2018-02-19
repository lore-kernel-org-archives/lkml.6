Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeBSCjV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:39:21 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39590 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeBSCjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:39:18 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <cover.1519007130.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 0/4] Fixes, cleanup and modernization for 8390 ethernet drivers
Date: Sun, 18 Feb 2018 21:39:17 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 of combined patch series:
- Removed redundant and non-portable MACH_IS_MAC tests.
- Added acked-by tags from Geert Uytterhoeven.
- Omitted patches unrelated to 8390 drivers.


Finn Thain (4):
  net/8390: Remove redundant make dependencies
  net/8390: Fix msg_enable patch snafu
  net/mac8390: Convert to nubus_driver
  net/mac8390: Fix log messages

 drivers/net/Space.c                   |   3 -
 drivers/net/ethernet/8390/Makefile    |   6 +-
 drivers/net/ethernet/8390/ax88796.c   |   3 -
 drivers/net/ethernet/8390/axnet_cs.c  |   2 -
 drivers/net/ethernet/8390/etherh.c    |  17 ----
 drivers/net/ethernet/8390/hydra.c     |   4 -
 drivers/net/ethernet/8390/lib8390.c   |   2 +
 drivers/net/ethernet/8390/mac8390.c   | 171 ++++++++++++++++------------------
 drivers/net/ethernet/8390/mcf8390.c   |   4 -
 drivers/net/ethernet/8390/ne.c        |   2 +-
 drivers/net/ethernet/8390/pcnet_cs.c  |   4 -
 drivers/net/ethernet/8390/wd.c        |   2 +-
 drivers/net/ethernet/8390/zorro8390.c |   5 -
 include/net/Space.h                   |   1 -
 14 files changed, 85 insertions(+), 141 deletions(-)

-- 
2.16.1
