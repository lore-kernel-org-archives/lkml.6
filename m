Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934733AbeCHCCc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:02:32 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34900 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:02:30 -0500
X-Google-Smtp-Source: AG47ELs4KkWfNwFQkPWoIY5GQGnVlzerqSOcIesNCuxznehmlVNYKuF0PmAoju3QONaHZjrqTjosDg==
Date: Wed, 7 Mar 2018 23:02:27 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/vgem: Checkpatch cleanup for vgem
Message-ID: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes warnings and errors found by checkpatch.pl in the
drm/vgem:

* Removes assignment in if condition;
* Removes '(' from the end of line;
* Adds spaces around operators;
* Replaces uint32_t for u32;
* Indents switch and case at the same level.

Rodrigo Siqueira (5):
  drm/vgem: Indent switch and case at the same level
  drm/vgem: Remove assignment in if condition
  drm/vgem: Replace uint32_t for u32
  drm/vgem: Add space around operators
  drm/vgem: Remove '(' from the end of line

 drivers/gpu/drm/vgem/vgem_drv.c   | 21 +++++++++++++--------
 drivers/gpu/drm/vgem/vgem_fence.c | 11 +++++++----
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.16.2
