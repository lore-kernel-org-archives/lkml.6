Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeCIKpA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:45:00 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:39476 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeCIKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:44:54 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] of: overlay: Small cleanups
Date: Fri,  9 Mar 2018 11:44:45 +0100
Message-Id: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains two forgotten updates for the recent
conversion to FDT overlays, and removes a function that was never used
(not even in out-of-tree overlay ConfigFS ;-).

Geert Uytterhoeven (3):
  of: Documentation: Fix forgotten reference to of_overlay_apply()
  of: overlay: Fix forgotten reference to of_overlay_apply()
  of: overlay: Remove unused of_overlay_remove_all()

 Documentation/devicetree/overlay-notes.txt |  8 ++------
 drivers/of/overlay.c                       | 25 +------------------------
 include/linux/of.h                         |  6 ------
 3 files changed, 3 insertions(+), 36 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
