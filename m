Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965021AbeEIPhK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:37:10 -0400
Received: from vern.gendns.com ([206.190.152.46]:46999 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935341AbeEIPhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:37:08 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] clk: davinci: pll-dm355: fix SYSCLKn parent names
Date: Wed,  9 May 2018 10:36:40 -0500
Message-Id: <20180509153642.22399-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 changes:
* swap order of patches

v2 changes:
* add new patch to remove non-existent PLL2 SYSCLK2

David Lechner (2):
  clk: davinci: pll-dm355: drop pll2_sysclk2
  clk: davinci: pll-dm355: fix SYSCLKn parent names

 drivers/clk/davinci/pll-dm355.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.17.0
