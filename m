Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754986AbeCRWsX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:48:23 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:47159 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754630AbeCRWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:48:20 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Mar 2018 23:48:17 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: maxime.ripard@free-electrons.com, airlied@linux.ie, wens@csie.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] drm/sun4i: Fix some error handling paths in 'sun4i_hdmi_bind()'
Date: Sun, 18 Mar 2018 23:48:08 +0100
Message-Id: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've splitted these fixes into 2 patches becasue they do not fixe the same
commit.

Christophe JAILLET (2):
  drm/sun4i: hdmi: Fix an error handling path in 'sun4i_hdmi_bind()'
  drm/sun4i: hdmi: Fix another error handling path in
    'sun4i_hdmi_bind()'

 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.14.1
