Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965962AbeEJOXG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965340AbeEJOXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:23:03 -0400
X-Google-Smtp-Source: AB8JxZqpMJYN5YgvhjPsnKxN9FuWQVMjl/src2qMV9Qv4JWtefFt3twCsJkx0cGXwS/JEZMFqfzmP4dU/U+AUr0q78c=
MIME-Version: 1.0
In-Reply-To: <20180504122842.33643142@jawa>
References: <20180412143715.6828-1-lukma@denx.de> <20180416192442.qnb53b6u3bsfet6y@rob-hp-laptop>
 <20180504122842.33643142@jawa>
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 May 2018 09:22:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLHwOv5+yoJ8S+74TmA2nUxzohhAkksZtrBCK7CAnp46A@mail.gmail.com>
Message-ID: <CAL_JsqLHwOv5+yoJ8S+74TmA2nUxzohhAkksZtrBCK7CAnp46A@mail.gmail.com>
Subject: Re: [PATCH] display: panel: Add KOE tx14d24vm1bpa display support (320x240)
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 5:28 AM, Lukasz Majewski <lukma@denx.de> wrote:
> Hi Rob,
>
>> On Thu, Apr 12, 2018 at 04:37:15PM +0200, Lukasz Majewski wrote:
>> > This commit adds support for KOE's 5.7" display.
>> >
>> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
>> > ---
>> >  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42
>> > ++++++++++++++++++++++
>> > drivers/gpu/drm/panel/panel-simple.c               | 26
>> > ++++++++++++++ 2 files changed, 68 insertions(+) create mode 100644
>> > Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>
> Gentle ping on this - as I don't know if this patch been applied.

This should go thru DRM tree via Thierry.

Rob
