Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbeDPM5C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:57:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33750 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeDPM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:57:00 -0400
X-Google-Smtp-Source: AIpwx49QniVk3OYCv0bU1n31WS/uLSSbm6M0elm7AmrssX0OJOggciGqj8sImBkh6K9YPftPP99DhA==
From: Lee Jones <lee.jones@linaro.org>
To: linus.walleij@linaro.org, ldewangan@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 0/3] mfd: Provide MACRO to declare commonly defined MFD cell attributes
Date: Mon, 16 Apr 2018 13:56:24 +0100
Message-Id: <20180416125627.22156-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not a lot to it really.  The idea is to save lines.

Lee Jones (3):
  mfd: Provide MACRO to declare commonly defined MFD cell attributes
  mfd: ab8500: Example using new OF_MFD_CELL MACRO
  mfd: db8500-prcmu: Example using new OF_MFD_CELL/MFD_CELL_BASIC MACROs

 drivers/mfd/ab8500-core.c  | 138 ++++++++++++++-------------------------------
 drivers/mfd/db8500-prcmu.c |  24 +++-----
 include/linux/mfd/core.h   |  29 ++++++++++
 3 files changed, 78 insertions(+), 113 deletions(-)

-- 
2.14.1
