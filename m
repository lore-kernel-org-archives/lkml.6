Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163389AbeCBASI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:18:08 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34439 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163226AbeCBASG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:18:06 -0500
X-Google-Smtp-Source: AG47ELubjWfd5oElzIcxlCSQUuV8YMH6/xKnfL+RsRhlSpODdzvNZiAAqfQLN3SwZWRFo8NefQwccLCuS1x96hFnsS4=
MIME-Version: 1.0
In-Reply-To: <CAPM=9ty_aSb-GjMjUF3su0mTY_-9a9z7BrQDq9p84ibdJ3ALKQ@mail.gmail.com>
References: <CAPM=9ty_aSb-GjMjUF3su0mTY_-9a9z7BrQDq9p84ibdJ3ALKQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 2 Mar 2018 10:18:04 +1000
Message-ID: <CAPM=9tzeKiLWDzHzoTHryNKzWpXf2Un_FZZ3tpzPzmoUJcevOA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 4.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

just adding missing ccs.

Dave.

On 2 March 2018 at 09:20, Dave Airlie <airlied@gmail.com> wrote:
> Hi Linus,
>
> Pretty much run of the mill drm fixes.
>
> amdgpu -  power management fixes and some display fixes, one ppc 32-bit dma fix.
> i915 - 2 display fixes, 3 gem fixes
> sun4i - display regression fixes
> nouveau - display regression fix
> virtio-gpu - dumb airlied ioctl fix.
>
> Thanks,
> Dave.
>
> The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:
>
>   Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)
>
> are available in the git repository at:
>
>   git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc4
>
> for you to fetch changes up to 93dfdf9fde9f20f1c46738bf184adeebc7d7d66e:
>
>   Merge branch 'drm-fixes-4.16' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-03-01
> 14:03:14 +1000)
>
> ----------------------------------------------------------------
> amdgpu, i915, virtio-gpu, nouveau, sun4i fixes
>
> ----------------------------------------------------------------
> Alex Deucher (3):
>       drm/amd/powerplay/vega10: allow mclk switching with no displays
>       drm/amd/powerplay/smu7: allow mclk switching with no displays
>       Revert "drm/radeon/pm: autoswitch power state when in balanced mode"
>
> Ben Crocker (1):
>       drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE
>
> Chris Wilson (1):
>       drm/i915: Clear the in-use marker on execbuf failure
>
> Daniele Ceraolo Spurio (1):
>       drm/i915: Fix rsvd2 mask when out-fence is returned
>
> Dave Airlie (5):
>       virtio-gpu: fix ioctl and expose the fixed status to userspace.
>       Merge branch 'drm-fixes-4.16' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes
>       Merge tag 'drm-intel-fixes-2018-02-28' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
>       Merge tag 'drm-misc-fixes-2018-02-28' of
> git://people.freedesktop.org/drm-misc into drm-fixes
>       Merge branch 'drm-fixes-4.16' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes
>
> Emily Deng (1):
>       drm/amdgpu: Correct sdma_v4 get_wptr(v2)
>
> Eric Huang (1):
>       drm/amd/powerplay: fix power over limit on Fiji
>
> Hersen Wu (1):
>       drm/amd/display: VGA black screen from s3 when attached to hook
>
> Ilia Mirkin (1):
>       drm/nouveau: prefer XBGR2101010 for addfb ioctl
>
> James Zhu (1):
>       drm/amdgpu:Fixed wrong emit frame size for enc
>
> Jani Nikula (1):
>       drm/i915/audio: fix check for av_enc_map overflow
>
> Mahesh Kumar (1):
>       drm/i915/cnl: Fix PORT_TX_DW5/7 register address
>
> Maxime Ripard (1):
>       drm/sun4i: Protect the TCON pixel clocks
>
> Mikita Lipski (2):
>       drm/amdgpu: Add a missing lock for drm_mm_takedown
>       drm/amdgpu: Unify the dm resume calls into one
>
> Monk Liu (4):
>       drm/amdgpu: only flush hotplug work without DC
>       drm/amdgpu: move WB_FREE to correct place
>       drm/amdgpu: fix&cleanups for wb_clear
>       drm/amdgpu: skip ECC for SRIOV in gmc late_init
>
> Ondrej Jirman (1):
>       drm/sun4i: Enable the output on the pins (tcon0)
>
> Shirish S (1):
>       drm/amd/display: check for ipp before calling cursor operations
>
> Tom St Denis (1):
>       drm/amd/amdgpu: Correct VRAM width for APUs with GMC9
>
> Tvrtko Ursulin (1):
>       drm/i915: Make global seqno known in i915_gem_request_execute tracepoint
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 26 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  6 +++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  7 ++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             | 18 ++++++---------
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +++-
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  6 +++--
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 18 ++++++---------
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 11 +++++----
>  drivers/gpu/drm/drm_framebuffer.c                  |  4 ++++
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c         |  4 +++-
>  drivers/gpu/drm/i915/i915_gem_request.c            |  4 ++--
>  drivers/gpu/drm/i915/i915_reg.h                    |  4 ++--
>  drivers/gpu/drm/i915/intel_audio.c                 |  6 ++---
>  drivers/gpu/drm/nouveau/nv50_display.c             |  1 +
>  drivers/gpu/drm/radeon/radeon_device.c             |  4 ++++
>  drivers/gpu/drm/radeon/radeon_pm.c                 |  6 +----
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  7 ++++--
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c             | 17 +++++++++-----
>  include/drm/drm_drv.h                              |  1 +
>  include/uapi/drm/virtgpu_drm.h                     |  1 +
>  24 files changed, 89 insertions(+), 74 deletions(-)
