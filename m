Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeDJCo0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:44:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60791 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeDJCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:42:06 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3A2frQA026245, This message is accepted by code: ctloc85258
From: <pkshih@realtek.com>
To: <kvalo@codeaurora.org>
CC: <Larry.Finger@lwfinger.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/9] rtlwifi: btcoex: Add 8822b btcoex support
Date: Tue, 10 Apr 2018 10:41:35 +0800
Message-ID: <20180410024144.5027-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.140]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

v2: fix misspelling and boolean expression in patch 1/9

Patches 1-2 are revised by patches 12 of previous patchset. 8822b coex
files are split into two patches, and I remove some comments and apply
'static const' to version related variables.
Patches 3-4 aren't changed. (identical to patches 13-15 of previous patchset)
Patches 6-7 remove comments and apply 'static const' to existing files.
Patches 8-9 remove global variables, and use local variables instead.

Ping-Ke Shih (9):
  rtlwifi: btcoex: Add 8822b1ant coex files
  rtlwifi: btcoex: Add 8822b2ant coex files
  rtlwifi: btcoex: Add 8822b header files to precomp.h
  rtlwifi: btcoex: Add 8822b routine to btc interfaces
  rtlwifi: btcoex: Add 8822b to Makefile
  rtlwifi: btcoex: remove comments that are not meaningful
  rtlwifi: btcoex: Add modifier const to version related variables
  rtlwifi: btcoex: Add struct members to replace global varaibles
  rtlwifi: btcoex: Remove global variables of chip specific context

 .../wireless/realtek/rtlwifi/btcoexist/Makefile    |    3 +
 .../realtek/rtlwifi/btcoexist/halbt_precomp.h      |    9 +-
 .../realtek/rtlwifi/btcoexist/halbtc8192e2ant.c    |   68 +-
 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.c    |   82 +-
 .../realtek/rtlwifi/btcoexist/halbtc8723b2ant.c    |   82 +-
 .../realtek/rtlwifi/btcoexist/halbtc8821a1ant.c    |   71 +-
 .../realtek/rtlwifi/btcoexist/halbtc8821a2ant.c    |   64 +-
 .../realtek/rtlwifi/btcoexist/halbtc8822b1ant.c    | 5365 +++++++++++++++++++
 .../realtek/rtlwifi/btcoexist/halbtc8822b1ant.h    |  413 ++
 .../realtek/rtlwifi/btcoexist/halbtc8822b2ant.c    | 5429 ++++++++++++++++++++
 .../realtek/rtlwifi/btcoexist/halbtc8822b2ant.h    |  434 ++
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |  100 +
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h       |   24 +
 13 files changed, 12005 insertions(+), 139 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822b1ant.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822b1ant.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822b2ant.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822b2ant.h

-- 
2.15.1
