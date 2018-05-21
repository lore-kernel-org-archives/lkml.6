Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeEUVq1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:46:27 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39078 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeEUVqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:46:22 -0400
X-Google-Smtp-Source: AB8JxZrAFM/skBKUlR9VTfO07S63Xp35kR9NsPN4sB39xAqyxki5jHFxo1+hCWW25P2CG3Z7eHViU8K6n9PxfltE3jY=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-11-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-11-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:46:21 +0300
Message-ID: <CAHp75Vd7KbdFw_Y+h7T15K+GgDdEj0JJT7EhCMO56r5rhaQdfA@mail.gmail.com>
Subject: Re: [PATCH 10/33] pata_hpt37x: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>

https://www.spinics.net/lists/linux-ide/msg55658.html

> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org


-- 
With Best Regards,
Andy Shevchenko
