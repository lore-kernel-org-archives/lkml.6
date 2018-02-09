Return-Path: <kernel-hardening-return-11688-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225l6VAx7+S2Qye1wSV3n9egnBsDWmsmAhmJhubVxmP7+icdtYjwkv/Pbr6uT+RQGSvIzkd+
ARC-Seal: i=1; a=rsa-sha256; t=1518194508; cv=none;
        d=google.com; s=arc-20160816;
        b=M4k95eGMrCThF3XpMgHHJfgzuihYg9H2Nqz0PtgNeUpOF3LVxgIzOCeGyDvehlOeoC
         tDwvFfxvZfhw78XYdHbwv+72DUNXfLyJloqCmCSjzbJUx3wWOoR49nZ+pNMpDaiKPK47
         JwrweMQSJlJe13vM4WD4LFjcCiaVDSo41KxlXuKBk/ARcALJD4Vk1cG1kyfkCOXF8MRO
         fBbbQU3um7ikrminpgpy04JRFgoWyUTdm4XM5u/IqBNJucthZuBOiwTZVQaQ0rN5Xl1V
         0M2Wiiit3kCg88pYt1pOJLZ1XIfU3KXm4sZOKo5Nx7ymJTQ7fmoTNkcFs2Avbcpp+Dgn
         Sjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Hp2HFtHiOJIC2AVeO8WxZdwE2GIA0ryoX9kMqZd49rQ=;
        b=z0S6WgbXAkVb22lftdGf1azk2ocRAEJE8ovjUmBSK5UL0Zi/opYJyYSroJedeTInwV
         7BZUBcm2HbekxhdWB1cbD47zi5+ByIOdMWFkQC9Hu6eqYUaXHVUw0P3Pz8rkehPN026I
         hmmuYNGQFeR2sZuWnFJWynIzM1SWBKqLQHleBcEyKAPad3HLpPafTQQ+WSj7yR3YG7oj
         NPdBqBOiMNpA9U0imsNeE1b905PUhc00Ck+aIgcutZCee3c7eIwyxwabfP0XpR5RBUqL
         9AnnkbOGFNgC2LhVGAxr2kO0Y1aSw0RBHj0j/S9PA3fnI9VeFi6Iig2XmqJIXrxts9nU
         8Myg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11688-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11688-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11688-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11688-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/6] Documentation for Pmalloc
To: Randy Dunlap <rdunlap@infradead.org>, <jglisse@redhat.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204170056.28772-1-igor.stoppa@huawei.com>
 <20180204170056.28772-2-igor.stoppa@huawei.com>
 <29176ee0-f253-ccd7-8201-3f061b5890b0@infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <33d85206-abfb-86cf-d303-b7efba9cc325@huawei.com>
Date: Fri, 9 Feb 2018 18:41:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <29176ee0-f253-ccd7-8201-3f061b5890b0@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490610128424562?=
X-GMAIL-MSGID: =?utf-8?q?1591942324943504528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/02/18 23:37, Randy Dunlap wrote:

[...]

>> +reason, could neither be declared as constant, nor it could take advantage
> 
>                                                   nor could it

ok

[...]

>> +Ex: A policy that is loaded from userspace.
> 
> Either
>    Example:
> or
>    E.g.:
> (meaning For example)

ok

[...]

>> +Different kernel idrivers and threads can use different pools, for finer
> 
>                     drivers

:-( ok

[...]

>> +  in use anymore by the requestor, however it will not become avaiable for
> 
>                            requester; however,                   available

ok

[...]

>> +- pmalloc does not provide locking support wrt allocating vs protecting
> 
> Write out "wrt" -> with respect to.

ok

>> +  an individual pool, for performance reason. It is recommended to not
> 
>                                          reasons.                  not to

ok & ok

[...]

>> +  in the case of using directly vmalloc. The exact number depends on size
> 
>                  of using vmalloc directly.                          on the size

ok & ok

[...]

>> +6. write protect the pool
> 
>       write-protect

ok

[...]

>> +7. use in read-only mode the handlers obtained through the allocations
> 
>                                 handles ??

yes

---
thanks, igor
