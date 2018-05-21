Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbeEUVpZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:45:25 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36659 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932216AbeEUVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:45:21 -0400
X-Google-Smtp-Source: AB8JxZojvRkqqmpDhhn/xrVqIwCGwIm8fQ8rcl2pVBrwshybfLobVLfDP+qbduY1EV7poeeE39ulTrYe0hNE8T1HBLs=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-10-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-10-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:45:20 +0300
Message-ID: <CAHp75Vd=45Jihm1+vL5iM3QDk+gexdfAk88YhBKSi1-t7XDGtA@mail.gmail.com>
Subject: Re: [PATCH 09/33] phy: tegra: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>

https://patchwork.ozlabs.org/patch/908133/

> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-kernel@vger.kernel.org


-- 
With Best Regards,
Andy Shevchenko
