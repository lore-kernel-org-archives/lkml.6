Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeC3LHS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:07:18 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:34990 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC3LHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:07:15 -0400
X-Google-Smtp-Source: AIpwx4/nUA7FcUl1M+f9nN5B/fTTFnyGwxMkVa9UrgWPT+lgGv64TTPjeNMJxf54jULIw66BI8HqpqIQn4k6pgLMq2w=
MIME-Version: 1.0
In-Reply-To: <6166e140-b417-dd22-10cf-843db3958226@lechnology.com>
References: <20180327092031.11251-1-brgl@bgdev.pl> <6166e140-b417-dd22-10cf-843db3958226@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 30 Mar 2018 13:07:14 +0200
Message-ID: <CAMRc=Me-+oDi7R-=sSbKU45EFDv04X2rswksLD2N1rnbYrZo2A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] ARM: davinci: complete the conversion to using the
 reset framework
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 18:48 GMT+02:00 David Lechner <david@lechnology.com>:
> Wasn't there a v4 already? Is this really v5 instead of v3?
>

Yes there was and Philipp applied the v4 alright.

>
> On 03/27/2018 04:20 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This series converts the only user of the handcoded, mach-specific reset
>> routines in the davinci platform to using the reset framework.
>>
>> Patches 1-3 add necessary lookups/DT-properties.
>
>
> Should I just squash the DT changes into my common-clock-v9 branch
> since those patches haven't been picked up yet anyway? That will be
> 2 fewer patches to keep track of.

I would personally prefer to keep the changesets thematically
separate. The clock series is big anyway already.

Thanks,
Bartosz
