Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757328AbeD0CNm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757197AbeD0CNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:13:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B5121854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AB8JxZpccsRao1fbSBOLSANO9+B4TtZgj6TIB0efZHWZ17TkEjNyY4by2YvkyhbqXvJrYjZHdPXYMzNpsRRRiRnSb+Y=
MIME-Version: 1.0
In-Reply-To: <20180426214205.22f1a543@windsurf>
References: <20180426015754.26605-1-robh@kernel.org> <20180426053255.75jg5bsdu4h624jo@vireshk-i7>
 <20180426214205.22f1a543@windsurf>
From: Rob Herring <robh@kernel.org>
Date: Thu, 26 Apr 2018 21:13:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJw4-bgQOXG3_0poC5Uy8kB5Bg4mns=Uhne=LONvTX15g@mail.gmail.com>
Message-ID: <CAL_JsqJw4-bgQOXG3_0poC5Uy8kB5Bg4mns=Uhne=LONvTX15g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: staging: remove a couple of ADC bindings
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roland Stigge <stigge@antcom.de>, Stefan Roese <sr@denx.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 2:42 PM, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> Hello,
>
> On Thu, 26 Apr 2018 11:02:55 +0530, Viresh Kumar wrote:
>> @Thomas: Do you guys use this ?
>>
>> On 25-04-18, 20:57, Rob Herring wrote:
>> > Remove LPC32xx and SPEAr ADC bindings in staging. They have not been
>> > touched since 2012.
>> >
>> > Cc: Roland Stigge <stigge@antcom.de>
>> > Cc: Stefan Roese <sr@denx.de>
>> > Cc: Jonathan Cameron <jic23@kernel.org>
>> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> > Move these out of staging please or they are going to be removed.
>> >
>> >  .../bindings/staging/iio/adc/lpc32xx-adc.txt       | 16 -------------
>> >  .../bindings/staging/iio/adc/spear-adc.txt         | 26 ----------------------
>> >  2 files changed, 42 deletions(-)
>
> We are using the spear-adc driver, which is out of staging
> in ./drivers/iio/adc/spear_adc.c. So rather than removing its DT binding
> entirely, it should be moved out of staging.

Except I have comments on the spear binding and it's fair game to
change it being in staging, right?

Rob
