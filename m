Return-Path: <outreachy-kernel+bncBCINLKMVUUKRBS4G5PKAKGQES7KOJQA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520091980; cv=pass;
        d=google.com; s=arc-20160816;
        b=Yq/2nEJCzKB9RDygVWxwkHFGxb/Yj0OfdeO68IePZ+CbtYxPun3/3zNTD3WhWI5rI9
         FMYLzUtB+m2Ghj4WbWM0WsQyCxRD2We6L907Sn7a6NtPPFOY0S9urGrR5Sin0n0GN41P
         gvx6+WP7j2xLYJwCJwXwp9k2IYn67dUtGsLXN2VyZaZO/Sp0BLlQO2MD5aejP1Uz0uCo
         vt5kMQVNUTz8aTCHJFt97pm/CV1+qEvMb1iup3oUon1R/LwTnW2D8v3+J3ZUQ6a0PB6I
         O9gS/n5WUlqH9QP4MKyB2bV0PqYpaM6pepNEXfHB9XhcONpt1n0L9r7OyoJQJd7Uv7aW
         471g==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=J12ZGEJTn21e/K5+rg1fnwArw5XGV7oDQMQFQY1U+Wo=;
        b=T8kMncWXO9MvorPa4FYtMbVDjCaVSN0YuqjIIFMKWNIbE4cR1v30zlMnWRxF6DIfA6
         xvxr0od1Jwiv/MYCAEZxKM4r66GuoTP5MUW8WdV6ay8sT0qHdJfw5qHg+8UzUYMKAjxU
         MZkhSCWDZ8lHggszCX8jEhCcAm6cVtWD10e07YNevwUv+xs6lrIe1S/xQhc6wSfPZnl5
         KdO0GXqly89lt1BfVCAoRAsYnDhHOV6yewCl6jfRlebqUgqeYnQzOErknAvbA214Tb9U
         Pm468UebRBRsg5s3v2R6m7FX8WJW0mAY2nAiWmjh63qRb0rSNHFoosHlRGRB/XfZOixr
         ah+Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=JmAqgrjw;
       arc=pass (i=2 spf=pass spfdomain=intel.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcinlkmvuukrbs4g5pkakgqes7kojqa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCINLKMVUUKRBS4G5PKAKGQES7KOJQA@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=JmAqgrjw;
       arc=pass (i=2 spf=pass spfdomain=intel.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcinlkmvuukrbs4g5pkakgqes7kojqa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCINLKMVUUKRBS4G5PKAKGQES7KOJQA@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520091980; cv=pass;
        d=google.com; s=arc-20160816;
        b=XkO9UNMwB4MPjqQaRJ6uS2m3lVFOkLv9xfV1SI+Q6d3tkF/QwhIydfHkzgITEnYkyQ
         tZ8wpVETkz6EWlFf/QibO6Q2AE5KCnBOdlmfXzMCs6gJ579zMFzmQl138/L3UVYqWgHq
         1a6KmNBKHOmeUbYoJlGtC0fq1nXQHahnWkDWgSfcSmjmDWJnES6GLM9oiupVdzkv5Roe
         NRTdYO70F5W4TKY9bAMiDyYvw/ithlhaXRF/JETnuUUFoPyVmRydTd4WWYxShpMIV50A
         /+KSnwdxzJzt43TcbKYBFRIfArHYYsd08TJTyC7a80bWgsi0psNAZtq6+QK7Htgx0PRn
         mDuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=J12ZGEJTn21e/K5+rg1fnwArw5XGV7oDQMQFQY1U+Wo=;
        b=SeXqAqNjCC+iT/FHyEgr/tJRxK0wSwNfWSfYM2/Wyq4F7ENOt65h749zOfWF7hzLlG
         EHpWMbfw62D30krXRDVn/PGEihgTYAeytf3EXG2lVeVi+oBdT4JlPeQwE3s+re/oxySa
         eYJB/YFEMhglrAalz0fHe1f7WmYMPG4+sPCNAtfAh0P56fhaZ3IRfu5D170uUDMNSLv8
         z3kwYHgBMaEGJJvhxJCfgDhR437wmTfq8F/BloDHyK1M1LltA2MWt2nynLY2s8Z8bWoG
         DFIPnilkMGl+rVUNC+B0JxGpNW6gfFa+bscf3BCC0qW4JobY1G++i/FROHTJJfQT3Cig
         uAMw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of dennis.dalessandro@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dennis.dalessandro@intel.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtyyncjIhX5HsMuUOTMcdtVXtaZUOojAZgk/Bmh8OUQa113H1o/SyX2gBSd7+ygQIUNUptuHA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520091272; cv=none;
        d=google.com; s=arc-20160816;
        b=uhWNQs/xF72YAnOAwpKKB0o1hfZzprgaTwI2DT2GoeIEspkA1nq43LFaVO515O3kJb
         D8wodRiD98c5FNzDIeu4cWDAlsDTCJhETt87L9Xv2QcP1Zj1neTfEM1i3EZm6o15RFKn
         6natmESkJAatrAzJUcx/vvcOci5/fbG4/AHBkPgDxryrwc98MBjun0EXb8/eGfVZ5jC0
         o2Ff9z+vZHla5mI8gf+4akRcXwDDbLIcFqXs+wynWrfe6cRVvznotZk0JasOniXUz6nf
         EwdmoLUq7ZWGZ5wLlYKnKGeWQGNpxoVC0EYvRSuTiP4dNlwPamMnUtlKNtU4ikJqsBsC
         Dyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=u8dsMu0n2k/y7zG1THANrwfLs1Wswypwevzf4Z2GrqA=;
        b=uSVaV4RkkYmTuduiEdsRaBoSzHEM8RKe7M/XE1wwSRHkfjwqoIVbTE3/p4+NOB1Jab
         xndZ8WTHw6HnTpX06TbMxu3EkdhUpC0onHpmNdZlLL81YQGGuvX+oMNHVjZzAYvTv6Ph
         RMv3hrG5HuV/LiN/zXnvivd6Yb0R/usyJuGAj9gkNviVjOJfrFA06xzLGWVVc+0B8Mq3
         BKgO3fk93dv2a8A7WdqdDAIOD11P4f9a15McVg54NNzxxvh+DAiu6HVhSuMIlXyd28E0
         ksyuLvvRBX71ZRLJ4EitGSwSviOe58ISUR9X4uTt59p/+prBHgxjQy4CHzRvtWCJiPDc
         lI/Q==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of dennis.dalessandro@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dennis.dalessandro@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,418,1515484800";
   d="scan'208";a="21612771"
Subject: Re: [Outreachy kernel] [PATCH] infiniband: hw: Drop unnecessary continue
To: Julia Lawall <julia.lawall@lip6.fr>,
 Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: mike.marciniszyn@intel.com, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20180303130336.GA8210@seema-Inspiron-15-3567>
 <alpine.DEB.2.20.1803031506550.2302@hadrien>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <2032604b-b25b-e5bf-bea5-3c43a50b8ff7@intel.com>
Date: Sat, 3 Mar 2018 10:34:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803031506550.2302@hadrien>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
X-Original-Sender: dennis.dalessandro@intel.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of dennis.dalessandro@intel.com designates 192.55.52.136
 as permitted sender) smtp.mailfrom=dennis.dalessandro@intel.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593921759797565624?=
X-GMAIL-MSGID: =?utf-8?q?1593931967887257694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/3/2018 9:07 AM, Julia Lawall wrote:
>> diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
>> index 3990f38..1bd3b32 100644
>> --- a/drivers/infiniband/hw/qib/qib_init.c
>> +++ b/drivers/infiniband/hw/qib/qib_init.c
>> @@ -681,7 +681,6 @@ int qib_init(struct qib_devdata *dd, int reinit)
>>   		if (lastfail) {
>>   			qib_dev_err(dd,
>>   				"failed to allocate kernel ctxt's rcvhdrq and/or egr bufs\n");
>> -			continue;
>>   		}
> 
> Again, the braces should be dropped too.

Thanks Julia, I just noticed the same thing! :)

-Denny

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/2032604b-b25b-e5bf-bea5-3c43a50b8ff7%40intel.com.
For more options, visit https://groups.google.com/d/optout.
