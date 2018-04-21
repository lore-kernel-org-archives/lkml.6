Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeDUR0d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:26:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43701 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeDUR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:26:31 -0400
X-Google-Smtp-Source: AB8JxZr4kcLf90B/DOdFJzQO5iuF0ILy1wieGUS5rFrwESXAXY0ksmUlbLBMaeDVVVCA65Xy9B+zxw==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com
Cc: airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/2] drm/exynos: fimd: Add support for S5PV210
Date: Sat, 21 Apr 2018 19:26:09 +0200
Message-Id: <1524331571-7420-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series compose of 2 patches.

First patch, adding support for S5PV210 FIMD variant to Exynos driver.
Compatible for this soc was already existing in documentation.

Second patch, brings back possibility to use drivers depending on
DRM_EXYNOS, on Samsung S5PV210/S5PC110 series based systems.

Both patches has been tested on (not yet mainlined), an S5PV210 based
Samsung Galaxy S (i9000) phone.

Changes from v1:
  - Added missing signed-off-by to one of patches

Paweł Chmiel (1):
  drm/exynos: Allow DRM_EXYNOS on s5pv210.

Tomasz Figa (1):
  drm/exynos: fimd: Add support for S5PV210 FIMD variant

 drivers/gpu/drm/exynos/Kconfig           | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.7.4
