Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8333CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfAaIDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:03:12 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:48455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:03:12 -0500
Received: from [192.168.178.52] ([109.104.48.218]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mgvj3-1hNMaU3xaH-00hOap; Thu, 31 Jan 2019 09:02:36 +0100
Subject: Re: [PATCH RFC 1/3] dt-bindings: hwmon: Add tachometer interrupt to
 pwm-fan
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
 <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
 <20190130172815.GC14781@roeck-us.net>
 <625436113.118199.1548879811777@email.ionos.de>
 <20190130203525.GA23614@roeck-us.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <fbfd2b67-f6d2-4d6e-9351-d1d2165e571b@i2se.com>
Date:   Thu, 31 Jan 2019 09:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130203525.GA23614@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:q49cjtZ0LCCcMQQOEvhRpIwsRgVFqz0rph8dcQnD8Zt3Jey6RW2
 gZbrm9tRAXuRVGgg+7RzOpwAwIq7PzH+CFcE5+RY4Vs5tCIT6zkrY/R9hVwe6mTP/CIooSz
 t0rS/G05ZnClRDw3DiDjCfR67folNdQUIyvaVK5im+ZNqrj9Zf5bwF2HPj/LwnDgOLx5anQ
 xf1aKpDB2kZSkTXehc70g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfJGdD/pqpE=:MUWLMI6P2K6Y+NXCvXzK69
 sYxcjggy5+12OI4QkDcwswEB0tmOJs3Zo1+8E1X47Y0j/X60YEQNS+eXCKExMMMu3u7S8puxj
 oF9wEg86NYIfAyPaKAy0UntrVZaF/ga4mVuKnnNDCDrNPD5jaGTyYQdnfl0VeCiPmnO4Ssygr
 gqwY/jTp7EbPyDLqoB9MIs2m7+dVu+n77zi5HmcFF3Kq4MvdVa5bh48fBvmtaADJ11GDAlmZr
 E6WEF3G/tob6WRfF8tzTFF1UgJRGOBDkaslxGYkUyb1Hh4lOy1QlX9nE9rVD9lMj3cAFjAfwH
 yHkTvQZXfbafp8etS8x/sWTzAyeO5eQ9Wp/9ntwN/znZR0NQvhP8tHmihags9JtFWh1N1D4WW
 m7I9Y/3PAl+cPQTCVTra9T7kPoiPyuTlRcw4siJsFjOnFxs/IVElLsfSmC33kbwgmPSPVEbwa
 D6V9KA7aqX0bIW+1NPwIFHa1j6UxLTDaYnOmzDBHSUQtWKLTRWq0UU352vFrxD7J4UfOBLfIy
 ecObjgO7IuZ5FMRLTHvt3IMda+eiPyibVMa7RjuWFbGAO9zTnQVk+jqJH00A3CRrMBBNnIQy0
 Ldiz6X/7m4T30OSGV9hxSKfyMi+cbf0r/dv76FF/AwS8d73SK/Y7DreXmP9dn0PGWbwdm7hMB
 f+yFbzPUQuZ1CB/hRpx0hsYqzo2qu5o40xsM5A7jB8GppvwaB/JKuBQqKAeoasTsuQaIi7rBg
 P1gXO3AOFpuDkYkqi8N5AVdmZRidTAPvKSqOJbmuQ9QmgqNwMLC6+wmB1I8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am 30.01.19 um 21:35 schrieb Guenter Roeck:
> On Wed, Jan 30, 2019 at 09:23:31PM +0100, Stefan Wahren wrote:
>> Hi Guenter,
>>
>>> Guenter Roeck <linux@roeck-us.net> hat am 30. Januar 2019 um 18:28 geschrieben:
>>>
>>>
>>> On Wed, Jan 30, 2019 at 04:07:05PM +0100, Stefan Wahren wrote:
>>>> This adds the tachometer interrupt to the pwm-fan binding, which is
>>>> necessary for RPM support.
>>>>
>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>>>> index 49ca5d8..7f69b0b 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>>>> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>>>> @@ -8,6 +8,9 @@ Required properties:
>>>>  
>>>>  Optional properties:
>>>>  - fan-supply    : phandle to the regulator that provides power to the fan
>>>> +- interrupts    : contains a single interrupt specifier which describes the
>>>> +                  tachometer pin output of a 2 pulse-per-revolution fan.
>>>> +                  See interrupt-controller/interrupts.txt for the format.
>>> So a hypothetical {1,4} pulse-per-revolution fan would explicitly not be
>>> supported ? Why ?
>> i could add an additional property to specify the pulse per revolution and use the 2 as default (according to the Intel spec for 4 pin pwm fan) which should fit in most cases.
>>
> That would be a possibility and make sense, but that is not
> the point here.  The "interrupts" property does not and should
> not care how many pulses per revolution the fan provides.

sorry, i'm not sure what's the problem about. Do you want me to use a
GPIO instead of interrupt?

Or is it the wording here?

Suggestion:

contains a single interrupt specifier which is describes the tachometer
output of the fan as an input

Stefan

>
> Guenter

