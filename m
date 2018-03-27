Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeC0NYV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:24:21 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46036 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeC0NYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:24:17 -0400
X-Google-Smtp-Source: AG47ELvwr8tnFQmfGSUpsSC+tMndhe1XKJlvcuw5s7jvKSOzL8h6lATBQs77I6TGkru2vvWKC33oVPhNQXb9USmiai8=
MIME-Version: 1.0
In-Reply-To: <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org> <20180321165848.89751-3-swboyd@chromium.org>
 <1521655150.23017.79.camel@linux.intel.com> <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:24:16 +0200
Message-ID: <CACRpkdbg40yaKVbo-b6UKAYfGpT2ZLDdXaPKgEn-4zGL4mKuag@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 8:59 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Andy Shevchenko (2018-03-21 10:59:10)
>> On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
>> > From: Stephen Boyd <sboyd@codeaurora.org>
>> >
>> > Some qcom platforms make some GPIOs or pins unavailable for use by
>> > non-secure operating systems, and thus reading or writing the
>> > registers
>> > for those pins will cause access control issues. Add support for a DT
>> > property to describe the set of GPIOs that are available for use so
>> > that
>> > higher level OSes are able to know what pins to avoid reading/writing.
>> > Non-DT platforms can add support by directly updating the
>> > chip->valid_mask.
>>
>> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>
>> Hmm...
>
> Don't look closely! :P

Same physical person acting on behalf of two different legal
entities right? Seems OK to me.

Yours,
Linus Walleij
