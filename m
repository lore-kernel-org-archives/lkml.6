Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDTQc5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:32:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34954 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:32:55 -0400
X-Google-Smtp-Source: AIpwx497S3wwN3DCPypD81v5K4s4Jja1CE3hCq6jvpVyto1A2sIqJMDU11loFv4TNOtehHeq83bxBw==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com
Cc: airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/2] drm/exynos: fimd: Add support for S5PV210
Date: Fri, 20 Apr 2018 18:32:14 +0200
Message-Id: <1524241936-10295-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

Paweł Chmiel (1):
  drm/exynos: Allow DRM_EXYNOS on s5pv210.

Tomasz Figa (1):
  drm/exynos: fimd: Add support for S5PV210 FIMD variant

 drivers/gpu/drm/exynos/Kconfig           | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.7.4
