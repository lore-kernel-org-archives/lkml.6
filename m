Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226eFHZy+vhG1JFja1hg5sLC6kdqJe1D+owAnszRaxolb6Hfwg+kDPD4gebV3tRy6pIQPqO3
ARC-Seal: i=1; a=rsa-sha256; t=1519259601; cv=none;
        d=google.com; s=arc-20160816;
        b=s9dYnroRgYZTXRSVzN9SQ5Qfagi7O1UcxCTcUgh5L6XHe7rni75/gm33vBzNRqEl//
         hboziyMSvL1W3JcGoocBW/1YNeq67bLAwdjiwZIcGcJZnvu89+tBq6HNe8aEIBvuuY+V
         qsk8yOudSIX3IKX/yy8+F06Rmd8BukBrQ2qTpJZVu+UYteLO5mdieqXKqtMXBNbj+J1a
         iT6AvMcTaN4z+nqW+EDdeSqHleHj/xFx/ZkLQ/WdLKZH4HHTbNckyxFe4GFETn9Qbfk/
         RHO64wQ8nTIKn/pryAI6t0FbtYYqkChkx2HAvsqGfL2WAZnW/JXsNM+uJMtEnLzDmHlv
         dLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=svf6Av/iTt9w/fNX2f7gkPTv8dlJuQXl1Lro3pdMqi8=;
        b=TgPne+DZeI1VG+7xXfXYTiuXmYrl9lBrsCIwKKCCeViDncbHulYmPC7d29V/GG2Bi4
         5BtsdDCLGsCWfA/GmJPfRCjLl1uOZCjhIB1/kPYfioku6Z8jKx04a+ErJY4G/49rDWoc
         qKFNuoK5BLtn0JLP1+qJV8EQvM65FIurKG3WlqlZJtkvMd5mOomcnCZq5GKP0+5UBbDz
         Klw13Du9oIPevrYZtqv3aPltYEeHS9l+vt35hZelJNn/wiSP6EozXUXyaf7ZhVfl+NYo
         6eAWlRHQ20lQAZ7+bJhOM+Q5sUcLqAUBPVl+5VXlyj/lOENHHenepHygmUtG+5E/zP60
         Ktsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBVAdU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 19:33:20 -0500
Received: from www62.your-server.de ([213.133.104.62]:54174 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBVAdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 19:33:20 -0500
Subject: Re: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
To: shuah@kernel.org, David Miller <davem@davemloft.net>,
        anders.roxell@linaro.org
Cc: ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180221213001.18682-1-anders.roxell@linaro.org>
 <20180221.174830.160781272671654190.davem@davemloft.net>
 <89896e14-e4ad-bb3d-2d9f-44cfa084a8cd@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <54b323b8-6ada-a1d4-c347-9dec15923a92@iogearbox.net>
Date: Thu, 22 Feb 2018 01:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <89896e14-e4ad-bb3d-2d9f-44cfa084a8cd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593059155653885598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Shuah,

On 02/22/2018 12:03 AM, Shuah Khan wrote:
> On 02/21/2018 03:48 PM, David Miller wrote:
>> From: Anders Roxell <anders.roxell@linaro.org>
>> Date: Wed, 21 Feb 2018 22:30:01 +0100
>>
>>> bpf builds a test program for loading BPF ELF files. Add the executable
>>> to the .gitignore list.
>>>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Thanks. I will pull this in for 4.16-rc

I would have taken this into bpf tree, but fair enough. This one
in particular doesn't cause any conflicts right now, so feel free
to pick it up then. But usual paths are via bpf / bpf-next as we
otherwise would run into real ugly merge conflicts.

Thanks,
Daniel
