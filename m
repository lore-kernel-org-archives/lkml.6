Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163117AbeCAX3e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:29:34 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52458 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162904AbeCAX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:29:29 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <cover.1519813462.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 0/4] Fixes, cleanup and modernization for mac89x0 driver
Date: Thu,  1 Mar 2018 18:29:28 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 of combined patch series:
- Removed redundant and non-portable MACH_IS_MAC tests.
- Added acked-by tags from Geert Uytterhoeven.
- Omitted patches unrelated to mac89x0 driver.


Finn Thain (4):
  net/mac89x0: Remove redundant code
  net/mac89x0: Convert to platform_driver
  net/mac89x0: Fix and modernize log messages
  net/mac89x0: Replace custom debug logging with netif_* calls

 arch/m68k/mac/config.c                |   4 +
 drivers/net/Space.c                   |   3 -
 drivers/net/ethernet/cirrus/mac89x0.c | 158 +++++++++++-----------------------
 include/net/Space.h                   |   1 -
 4 files changed, 53 insertions(+), 113 deletions(-)

-- 
2.16.1
