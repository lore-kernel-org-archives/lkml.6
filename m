Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeEVU7a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:59:30 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40912 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeEVU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:59:27 -0400
X-Google-Smtp-Source: AB8JxZp1uIHu5VYallzE6PBLyHUigxF4UvuoTBk47lkEjMFhXOV7rILEHRLdiXApvg8Mme4GnuCssw==
Subject: Re: [PATCH v8 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan Murphy <dmurphy@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180522142417.19639-1-dmurphy@ti.com>
 <20180522142417.19639-2-dmurphy@ti.com>
 <CAHp75VfTtD3Mnyqb63R_BP8BoAGNZProLCgWoDMo-aTk5C-iVA@mail.gmail.com>
 <dca52e6e-451c-2ca4-a001-867708622d7b@ti.com>
 <CAHp75Vdg9HTyQhv1KMOCqq5FjgPAC2q015Opnh3jDWvZY2bbNQ@mail.gmail.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6577f2f9-7a31-3b98-71e2-2f86818eac7a@gmail.com>
Date: Tue, 22 May 2018 22:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdg9HTyQhv1KMOCqq5FjgPAC2q015Opnh3jDWvZY2bbNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 10:34 PM, Andy Shevchenko wrote:
> On Tue, May 22, 2018 at 11:26 PM, Dan Murphy <dmurphy@ti.com> wrote:
>> On 05/22/2018 03:12 PM, Andy Shevchenko wrote:
>>> On Tue, May 22, 2018 at 5:24 PM, Dan Murphy <dmurphy@ti.com> wrote:
> 
> 
>>>> +static struct lm3601x_led *fled_cdev_to_led(
>>>> +                               struct led_classdev_flash *fled_cdev)
>>>
>>> Didn't notice before. This will look much better in one line.
>>
>> Gives LTL warning.
> 
> I wouldn't really care about it.
> But I leave to Jacek to decide.

Please make it one line.

It is even Linus' recommendation to not strictly stick to the
80 character limit as we all have modern computers nowadays.

> After addressing the rest, FWIW,
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

-- 
Best regards,
Jacek Anaszewski
