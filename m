Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225nyJ9ybLz86F9f/RusNBPYXP+UXbOsKK69+ICgnNB9K11RGFQDVVzLWq06k9YmozadkP+K
ARC-Seal: i=1; a=rsa-sha256; t=1519254195; cv=none;
        d=google.com; s=arc-20160816;
        b=N8OAn890zm/lFJdS3GgcwJPb/22epg40FElUIF2ZYpefcQFQkqQEM4bqWsv0P7smSf
         o/pmNtAjsJrv3+w39p81NnmWA2Mg1EcRBKQjFL1wOdMoow768vZV/d/gVFGz0sAbtukA
         5e5BCZLXtvxz9w1nBtgW6Rh7Zr2OO3j1K7hdwVn/5hFruvqmWIQO6TzqRP+Qffzp6kXI
         8V9RHAvIplmFr8H+SuNgaLeTczvZdpNW9g24wN6MmlNOtMR7J2/VeKQaNGi7tqC/AhVD
         02ImiaGp8fUlKcV3KGejICFfU2YEsXkbXHUwr+Xa9brZIY2NyiM2tkPZcR3RZbcojqWt
         spBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=UUFQaFeihSk2GDarUR4k9Hvq1HVqcoXx6tRISqsFJxE=;
        b=m93Gl4b1hYZUZnxqG7Jtkjb4+423x5q2+r3YFf4DRDngvYP3ef7VNOv6lqy8zZkDZc
         yIrY1AerVMPT8pLCfKVdwkvsqeAMZWxq+jLkZ8UyKik3RPBDFuGhF4KqaRs2ncarYGpd
         KkQ9cNWMs71FV3NRIdr1bRM0KXSulXf5b1vgasDvtgFdXImq+/J4ivTm2ULBtzZvn9j9
         8cMrCxZjWv+YJ/xa5SopMg8oXTipFJXn995NLP1Kjkbly5hWePvZm16ny2DDVqIZeuZv
         7Ioam9z5RFuOhVltp2SFuzunRbSQg56u0LdIbfobsi1CX0pORJPsUIP0JHyiRZ+d8v3M
         NedQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbeBUXDP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 18:03:15 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:45273 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 18:03:14 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
To: David Miller <davem@davemloft.net>, anders.roxell@linaro.org
Cc: daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180221213001.18682-1-anders.roxell@linaro.org>
 <20180221.174830.160781272671654190.davem@davemloft.net>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <89896e14-e4ad-bb3d-2d9f-44cfa084a8cd@kernel.org>
Date: Wed, 21 Feb 2018 16:03:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221.174830.160781272671654190.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593053487496744882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 03:48 PM, David Miller wrote:
> From: Anders Roxell <anders.roxell@linaro.org>
> Date: Wed, 21 Feb 2018 22:30:01 +0100
> 
>> bpf builds a test program for loading BPF ELF files. Add the executable
>> to the .gitignore list.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> 
> 

Thanks. I will pull this in for 4.16-rc

-- Shuah
