Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1547685-1518576940-5-3832076723330383695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518576939; b=cWm3bTHXTeO17emyRHd3V4R8KYN81ZThtSK4GfDI7NvKphO
    CpW1vpee5asmiMMiAZnN39s6QTn7JxG9IzZdc/59ZpFHL9BrXgOwo7GgvOaI+V4s
    c8JGLMGMZGJWJWtg8nJN75Vu7sMLfk02FPfyQb7z4+i875qGbbcG2KnF54Is9SIB
    ChKGZf6zVxCpwqCHsLqk7suKzzYbnZ2FYC9ZRm1BYW7IRmGB/SSgNeiHrkDndccH
    YARRkr3D9OlYO/NhBnPTituM+nm9qKekUn0c+FWmsAFlWd6r+fO0lkRyP0D1BtE1
    SetS/hCiTNCu8CYHbeO5+zubcUFQnvjsGvWdlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518576939; bh=A
    BeFBQJSH/lmyCx/QW7T3c/r2MTWQqglyPK21Wzy5yY=; b=Dfl+l9oZ9Q48luvJ8
    mEHRWO2l9D+zhfLnlaBmU4BybnLAEhQ5PFGgAJN8btBWpNiD+A6Pxducgb2hH0WX
    5n33MboZB3rLOSYu73NQOnvfCHxTXKyCtPbRdLseUSqssr0bn0XpxxjSoREoB87U
    Zy3HCk/jagIteePJ9Ljc8Z4AJrJOogDRkQLq02LWT57pjsi2GTqKrZFehVuEbxTf
    csgJRCe7/cs/7xG5+zU5EoikiX8UBwGMWg9Ghe/R03dmAO2aU2kiN8JZmolqmSrl
    0detmyQFHVuaEozH5SRz8vGXsUkybB+qxDg+BOZtj0yv0zb+SrVrvV9BVNZKvUPL
    pzm/w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
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
Subject: Re: [PATCH resend 1/3] staging: android: ion: Remove unused
 declaration ion_buffer_fault_user_mappings
To: <gregkh@linuxfoundation.org>
References: <1517450062-16123-1-git-send-email-xieyisheng1@huawei.com>
 <344d69c2-b25d-b45b-61f3-bbb597441b9f@huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <360fde49-fe70-5e58-548d-b290ce2867da@huawei.com>
Date: Wed, 14 Feb 2018 10:54:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <344d69c2-b25d-b45b-61f3-bbb597441b9f@huawei.com>
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

Hi Greg

On 2018/2/12 19:40, Yisheng Xie wrote:
> Hi Greg,
> 
> JFYI, I have rebase this patchset to v4.15-rc1.[1]

Ah, sorry , I mean v4.16-rc1, and the same to other threads.

Thanks
Yisheng

> 
> [1] https://lkml.org/lkml/2018/2/12/204
> 
> Thanks
> Yisheng
> 
> On 2018/2/1 9:54, Yisheng Xie wrote:
>> ion_buffer_fault_user_mappings's definition has been removed and not be
>> used anymore, just remove its useless declaration.
>>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  drivers/staging/android/ion/ion.h | 9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
>> index f5f9cd6..2160c35 100644
>> --- a/drivers/staging/android/ion/ion.h
>> +++ b/drivers/staging/android/ion/ion.h
>> @@ -201,15 +201,6 @@ struct ion_heap {
>>  bool ion_buffer_cached(struct ion_buffer *buffer);
>>  
>>  /**
>> - * ion_buffer_fault_user_mappings - fault in user mappings of this buffer
>> - * @buffer:		buffer
>> - *
>> - * indicates whether userspace mappings of this buffer will be faulted
>> - * in, this can affect how buffers are allocated from the heap.
>> - */
>> -bool ion_buffer_fault_user_mappings(struct ion_buffer *buffer);
>> -
>> -/**
>>   * ion_device_add_heap - adds a heap to the ion device
>>   * @heap:		the heap to add
>>   */
>>
> 
> 
> .
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
