Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeEUWGK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:06:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43816 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeEUWGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:06:05 -0400
X-Google-Smtp-Source: AB8JxZps5YeAT7Hy92jwxjHAU9lFyWcfYFwYxvezqy+Ba1PDYnHCrXfi4bgEN8ojtQKWJ/KaJ5dPvJlxQxnxOLHSNb0=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-25-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-25-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:06:04 +0300
Message-ID: <CAHp75Vc-Qe-Ft0etW49CtaOFfUHV3hij5E__HiX8a1zM4u6PHQ@mail.gmail.com>
Subject: Re: [PATCH 24/33] drm: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

https://patchwork.kernel.org/patch/10382377/

> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org

-- 
With Best Regards,
Andy Shevchenko
