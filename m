Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbeBXX12 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:27:28 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58360 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeBXX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:27:25 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <cover.1519514463.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 0/4] Fixes, cleanup and modernization for SONIC ethernet drivers
Date: Sat, 24 Feb 2018 18:27:24 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 of combined patch series:
- Removed redundant and non-portable MACH_IS_MAC tests.
- Omitted patches unrelated to SONIC drivers.
- Dropped changes to the 'version_printed' logic and debug message text.


Finn Thain (4):
  net/macsonic: Convert to nubus_driver
  net/macsonic: Drop redundant MACH_IS_MAC test
  net/sonic: Clean up and modernize log messages
  net/sonic: Replace custom debug logging with netif_* calls

 drivers/net/ethernet/natsemi/jazzsonic.c |  32 +---
 drivers/net/ethernet/natsemi/macsonic.c  | 244 ++++++++++++++++++-------------
 drivers/net/ethernet/natsemi/sonic.c     |  99 +++++++------
 drivers/net/ethernet/natsemi/sonic.h     |   2 +
 drivers/net/ethernet/natsemi/xtsonic.c   |  30 +---
 5 files changed, 210 insertions(+), 197 deletions(-)

-- 
2.16.1
