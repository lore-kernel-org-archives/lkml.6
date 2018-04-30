Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZo+zGkqZLvA2/rI1+7MhR3pyhK6mn11ZBJEzNCs6JLrqk40TIPVULJGIGRn9e8nkYmoHHuF
ARC-Seal: i=1; a=rsa-sha256; t=1525103215; cv=none;
        d=google.com; s=arc-20160816;
        b=gm4bVjRXi/M2+8w4jxxGeMpliGo+l2O/k//vBhKhoEE1+EoO1Q/kEJSxtsAcUFp3Jn
         Mzwvjezk12XqYoSr2X/7wSIOVpeZpig7rpqsMK3awzTcwpJK45B9l1GE6729/6RdBG0f
         p2p00Z2EljnVq0asUlJRBVihJDPcRyFgSSmNNlBVHbPlnp/F4NKPylQ6K7x/gpdqP9MJ
         nkZk/kk+WiQj/3+Beek3EPNmugsGsDDCbu8PehERFPZXznxxOK6U/WKIRf1otsRSgIGX
         g++TgNAOKyXgbWBJ0T1/PBpqviPhEbnGhoPM7ktMCEVFZWE8NZi6Op2vzGpZ4EGM+FTE
         dfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=0ArsHgaT6/ogSMfGuGh6xmp5hVSL/O9cQq2dsokhX5M=;
        b=oTP2CGIOuh+ungUPEvoQrJsHll9nWEaomEItIMcitd+Hbl56pqzJ2GV7Z7xfu6k0Bn
         l1qnjrzXKltMCtKx548SFi9Cc0Q/6AYeREh+RDFnz+KR0ucnkBdXiWsKqFv47Q8Kfldx
         XeOOyKikgfZ6nRD/ee3MKuhcDI7rE4bUDlv1C1N6KRA+YEqw8kG5G6ZazLZSzAdFW6ls
         Tq3DPQx6oMi9v/djV0appA7z46iDTJHO8BduaOVvNRxWsiEepk8CqgaAIgRc+IvO0DFd
         5RYHgOK+L2CZH5XVg064T0x6M7w6KGEL9ELkoMN4OoZzMaeXKvb8V5PMRsxYtvDf+PXD
         QiYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=J0pnkIPP;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=J0pnkIPP;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeD3Pqy (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 30 Apr 2018 11:46:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753582AbeD3Pqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Apr 2018 11:46:54 -0400
Subject: Re: kselftest archives etc.
To: Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz_Rodr=c3=adguez?=
        <daniel.diaz@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, fweimer@redhat.com
References: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
 <CAEUSe79+t1D4XUaaVi6vfEvDA=pMkGqag+_GyC32WcEbTXamBA@mail.gmail.com>
 <5a8ec357-bd08-9ae0-3ed5-aefa825e79f5@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc234870-ad35-61fd-0974-c04a417a76a3@infradead.org>
Date: Mon, 30 Apr 2018 08:46:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5a8ec357-bd08-9ae0-3ed5-aefa825e79f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946970016814291?=
X-GMAIL-MSGID: =?utf-8?q?1599186628920345868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 07:10 AM, Shuah Khan wrote:
> On 04/27/2018 09:02 PM, Daniel Díaz Rodríguez wrote:
>> Hello!
>>
>>
>> On 27 April 2018 at 19:17, Randy Dunlap <rdunlap@infradead.org> wrote:
>> [...]
>>> so I looked for an archive of linux-kselftest@vger.kernel.org.
>>> http://vger.kernel.org/vger-lists.html lists all mailing lists and
>>> (some of) their archives, but none for linux-kselftest.
> 
> Yes. It have been meaning to request a archival for it. I will send email
> to Dave M.

vger doesn't do archives, but vger.kernel.org will tell people where to find
them if we can get Dave M. to edit that web page.

>>
>> For what it's worth, as of last November Linaro is also hosting a
>> mirror of this mailing list:
>>   https://lists.linaro.org/pipermail/linux-kselftest-mirror/
>>
> 
> Nice. I didn't know.

vger.kernel.org could (should) list both of these archives for kselftest.

thanks,
-- 
~Randy
