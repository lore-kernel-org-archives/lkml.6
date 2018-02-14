Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031090AbeBNOuD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:50:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56112 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031020AbeBNOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:55 -0500
X-Google-Smtp-Source: AH8x2263p74bIIMDXbsJVLkLgbqJZt8y9pvqb9BEoHDJhkVeRN04mCPscwJC+weeB6IOBx7Fxtj2rA==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 12/13] drm/amd/include: remove unused displayobject.h header
Date: Wed, 14 Feb 2018 14:46:16 +0000
Message-Id: <1518619577-19771-13-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

displayobject.h is not used by any source files.
Lets just remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/amd/include/displayobject.h | 249 ----------------------------
 1 file changed, 249 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/displayobject.h

diff --git a/drivers/gpu/drm/amd/include/displayobject.h b/drivers/gpu/drm/amd/include/displayobject.h
deleted file mode 100644
index 67e23ff9cbd4..000000000000
-- 
2.13.6
