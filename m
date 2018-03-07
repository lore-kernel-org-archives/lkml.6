Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeCGIwB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:52:01 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39888 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:51:59 -0500
X-Google-Smtp-Source: AG47ELvvIc5JqPjKHiubOCCFSkIaVl31vmZz2oDHGCPOvhTFUCt9wp0LcYbA3ttP06BjV9zGkFoqizymwPlIHp5ZaEo=
MIME-Version: 1.0
In-Reply-To: <1520260563-4167-1-git-send-email-musashino.open@gmail.com>
References: <1520260563-4167-1-git-send-email-musashino.open@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Wed, 7 Mar 2018 09:51:58 +0100
Message-ID: <CACna6rwKt1wdryaSs1DsGztSjugBbfRfQqpzGKjvqWf=j=N5kw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: add missing LEDs for Buffalo WZR-900DHP
To: musashino.open@gmail.com
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 15:36,  <musashino.open@gmail.com> wrote:
> From: INAGAKI Hiroshi <musashino.open@gmail.com>
>
> Buffalo WZR-900DHP has 8 LEDs, but there is not LED definitions in the
> dts and cannot configure these LEDs.
> I Added missing LED definitions for WZR-900DHP.
>
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>

Looks almost good, thanks for sending this patch to Florian.

One comment: please drop all linux,default-trigger = "default-off";
lines. I did the same mistake long time ago, see my fixing commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b660259e927177dc0c6eb3b1c39f23c6a011c5f

When you fix that, please generate a V2 of your patch, you can do it
with something like:
git format-patch --subject-prefix="PATCH V2" -1
and send again the same way.

Thanks!
