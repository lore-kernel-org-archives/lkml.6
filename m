Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeEaOvm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:51:42 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35687 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbeEaOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:51:39 -0400
X-Google-Smtp-Source: ADUXVKK6Ik/sB3i4DRNHwoMvyGND/WjwPwGnKaLzwB8rfFhIoQUTyM21rpOv2SaMzTJYr21NjkxX5T7gvz4cIjEkgXU=
MIME-Version: 1.0
In-Reply-To: <1527679434-13228-2-git-send-email-lowry.li@arm.com>
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com> <1527679434-13228-2-git-send-email-lowry.li@arm.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 31 May 2018 15:51:37 +0100
Message-ID: <CACvgo52NznSOWNvB_uOT4iQ-8+3A=ohhBe2os+jbEc=8pswn3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/blend: Add per-plane pixel blend mode property
To: Lowry Li <lowry.li@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

Small drive-by suggestion. Haven't checked if others have pointed it
out previously :-\

On 30 May 2018 at 12:23, Lowry Li <lowry.li@arm.com> wrote:

> +/**
> + * drm_plane_create_blend_mode_property - create a new blend mode property
> + * @plane: drm plane
> + * @supported_modes: bitmask of supported modes, must include
> + *                  BIT(DRM_MODE_BLEND_PREMULTI)
> + *
There are two possible blend modes (ignoring 'none'), yet premult must
be supported.
What if the hardware can do only "coverage"?

One-liner explaining why things are as-is would be a great move.

HTH
Emil
