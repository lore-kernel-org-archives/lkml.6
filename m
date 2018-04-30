Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZq/5XnUjPEtM2MEgTjIGl5epxxnQR3qmW/1+z9ixkp8rzaxZe/MA9wwyXFdygdjWRVRFSON
ARC-Seal: i=1; a=rsa-sha256; t=1525097412; cv=none;
        d=google.com; s=arc-20160816;
        b=RpkPmuGt6Si2Ziy3QeCKsjpZxrM9mPcXOX12ME9d5ozK2GYFlar+3v3CknGo7OadVY
         Wtu7YDbiYPYCMe4TA9krrg2Wxwd1ixI8P/buu3U8VctZyK4r2RQ+upMJDNLA0kmZjWSf
         Z6Bemdv5jNWqhPYvKyXLCHandk7W/3y8uH8H86Ox8YZa9ez1ajDlN9TyTVYUVS+CSvo4
         sj11xrHsgWeMuOY6hn2MUDiEUjfLt5xN1I6568CzbDe7fyXMdk18YKEy5KvsElMJuCad
         TCIuN/ApmY/LZQtgockbTNZ51yVHYBiknhgcompRrZuxgV3EJ8moqp28M38yK1v4J0Tf
         pG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=gRPoAMI7UJvYStTQTn6U1cUEdAdAr/OC9mQMEeCntB0=;
        b=M7Ibx9B6s3Q5l3LDSWf8fPFYOIRkb6nJXYc6ery3w48s7Nhste3jkTAeP4ST2ucbpq
         TPTpIUprmJa4ywvuP2JwyUxaIfXBPgua/+L9THdS2kTOfVzRYteoEdOTWqqvrxGocjHK
         GfM+vseyWOcgtepU1kF30jPF9qtSU858UQ0dwMre8uMzEbD758u/iMSpZ06Dov/Gns+b
         YHp0H1g0eqiJPO2kHxuqkFYMvcsSrmZf2qYIMP6n4WsR7tFZsG6yfDc5CgcZBE+VIVPT
         qEIGQz6O8/qKbZ6NYWfRpe0CqkkpISkrc2pZ6DQ70xwI3DFPnu4fW9TIZfktOuIWyBbQ
         hPSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeD3OKM (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 30 Apr 2018 10:10:12 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48575 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeD3OKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Apr 2018 10:10:11 -0400
Subject: Re: kselftest archives etc.
To: =?UTF-8?Q?Daniel_D=c3=adaz_Rodr=c3=adguez?=
        <daniel.diaz@linaro.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, fweimer@redhat.com,
        Shuah Khan <shuah@kernel.org>
References: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
 <CAEUSe79+t1D4XUaaVi6vfEvDA=pMkGqag+_GyC32WcEbTXamBA@mail.gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <5a8ec357-bd08-9ae0-3ed5-aefa825e79f5@kernel.org>
Date: Mon, 30 Apr 2018 08:10:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEUSe79+t1D4XUaaVi6vfEvDA=pMkGqag+_GyC32WcEbTXamBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946970016814291?=
X-GMAIL-MSGID: =?utf-8?q?1599180544770438750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 09:02 PM, Daniel Díaz Rodríguez wrote:
> Hello!
> 
> 
> On 27 April 2018 at 19:17, Randy Dunlap <rdunlap@infradead.org> wrote:
> [...]
>> so I looked for an archive of linux-kselftest@vger.kernel.org.
>> http://vger.kernel.org/vger-lists.html lists all mailing lists and
>> (some of) their archives, but none for linux-kselftest.

Yes. It have been meaning to request a archival for it. I will send email
to Dave M.

> 
> For what it's worth, as of last November Linaro is also hosting a
> mirror of this mailing list:
>   https://lists.linaro.org/pipermail/linux-kselftest-mirror/
> 

Nice. I didn't know.

thanks,
-- Shuah

