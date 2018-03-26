Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCZIuU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:50:20 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37527 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZIuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:50:19 -0400
X-Google-Smtp-Source: AG47ELt9VaOFXNZCoF9aF2SkqXDXngaJSHPnHmKqcIEXt6YeawKNiUVMksYK7fG+dZprRwiYEfHDtn1rSt850mY2WBY=
MIME-Version: 1.0
In-Reply-To: <20180323142234.GH5799@atomide.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
 <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com> <20180323142234.GH5799@atomide.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:50:17 +0200
Message-ID: <CACRpkdYpv2EZj6a0_KJN+BdSRT=HRCnh8PGDTqQkKpgX1mEm0g@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
To: Tony Lindgren <tony@atomide.com>
Cc: David Lechner <david@lechnology.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 3:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [180323 03:02]:
>> On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:
>>
>> > This fixes pcs_request_gpio() in the pinctrl-single driver when
>> > bits_per_mux != 0. It appears this was overlooked when the multiple
>> > pins per register feature was added.
>> >
>> > Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
>> > Signed-off-by: David Lechner <david@lechnology.com>
>> > ---
>> >
>> > v2 changes:
>> > - don't wrap Fixes: line in commit message since it is a special machine-
>> >   readable line.
>>
>> Tony/Haojian: are you OK with this change?
>
> No objections from me, would be good if Haojian could
> test it with his test cases though.

I applied it for v4.17 recording this as an ACK :)

If there are problems I bet we will notice in the -rc phase.

Yours,
Linus Walleij
