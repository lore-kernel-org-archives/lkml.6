Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B8720873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B8720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeLMJzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:55:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57060 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeLMJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:55:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B141A2606F6
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
 <20181212222937.GL19816@piout.net>
 <6f688bfe-2ebe-1934-0375-016ae859dcfb@collabora.com>
 <20181213095050.GM19816@piout.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d603fcb9-c1f1-a622-5774-10fac45fc7a5@collabora.com>
Date:   Thu, 13 Dec 2018 10:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181213095050.GM19816@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/18 10:50, Alexandre Belloni wrote:
> On 13/12/2018 10:30:16+0100, Enric Balletbo i Serra wrote:
>>> However, you should probably indicate which tree do you expect that to
>>> go through ;)
>>>
>>
>> Well, these are sub-drivers for different subsystems but are related to the main
>> ChromeOS EC. I expect all go through their specific subsystem and their
>> maintainer. I.e the rtc driver go through your tree, the mfd go through Lee's
>> tree, iio drivers through Jonathan's tree, etc. This is the reason I did not add
>> the tree. Main purpose here as that Benson and I are aware when someone sends a
>> change on one of the sub-drivers and we can review these patches.
>>
> 
> Sure, sorry I was not clear but I was asking about this particular
> patch because as it is, you will get acks from all the maintainers but I
> think they all think someone else will apply it ;)
> 

Ah, ok, I didn't got it :)

If nobody complains and we have all the acks I think that this can go through
the Benson's tree (chrome-platform). The reason is that he already has a couple
of patches related to this (remove Olof as a chrome-platform maintainer and
adding me)

>> Thanks,
>>  Enric
>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Fix typo in Benson email address.
>>>>
>>>>  MAINTAINERS | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index a24129b0b043..bbe7180e2851 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -3625,6 +3625,30 @@ S:	Maintained
>>>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>>>>  F:	drivers/platform/chrome/
>>>>  
>>>> +CHROMEOS EC SUBDRIVERS
>>>> +M:	Benson Leung <bleung@chromium.org>
>>>> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> +S:	Maintained
>>>> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>>>> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
>>>> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>>>> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
>>>> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
>>>> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
>>>> +F:	drivers/extcon/extcon-usbc-cros-ec.c
>>>> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
>>>> +F:	drivers/iio/accel/cros_ec*
>>>> +F:	drivers/iio/common/cros_ec_sensors/
>>>> +F:	drivers/iio/light/cros_ec*
>>>> +F:	drivers/iio/pressure/cros_ec*
>>>> +F:	drivers/input/keyboard/cros_ec*
>>>> +F:	drivers/mfd/cros_ec*
>>>> +F:	drivers/power/supply/cros_usbpd-charger.c
>>>> +F:	drivers/pwm/pwm-cros-ec.c
>>>> +F:	drivers/rtc/rtc-cros-ec.c
>>>> +F:	include/linux/iio/common/cros_ec_sensors_core.h
>>>> +F:	include/linux/mfd/cros_ec*
>>>> +
>>>>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>>>>  M:	Brian Austin <brian.austin@cirrus.com>
>>>>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
>>>> -- 
>>>> 2.19.2
>>>>
>>>
> 
