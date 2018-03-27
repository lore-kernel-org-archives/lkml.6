Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeC0M1C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:27:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46153 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeC0M1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:27:00 -0400
X-Google-Smtp-Source: AG47ELsBUZOfDE9bPvpvc2impvsTTQQASRhB/YGZ2MC92naVN5wzSvPFv7Sga02eJQBUyklaRSW7wH3u+VNfDd+5+Ww=
MIME-Version: 1.0
In-Reply-To: <CACRpkdaQtPOJCcXoVB0UufLDNhkkh4__XTT2sapAKWDu9jw73g@mail.gmail.com>
References: <cover.1518166039.git.viresh.kumar@linaro.org> <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
 <CACRpkdaQtPOJCcXoVB0UufLDNhkkh4__XTT2sapAKWDu9jw73g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 14:26:58 +0200
X-Google-Sender-Auth: ML39GmkqlIJjen3aKnyQ4BmnWRU
Message-ID: <CAK8P3a3taUgJW=xBZmttH1upv+J_Pj+0XKOCjUbPuzfGTmk13g@mail.gmail.com>
Subject: Re: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 4:10 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Feb 9, 2018 at 9:58 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> The "cooling-min-level" and "cooling-max-level" properties are not
>> parsed by any part of the kernel currently and the max cooling state of
>> gpio-fan cooling device is found by referring to the
>> "gpio-fan,speed-map" instead.
>>
>> Remove the unused properties from the gpio-fan node.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I can queue it next week (different machine hosting the git tree)
> but it is also OK if the ARM SoC maintainers want to pick it
> directly for the ARM SoC DTS branch.

I've picked it up directly now, as we're about to run out of time
before the merge window.

       Arnd
