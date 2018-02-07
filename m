Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2459548-1517964464-2-16082918971553554213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517964463; b=loOEbhOTAJG9G6w9zbrJI8xFOZEUOMzjJzffphglK8mGwIL
    Epd15NKuXvpNnkDMbbAzDMXt3QZAuIIFYOqHN1TLfwmEDBQ/DJDC9iZHXZhde8gg
    NDFDgMz0k9xqWh08B4PIMQwiNmdpOT7xf1yrrtd2p96wQ0SmgbDG/4rIN/qUoCyo
    ig5yglpKOfTXVaJUfmFI27uXYYnruIGoLmqmkr4QURd2KjaBcmGqC6mWAPOb/S1V
    GgsKF2jOKpvcMpbznVnMtSl1K7XSCQp0zn5nVfUVp72HqCZotCu0qXzVFkmMrPUD
    dkf5uuIeI8YOlAqkEdDFdjQjFTs8/UShWHNHPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517964463; bh=9
    A+z0Kv2t6BRNpS5tyeN9duohXTiYdvyzM0pAUTOHTM=; b=o/5mMZmp6MyDv2F/v
    79xyKwCzCLUCcOjuSGocfvk90fn8oSX1FwJjs94KJqqHFqwDszmYVLq3xaDIlsgX
    4Q/j5W9ZZfLj3wgxWROFJaJqCrdP+1t0Ebs7MztAK8ZW0MCBlSyQQVGJgvMRikJB
    fZwMCkSEqCJpX9H6bAnxewHCKNpsj1nEjH/HjUj2NONHOhNoNceV55k+h1cjn91G
    1Y60tIuYvt1/HwEel4fulbXlk7hru7yN/2iVDQDgPpJro1Q8JURllkM0vTXn1mIe
    kxIXZLsKNKGa8MA++W8OAyM9DUkUjJ6Z1aS5Sy2Hf9ZiQKwCuMVOl6aNsKHm9WNb
    IWlEw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH] staging: android: ion: minor cleanup for ion_page_pool
To: Laura Abbott <labbott@redhat.com>, <gregkh@linuxfoundation.org>
References: <1517392252-20964-1-git-send-email-xieyisheng1@huawei.com>
 <19448c54-7214-ce7c-1ae0-9e8605e34f2c@redhat.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <fb1536ee-5223-4cd9-4698-f37ea8a6741c@huawei.com>
Date: Wed, 7 Feb 2018 08:47:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <19448c54-7214-ce7c-1ae0-9e8605e34f2c@redhat.com>
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, sumit.semwal@linaro.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

On 2018/2/7 6:51, Laura Abbott wrote:
> On 01/31/2018 01:50 AM, Yisheng Xie wrote:
>> ion_page_pool.c now is used to apply pool APIs for system heap, which do
>> not need do any initial at device_initcall.
>>
>> Meanwhile, this patch also remove some useless include files.
>>
> 
> Acked-by: Laura Abbott <labbott@redhat.com>

Thanks, and I split this into two small patchs as Greg's suggestion in a resent patch.

Yisheng

> 
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>   drivers/staging/android/ion/ion_page_pool.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
>> index 817849d..3c1eba5 100644
>> --- a/drivers/staging/android/ion/ion_page_pool.c
>> +++ b/drivers/staging/android/ion/ion_page_pool.c
>> @@ -14,12 +14,7 @@
>>    *
>>    */
>>   -#include <linux/debugfs.h>
>> -#include <linux/dma-mapping.h>
>> -#include <linux/err.h>
>> -#include <linux/fs.h>
>>   #include <linux/list.h>
>> -#include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/swap.h>
>>   @@ -171,9 +166,3 @@ void ion_page_pool_destroy(struct ion_page_pool *pool)
>>   {
>>       kfree(pool);
>>   }
>> -
>> -static int __init ion_page_pool_init(void)
>> -{
>> -    return 0;
>> -}
>> -device_initcall(ion_page_pool_init);
>>
> 
> 
> .
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
