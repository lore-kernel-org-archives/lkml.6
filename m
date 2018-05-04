Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeEDAJ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:09:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41667 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeEDAJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:09:26 -0400
X-Google-Smtp-Source: AB8JxZpXJD1R9o7VJ1lvV/QqovyqVhd5P8S4LAMtiNfD5kgp1v2e7oZDGUDYulxIQfUVmPEHerPBSw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Couple more DRM plane features on Tegra
Date: Fri,  4 May 2018 03:08:41 +0300
Message-Id: <20180504000844.18661-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series improves DRM plane support by supporting zPos on older Tegra's
and enabling plane scaling filters (up to Tegra210).

Dmitry Osipenko (3):
  drm/tegra: dc: Enable plane scaling filters
  drm/tegra: plane: Implement zPos plane property for older Tegra's
  drm/tegra: dc: Rename supports_blending to has_legacy_blending

 drivers/gpu/drm/tegra/dc.c    | 205 ++++++++++++++++++++++++++--------
 drivers/gpu/drm/tegra/dc.h    |   9 +-
 drivers/gpu/drm/tegra/plane.c | 193 +++++++++++++++++++++++---------
 drivers/gpu/drm/tegra/plane.h |  13 ++-
 4 files changed, 313 insertions(+), 107 deletions(-)

-- 
2.17.0
