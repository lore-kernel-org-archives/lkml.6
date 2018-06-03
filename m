Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeFCLsW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 07:48:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37833 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 07:48:21 -0400
X-Google-Smtp-Source: ADUXVKLGQaKQZxplmwBpyD2OT+zSMc+jOpQ5jsum+8JJaNymuS0VoNESrk8gATN1u0ymBQSzrUa9Tw==
From: Varsha Rao <rvarsha016@gmail.com>
To: Rasesh Mody <rasesh.mody@cavium.com>,
        Harish Patil <harish.patil@cavium.com>, Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH 0/2] net: bnx2: Fix checkpatch and clang warnings
Date: Sun,  3 Jun 2018 17:18:04 +0530
Message-Id: <cover.1528025568.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes NULL comparison and extra parentheses, checkpatch
and clang warnings.

Varsha Rao (2):
  net: ethernet: bnx2: Remove extra parentheses
  net: ethernet: bnx2: Replace NULL comparison

 drivers/net/ethernet/broadcom/bnx2.c | 44 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

-- 
2.17.0
