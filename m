Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBAWhL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:37:11 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44371 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeBAWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:37:01 -0500
X-Google-Smtp-Source: AH8x224DCw6Kh+L4278ytkAjFxi0r7SmKm52ysvlb+rzlXqK0tDvhw3LpimzOc7J+oAl7xndJcDxIA==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: devicetree <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 0/5] ARM64: dts: meson-axg: UART DT updates
Organization: BayLibre
References: <20180111023401.125658-1-yixun.lan@amlogic.com>
        <7hr2q6c2r4.fsf@baylibre.com>
        <CAOi56cW4ufsegpy7heK1+pCxvZ2gz5Lf3dkUgxkZCgMq5oBzSA@mail.gmail.com>
        <8990554d-e995-e432-8f50-3b247f71b0fd@amlogic.com>
Date: Thu, 01 Feb 2018 14:36:58 -0800
In-Reply-To: <8990554d-e995-e432-8f50-3b247f71b0fd@amlogic.com> (Yixun Lan's
        message of "Wed, 31 Jan 2018 10:25:45 +0800")
Message-ID: <7hinbg8hh1.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

Yixun Lan <yixun.lan@amlogic.com> writes:

> On 01/31/18 08:22, Kevin Hilman wrote:
>> On Tue, Jan 30, 2018 at 4:04 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>> Yixun Lan <yixun.lan@amlogic.com> writes:
>>>
>>>> HI Kevin
>>>>  These are the UART DT updates for the Meson-AXG platform.
>>>>
>>>>  The patch 1 is a general fix.
>>>> Other patches are about adding clock & pinctrl info, then using them.
>>>> Last patch enable UART_A which connect to a BT module on the S400 board.
>>>
>>> Applied to v4.16/dt64,
>> 
>> Oops, I meant v4.17.
>> 
>
> Hi Kevin
>  I should warn you about the patch 3 [1], it actually depend on the gpio
> renaming patch [2]
>
>  I'm still waiting Linus to take patch [2], then update according
> (or you could help amend the patch? it's simply a
> 's/uart_ao_b_gpioz/uart_ao_b_z/g)

I've made that change in the version of the patch that I applied to the
v4.17/dt64 branch.

It's harmless without the pinctrl patch applied anyways.

Kevin
