Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEDOlC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:41:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41502 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:40:59 -0400
X-Google-Smtp-Source: AB8JxZoi+WT749xKNgLxU0IkvhZJo6XZyBGuNDhub2ic51Nm0doqjzXZqj22gIhbRkkFcBg2mVtmHg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Couple more DRM plane features for Tegra
Date: Fri,  4 May 2018 17:39:57 +0300
Message-Id: <20180504144000.8597-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series improves DRM plane support by supporting zPos on older Tegra's
and enabling plane scaling filters (up to Tegra210).

Changelog:

v2:
	- Addressed v1 review comments.

Dmitry Osipenko (3):
  drm/tegra: dc: Enable plane scaling filters
  drm/tegra: plane: Implement zPos plane property for older Tegra's
  drm/tegra: dc: Rename supports_blending to has_legacy_blending

 drivers/gpu/drm/tegra/dc.c    | 235 +++++++++++++++++++++++++++-------
 drivers/gpu/drm/tegra/dc.h    |   9 +-
 drivers/gpu/drm/tegra/plane.c | 193 ++++++++++++++++++++--------
 drivers/gpu/drm/tegra/plane.h |  13 +-
 4 files changed, 343 insertions(+), 107 deletions(-)

-- 
2.17.0
