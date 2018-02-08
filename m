Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeBHGH7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:07:59 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41347 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeBHGH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:07:57 -0500
X-Google-Smtp-Source: AH8x225MsLFmuV6LPfAeKt4XpzQMLLlReLiP5/Hf9KH2TmHFp5dI+yeKGEtYOrBjhvjEbEg98Wfb3QzvvoP4dbMzuP0=
MIME-Version: 1.0
In-Reply-To: <20180207211918.whcxq2not7elokae@rob-hp-laptop>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
 <20180207211918.whcxq2not7elokae@rob-hp-laptop>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 8 Feb 2018 14:07:56 +0800
Message-ID: <CAMz4ku+5ojNr8y_zKBgKtLxon9++M6xCZ=7NzjeStesZ0Y8oGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add Spreadtrum GPIO controller documentation
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8 February 2018 at 05:19, Rob Herring <robh@kernel.org> wrote:
> On Mon, Feb 05, 2018 at 09:55:10AM +0800, Baolin Wang wrote:
>> This patch adds the device tree bindings for the Spreadtrum
>> GPIO controller. The gpios will be supported by the GPIO
>> generic library.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v1:
>>  - No updates.
>> ---
>>  .../devicetree/bindings/gpio/gpio-sprd.txt         |   28 ++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
>
> Please add acks/reviews when posting new versions.

Yes, I always do that. But you acked my V2 after I already send out
the V3. Anyway thanks for your reviewed-tag.

-- 
Baolin.wang
Best Regards
