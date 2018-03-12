Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeCLUPS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:15:18 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:20723 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeCLUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:15:16 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Mar 2018 21:15:15 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: narmstrong@baylibre.com, airlied@linux.ie, carlo@caione.org,
        khilman@baylibre.com
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] Fix some error handling paths in 'meson_drv_bind_master()'
Date: Mon, 12 Mar 2018 21:15:07 +0100
Message-Id: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 and 3 are fixes.
Patch 2 is just a kind of clean-up noticed while patching this driver.

If patch 2 is considered as useless, patch 3 can be applied on top of 
patch 1, it does nor depend on the 2nd patch.

Christophe JAILLET (3):
  drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'
  drm/meson: Use drm_dev_put() instead of drm_dev_unref()
  drm/meson: Fix some error handling paths in 'meson_drv_bind_master()'

 drivers/gpu/drm/meson/meson_drv.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
