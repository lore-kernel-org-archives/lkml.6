Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeDMCnR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 22:43:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26858 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeDMCnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 22:43:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180413024313epoutp010987571cd7f2aefb47444a9a9fe97114~k3qmD1zTB2342323423epoutp01J
X-AuditID: b6c32a35-151ff70000000fee-68-5ad01938f4a2
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AD01937.1070504@samsung.com>
Date: Fri, 13 Apr 2018 11:43:03 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: arvindY <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
In-reply-to: <5AD017E8.7020901@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTURjm7M7taq5uU+toZfOGkILTO7+upmYktkxICCwUWxe9bOI+ZHcz
        DRGTyhhqpma00tyPSPwIJlJ+FOZURmHOFpagM9L8aKQ/ssyf3e0q+e85z3me87zn4UUR8apP
        CFqsNdB6LaXGBX78l2MR0igyeDovZrvzJPm53oKQH2p+CslPQ08E5Gb9OCDnbnYK0n3kg2aX
        UN7Q3wXkm32hOUgenaKiqSJaL6G1hbqiYq0yFb9wSXFWEZ8QQ0QRSWQiLtFSGjoVz8jOicos
        VrORuKSMUhtZKodiGDw6LUWvMxpoiUrHGFLxfIKQSYmYRKlMJpPGxRYky+JZyTVaZXdPIKXd
        x8tXOkZ41aA52AR8UYjFweVqt9AE/FAxNgDg6uaQ0HMhxv4C+G3euCu6/eA54ETDALp/fRd4
        LkTYQbjdvMA3ARRFsONw3FnioREsAq79buJzeheArmEXn9NHQmuvE/FgPhYOH684vFjA8iNr
        s943D2BhcGZ7CXhwEHYFDj7d8g4UiF2FjbYmHheQDIcWG7yaACwTbrvqvV5fNnh2Ys0bDLEe
        Aex/v4pwP8iATvsLwOEA6Lb3Cz1DQ+wIdE6kcvpaAGvftCPcoQXAqS8LPM4QC1cspp3k/XDj
        T50PZxbBu3fEnEQOV9rnd7LOwOpey06l0zxon54XNoJQ857CzP8LM+8prAMgXeAQXcpolDRD
        lBJShtIwRq1SWqjT9AHvkkXGD4CWqWwbwFCA+4skFY48sQ9VxlRobACiCB4oerjEUqIiquIG
        rdcp9EY1zdhAPNv3fSQkqFDHrqzWoCDikmLiEmTseiURBH5YtJw9mSfGlJSBLqHpUlq/6+Oh
        viHVwN9kye+2KaZzf2Rao8ugKu2otL3KcmwrJajcemusPj3Y+Tpl417Z23dzvMqGRw2Ogqr1
        j1Yq8hUR/rVnisw5nzUw6l4wSXPD5aP5aX14d0hWs8rRtqgk6ybDLz6rXL9sojpOm2d7E9v8
        C9McrcSpxvUiN3XiXGtN63X+vrAZnM+oKCIS0TPUPzU/SRh6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t9jAV1zyQtRBi/3GVlc613IbHG26Q27
        xeVdc9gsPvceYbS43biCzYHVY+esu+wefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlXH81VHm
        gtXyFc8W7GdqYJws2cXIySEhYCLROnU5YxcjF4eQwE5GiZfPzrOAJHgFBCV+TL4HZHNwMAvI
        Sxy5lA1hqktMmZILUX6fUeLdmqtMEOVaEhvXXmIGsVkEVCVmPzsPZrMBxfe/uMEGYvMLKEpc
        /fGYEWSOqECERPeJShBTRCBOomlxJkgFs4CVxK5HfYwgtrCAm8SPu71sEKsuMUlcXf6fHSTB
        KaApcePoC5YJjAKzkBw6C+HQWQiHLmBkXsUomVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJ
        ERi82w5r9e1gvL8k/hCjAAejEg+vQuX5KCHWxLLiytxDjBIczEoivNMfA4V4UxIrq1KL8uOL
        SnNSiw8xSnOwKInz3s47FikkkJ5YkpqdmlqQWgSTZeLglGpgZJa5dCq4OeePzhdbht97Of4f
        bRTNSnNkkWY0T79YrCX8XbZr3dJ3b2uUlZSVnn5v9uvxrfiwO/3shtr3f57fV+pcM8vrcr7g
        +2td0+4HCBzLWqleHL8y3uSAQPYBD1+n0wbXeb5udTMvi+s08fQx6JvnbSZc3Fr/amH3T7t1
        Vx/ytmXnSy5WYinOSDTUYi4qTgQAJi+r41oCAAA=
X-CMS-MailID: 20180413024303epcas1p17d208c9d813656e1cc6674e5d52abafb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
X-RootMTR: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
References: <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcas5p1.samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
        <5AD001C5.2040406@samsung.com> <5AD0041D.2050506@samsung.com>
        <5AD012CB.7030003@gmail.com> <5AD0160E.7050601@samsung.com>
        <5AD017E8.7020901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 04월 13일 11:37, arvindY wrote:
> 
> 
> On Friday 13 April 2018 07:59 AM, Chanwoo Choi wrote:
>> On 2018년 04월 13일 11:15, arvindY wrote:
>>> Hi Chanwoo,
>>>
>>> On Friday 13 April 2018 06:43 AM, Chanwoo Choi wrote:
>>>> On 2018년 04월 13일 10:03, Chanwoo Choi wrote:
>>>>> Hi,
>>>>>
>>>>> I'm sorry for the late reply.
>>>>>
>>>>> On 2018년 03월 30일 20:44, Arvind Yadav wrote:
>>>>>> Never directly free @dev after calling device_register() or
>>>>>> device_unregister(), even if device_register() returned an error.
>>>>>> Always use put_device() to give up the reference initialized.
>>>>>>
>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>>>> ---
>>>>>>    drivers/devfreq/devfreq.c | 4 +++-
>>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>> index fe2af6a..a225b94 100644
>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>        err = device_register(&devfreq->dev);
>>>>>>        if (err) {
>>>>>>            mutex_unlock(&devfreq->lock);
>>>>>> -        goto err_dev;
>>>>>> +        put_device(&devfreq->dev);
>>>>>> +        goto err_out;
>>>>> why do you change the goto postion?
>>>>> err_out is correct to free the memory of devfreq instance.
>>>> Sorry. err_dev is correct instead of err_out.
>>> If you will see the comment for device_register(drivers/base/core.c)
>>> there is mentioned that 'NOTE: _Never_ directly free @dev
>>> after calling this function, even if it returned an error!
>>> Always use put_device() to give up the reference initialized
>>> in this function instead. Here  put_device() will decrement
>>> the last reference and then free the memory by calling dev->release.
>>> Internally put_device() -> kobject_put() -> kobject_cleanup() which
>>> is responsible to call 'dev -> release' and also free other kobject resources.
>>>
>>> We are releasing devfreq in devfreq_dev_release(). So no need
>>> to call kfree() again. It'll be redundant.  'err_out' is correct.
>> You're right. err_out is correct.
>> put_device() -> dev->release() -> devfreq_dev_release() -> kfree(devfreq)
>>
>>>>>>        }
>>>>>>          devfreq->trans_table =    devm_kzalloc(&devfreq->dev,
>>>>>> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>        mutex_unlock(&devfreq_list_lock);
>>>>>>          device_unregister(&devfreq->dev);
>>>>>> +    devfreq = NULL;
>>>>> It is wrong. If you initialize the devfreq as NULL,
>>>>> never free the 'devfreq' instance.
>>> No need to release memory after device_unregister().
>>> driver core will take care of this. It will release memory
>>> So no need to call free again.
>> If you have to initialize the devfreq instance as NULL,
>> I think that you better to init in the devfreq_dev_release()
>> as following:
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index fe2af6aa88fc..8c52a13d3887 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -543,6 +543,7 @@ static void devfreq_dev_release(struct device *dev)
>>            mutex_destroy(&devfreq->lock);
>>          kfree(devfreq);
>> +       devfreq = NULL;
>>   }
> 
> Yes, You are right. I will share a update patch.
> Thanks for reviewing.

It is my mistake. 'devfreq' is local variable in the devfreq_dev_release(0.  
Even if initializes 'devfreq = NULL' in the devfreq_dev_release(),
it cannot initialize the 'devfreq' local variable in the devfreq_add_device().

I think that your original patch is good.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

>>
>>>>>>    err_dev:
>>>>>>        if (devfreq)
>>>>>>            kfree(devfreq);
>>>>>>
>>> ~arvind
>>>
>>>
>>>
>>
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
