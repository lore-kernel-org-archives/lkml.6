Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDPQAE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:00:04 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44553 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDPQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:00:01 -0400
X-Google-Smtp-Source: AIpwx49vs1krIxV5VnqdGAvAvU0BCXufEdVvuj5pfkx4GznjuqIp8d3mGhac7E7JPbCE/xaASKVVCw==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: tomasz.figa@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com
Cc: linus.walleij@linaro.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/2] pinctrl/samsung: Fix incorrect EINTG banks order
Date: Mon, 16 Apr 2018 17:52:44 +0200
Message-Id: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series compose of 2 patches.

First patch, fixing incorrect order of banks for s5pv210 and exynos5410

Second patch, documenting required order of banks

Changes from v1:
  - Limit changes to s5pv210 and Exynos5410. Exynos3250 will be handled later.
  - Added cc stable
  - Added fixes tag
  - Add patch with comments to all banks documenting required order.

Paweł Chmiel (2):
  pinctrl/samsung: Correct EINTG banks order
  pinctrl/samsung: Document required order of banks

 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 30 ++++++++++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 +++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.7.4
