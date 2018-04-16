Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755350AbeDPMRZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:17:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34208 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755178AbeDPMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:17:24 -0400
X-Google-Smtp-Source: AIpwx48DlRe65Fg0apaBSQA1NVduA96Ku5yREQ/SJG3wTsWoPyDrEpPZm9KeK76Rqa5D2T+gGvYrLQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] More DRM object properties on Tegra
Date: Mon, 16 Apr 2018 15:16:24 +0300
Message-Id: <cover.1523880381.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds new custom plane / CRTC properties that are very useful
for displaying video overlay, they will be used by Opentegra Xorg driver.
Also generic zPos property is implemented for older Tegra's.

Dmitry Osipenko (4):
  drm/tegra: plane: Implement zPos plane property for older Tegra's
  drm/tegra: dc: Rename supports_blending to legacy_blending
  drm/tegra: plane: Add custom colorkey properties for older Tegra's
  drm/tegra: plane: Add custom CSC BLOB property

 drivers/gpu/drm/tegra/dc.c    | 402 +++++++++++++++++++++++++++++-----
 drivers/gpu/drm/tegra/dc.h    |  31 ++-
 drivers/gpu/drm/tegra/plane.c | 268 ++++++++++++++++++-----
 drivers/gpu/drm/tegra/plane.h |  27 ++-
 include/uapi/drm/tegra_drm.h  |  11 +
 5 files changed, 623 insertions(+), 116 deletions(-)

-- 
2.17.0
