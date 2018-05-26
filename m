Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeEZNcU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 09:32:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54612 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeEZNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 09:32:19 -0400
X-Google-Smtp-Source: ADUXVKJ6Gf06+rCFXUebBF6tW1R1zSbSI6tFpzSU+tah6QDhDjV4tKYd5WMh+LO5b0ORGEMaHXPM6nmOn5I9dOe8hvc=
MIME-Version: 1.0
In-Reply-To: <201805260922.mIQUhVUm%fengguang.wu@intel.com>
References: <20180523144615.GA24563@jordon-HP-15-Notebook-PC> <201805260922.mIQUhVUm%fengguang.wu@intel.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 26 May 2018 19:02:17 +0530
Message-ID: <CAFqt6zY=_EvZcTW4KSL+w+ZMPK6dK+4fetV-oSnM98AxmtT7AA@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: gma500: Change return type to vm_fault_t
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 8:11 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Souptick,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on drm/drm-next]
> [also build test WARNING on v4.17-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Souptick-Joarder/gpu-drm-gma500-Change-return-type-to-vm_fault_t/20180526-084629
> base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> config: x86_64-randconfig-x013-201820 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>
> All warnings (new ones prefixed by >>):
>
>    drivers/gpu//drm/gma500/framebuffer.c: In function 'psbfb_vm_fault':
>>> drivers/gpu//drm/gma500/framebuffer.c:143:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      return ret;
>             ^~~

Sorrry about it. Will fix and send v3.
