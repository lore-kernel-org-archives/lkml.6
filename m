Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbeEBFsu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:48:50 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:40361 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeEBFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:48:48 -0400
X-Google-Smtp-Source: AB8JxZpDguqqfI/RA4/xX3QvU9W/Dt71l5AqjaoFVhTorTkjCMoJi0991kCnxQrEhgbDptEqoOevxt3iq2MnZGpXlk8=
MIME-Version: 1.0
In-Reply-To: <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato> <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 2 May 2018 13:48:47 +0800
Message-ID: <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is called
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 May 2018 at 13:23, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > We should maybe handle this in the core somewhen, though. Or?
>>
>> Thanks. Yes, It will more helpful if we can handle this in the i2c core.
>
> To understand the issue better: which kind of devices in your system
> still send I2C transfers when the system is going to suspend? Do you
> know?

Now we found the touch screen device will trigger I2C transfers when
the system is going to suspend.

-- 
Baolin.wang
Best Regards
