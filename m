Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeEVSAw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:00:52 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50702 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeEVSAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:00:51 -0400
X-Google-Smtp-Source: AB8JxZr4sLWRwNOxqSj3SuJu5jq6mkE2ZDGixitUXgd3XudXTeC3ixk0gCXYjXjdHaOh5hxhuHy5wzZHzdz1rOyhyVg=
MIME-Version: 1.0
In-Reply-To: <201805222025.KmaxnYzb%fengguang.wu@intel.com>
References: <20180521200113.GA20998@jordon-HP-15-Notebook-PC> <201805222025.KmaxnYzb%fengguang.wu@intel.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 22 May 2018 23:30:49 +0530
Message-ID: <CAFqt6zZa+sedDhPxMmYDK7978K+-QzunrD9TJoefpPt46efssg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: omapdrm: Adding new typedef vm_fault_t
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, tomi.valkeinen@ti.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    drivers/gpu//drm/omapdrm/omap_gem.c: In function 'fault_2d':
>    drivers/gpu//drm/omapdrm/omap_gem.c:480:9: error: implicit declaration of function 'vmf_error'; did you mean '__pmd_error'? [-Werror=implicit-function-declaration]
>       ret = vmf_error(err);

I think, drm-next and next-20180517 tree doesn't have vmf_error() included.
As of now it's only available in 4.17-rc6.

>             ^~~~~~~~~
>             __pmd_error
>>> drivers/gpu//drm/omapdrm/omap_gem.c:503:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      return ret;
>             ^~~
>    cc1: some warnings being treated as errors
>

I will fix this in v2.
