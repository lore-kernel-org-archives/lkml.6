Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeBVX7j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:59:39 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41086 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeBVX7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:59:37 -0500
X-Google-Smtp-Source: AH8x226LcRLhx8DQiHUxPsRwmARnTrctJ6Kgud8bG6YrNtjxhzioqbH59zKIU3iznxR6bTpYVFOQiQ==
Date: Thu, 22 Feb 2018 20:59:33 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 0/7] drm/virtio: Checkpatch cleanup for virtio
Message-ID: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes warnings and errors found by checkpatch.pl in the
drm/virtio:

* Removes return from void function;
* Adds */ in block comments to separate line;
* Adds blank line after variable declarations;
* Adds tabs at the start of a line;
* Replaces 'unsigned' for 'unsigned int';
* Removes multiple blank lines;
* Adds spaces around operators.

Rodrigo Siqueira (7):
  drm/virtio: Add tabs at the start of a line
  drm/virtio: Add blank line after variable declarations
  drm/virtio: Add */ in block comments to separate line
  drm/virtio: Remove return from void function
  drm/virtio: Replace 'unsigned' for 'unsigned int'
  drm/virtio: Remove multiple blank lines
  drm/virtio: Add spaces around operators

 drivers/gpu/drm/virtio/virtgpu_display.c |  7 ++++---
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_fb.c      |  6 +++++-
 drivers/gpu/drm/virtio/virtgpu_gem.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 23 +++++++++++++----------
 drivers/gpu/drm/virtio/virtgpu_prime.c   |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_ttm.c     |  4 +---
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 13 ++++++++-----
 9 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.16.2
