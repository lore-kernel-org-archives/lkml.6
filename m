Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeEUWCC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:02:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44758 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeEUWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:01:59 -0400
X-Google-Smtp-Source: AB8JxZoN307oEWmSGUm2M/SJZKjSV4miXP+sUXvDTMlkOWaFtWf0Df7jRN9r9qq6yMoE35imM4fWGcD8mkU7oJNj8XI=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-21-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-21-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:01:57 +0300
Message-ID: <CAHp75Vef0G32an=sOk24W8=mGzn9hjuJvw54vaAVgKKTOYO_qw@mail.gmail.com>
Subject: Re: [PATCH 20/33] video: fbdev: pxafb: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

https://patchwork.kernel.org/patch/10378815/

> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> linux-fbdev@vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko
