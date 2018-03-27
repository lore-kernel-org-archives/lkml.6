Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeC0JLB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:11:01 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38970 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeC0JK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:10:57 -0400
X-Google-Smtp-Source: AG47ELtAt/ITwBHkc8ODHweJXr05wvQLZEJ5nIAnE1fKHTLX8d2CJUh8q30J2ICt5nQC3UeZq6PSaOPDRqU7Ku8V+EU=
MIME-Version: 1.0
In-Reply-To: <CAHp75VdmiESNg_06iby8Y0FgK47AHkJdu1kVYiBch82zGcnv-g@mail.gmail.com>
References: <787c9f115db06390549bfee366b7f70faf312286.1520218279.git.baolin.wang@linaro.org>
 <c84c05b6619a17848a11335f881f42153a4e51c0.1520218279.git.baolin.wang@linaro.org>
 <CAHp75VdmiESNg_06iby8Y0FgK47AHkJdu1kVYiBch82zGcnv-g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 27 Mar 2018 17:10:56 +0800
Message-ID: <CAMz4ku+cvrNmCL3g7hKVO7Tj6xQuWKToytHD0Hxx1ftptMO1Jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: Add Spreadtrum PMIC EIC driver support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 23:46, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 5, 2018 at 4:56 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The Spreadtrum PMIC EIC controller contains only one bank of debounce EIC,
>> and this bank contains 16 EICs. Each EIC can only be used as input mode,
>> as well as supporting the debounce and the capability to trigger interrupts
>> when detecting input signals.
>>
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> for entire series.

Thanks Andy.

Linus, could you apply this series if there are no other issues? Thanks.

-- 
Baolin.wang
Best Regards
