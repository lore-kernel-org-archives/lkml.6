Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeEUWFB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:05:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33290 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeEUWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:04:53 -0400
X-Google-Smtp-Source: AB8JxZoFENaG0TKpl6EueN5VfddeU7dtTKXduXiPqzFreqWCrX208RBCXclLl1wIHrCWsdyro8ndo5lZ0SQwkTO77qk=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-23-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-23-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:04:52 +0300
Message-ID: <CAHp75Ve0zmHZqESKgB1U9XEhztHPzAWcw9O-8K4JUAamdmYd3A@mail.gmail.com>
Subject: Re: [PATCH 22/33] drm/i915: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

https://patchwork.kernel.org/patch/10382323/

> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org

-- 
With Best Regards,
Andy Shevchenko
