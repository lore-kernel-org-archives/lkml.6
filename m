Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEBJm3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:42:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeEBJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:42:28 -0400
Subject: Re: [PATCH v2 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger
 driver as a subdevice.
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-4-enric.balletbo@collabora.com>
 <20180501083229.GL5147@dell>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fa4f27ca-00ab-22e5-a693-401344797eb9@collabora.com>
Date: Wed, 2 May 2018 11:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501083229.GL5147@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 01/05/18 10:32, Lee Jones wrote:
> On Mon, 30 Apr 2018, Enric Balletbo i Serra wrote:
> 
>> Check whether this EC instance has USBPD host command support and
>> instatiate the cros_usbpd-charger driver as a subdevice in such case.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2:
>> - [3/3] Use ARRAY_SIZE instead of hardcoded 1.
>>
>>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
> 
> Patch looks good to me.
> 
> Does it depend on any of the other patches in the series?
> 

No, it only depends on [1] to apply cleanly (mentioned in the cover letter). I
think that [1] is close to be picked. If this is not the case I can rebase
without this dependency.

[1] https://lkml.org/lkml/2018/4/18/229

Best regards,
 Enric

> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
