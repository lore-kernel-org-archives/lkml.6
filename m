Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeB1EWf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 23:22:35 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53978 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeB1EWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 23:22:33 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <cover.1519771871.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 0/2] Fixes, cleanup and modernization for macmace driver
Date: Tue, 27 Feb 2018 23:22:32 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 of combined patch series:
- Removed redundant and non-portable MACH_IS_MAC tests.
- Omitted patches unrelated to macmace driver.


Finn Thain (2):
  net/macmace: Drop redundant MACH_IS_MAC test
  net/macmace: Fix and clean up log messages

 drivers/net/ethernet/apple/macmace.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

-- 
2.16.1
