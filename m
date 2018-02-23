Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeBWC1v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:27:51 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35016 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBWC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:27:49 -0500
X-Google-Smtp-Source: AG47ELsfN7c8Nl0MG66bB42or3ut2X7qXTR2dG1clYDbnNMYyFYC4BrGcWRZ08d4Lw/Sv209Ob6JJg==
MIME-Version: 1.0
In-Reply-To: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 22 Feb 2018 18:27:46 -0800
X-Gmail-Original-Message-ID: <CAAfnVBkFw9o-FOdT6OXq0qbPHmLRcKUfu3K-7mJ-XNq-kdP5Qw@mail.gmail.com>
Message-ID: <CAAfnVBkFw9o-FOdT6OXq0qbPHmLRcKUfu3K-7mJ-XNq-kdP5Qw@mail.gmail.com>
Subject: Re: [PATCH 0/7] drm/virtio: Checkpatch cleanup for virtio
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1 to 7 are:

Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>

On Thu, Feb 22, 2018 at 3:59 PM, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
> This patchset fixes warnings and errors found by checkpatch.pl in the
> drm/virtio:
>
> * Removes return from void function;
> * Adds */ in block comments to separate line;
> * Adds blank line after variable declarations;
> * Adds tabs at the start of a line;
> * Replaces 'unsigned' for 'unsigned int';
> * Removes multiple blank lines;
> * Adds spaces around operators.
>
> Rodrigo Siqueira (7):
>   drm/virtio: Add tabs at the start of a line
>   drm/virtio: Add blank line after variable declarations
>   drm/virtio: Add */ in block comments to separate line
>   drm/virtio: Remove return from void function
>   drm/virtio: Replace 'unsigned' for 'unsigned int'
>   drm/virtio: Remove multiple blank lines
>   drm/virtio: Add spaces around operators
>
>  drivers/gpu/drm/virtio/virtgpu_display.c |  7 ++++---
>  drivers/gpu/drm/virtio/virtgpu_drv.c     |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  8 ++++----
>  drivers/gpu/drm/virtio/virtgpu_fb.c      |  6 +++++-
>  drivers/gpu/drm/virtio/virtgpu_gem.c     |  1 +
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 23 +++++++++++++----------
>  drivers/gpu/drm/virtio/virtgpu_prime.c   |  4 ++--
>  drivers/gpu/drm/virtio/virtgpu_ttm.c     |  4 +---
>  drivers/gpu/drm/virtio/virtgpu_vq.c      | 13 ++++++++-----
>  9 files changed, 39 insertions(+), 29 deletions(-)
>
> --
> 2.16.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
