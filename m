Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932073AbeDWQlK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:41:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34499 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755115AbeDWQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:41:07 -0400
X-Google-Smtp-Source: AIpwx494eOTXDtxE5GcLWXuJ4Y+CtJlsZBPe1uqbeldOtMAV+2E69IQvtm9Jo6HkOVxp1ExbvFwhCO5EQn6hLUBC0Xc=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpcmO7LYuyuNPcYmzeDyq_AXDH5W4Y9dByTL-B+DGZSqg@mail.gmail.com>
References: <20180408113647.13543-1-yixun.lan@amlogic.com> <7ho9if3wo3.fsf@baylibre.com>
 <CAPDyKFpcmO7LYuyuNPcYmzeDyq_AXDH5W4Y9dByTL-B+DGZSqg@mail.gmail.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 23 Apr 2018 09:41:05 -0700
Message-ID: <CAOi56cUwzrpA1AdRQE3gdW55my-_dqSNnwyEd4poUPjUkpaBag@mail.gmail.com>
Subject: Re: [PATCH v2] ARM64: dts: meson-axg: enable the eMMC controller
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Nan Li <nan.li@amlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carlo Caione <carlo@caione.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:55 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 April 2018 at 19:58, Kevin Hilman <khilman@baylibre.com> wrote:
>> Yixun Lan <yixun.lan@amlogic.com> writes:
>>
>>> From: Nan Li <nan.li@amlogic.com>
>>>
>>> The IP of eMMC controller in AXG is similiar to Meson-GX series.
>>> Here we add the initial support of the HS200 mode with
>>> clock running at 166MHz (to be safe), since we found some eMMC chip
>>> fail to run at 200MHz due to tunning phase error.
>>>
>>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>
>> Applied to v4.18/dt64
>>
>>> ---
>>> Hi Kevin
>>>   Please note this patch actually depend on the eMMC driver here [0].
>>>   Still a few problem to solve, to improve the tuning phase driver to make
>>> the clock running at 200MHz, and to further support the HS400 mode.
>>> Anyway, this patch itself is quite independent.
>>
>> The driver changes are queued for v4.18 also.  Good!
>
> Right, may I consider that as an ack? :-)

I thought it was already merged while I was OoO, so I didn't bother to
reply with an ack, but if it's not too late, then yes:

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
