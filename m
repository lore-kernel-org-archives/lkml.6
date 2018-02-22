Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227MCjgWtjixLYKduwYNtqPOORjKO2mdPlXXLDzNvNU0AZbNrsEkvE+xpqi1e5UQok3F7x2/
ARC-Seal: i=1; a=rsa-sha256; t=1519259838; cv=none;
        d=google.com; s=arc-20160816;
        b=DUs7oZaOtFwBJM21Q+RqlHQlr47dTnBcpQmK49ywGCPMraJhgYRq7OzzDpXuihSRrC
         PPxoQxgz/d+z/mID8xQjx1UgRHh4q8M5XnWXS15I3QDUbKCV9LhcYQvXt8mnECycVYYn
         01DyeS6Tpm5z9FKVuAmwLgun+OjRW8Y4xqvODq+zji5w9bpnk2q2++hanI9kRO86gUCy
         hbRec8RQr/+NSpAvwOjzX9nOy1SC7LemlTr+gVtIEmuse7moR2Nz7HBCV6Jm0Uc4TlTK
         9ITX3nCDTZ6CMFKLAnboV4DEqGPzE6Q0vW0M76oMtPTHPCFT2vQ4tmAuY6GiioA0l2dZ
         DvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=bEcY0LMVmn2JG1sbqFbAtzdfZsBeNzrPU1BdQS6p0yw=;
        b=0UkQRcR6bQ3vPdTS7s5QYbyuNg+zaGS3mXOvxFxbCT5PaDH8LFlse3EJuvHr2r4mN2
         r1Za2KwHNXYFwgk1hyaDS2slklidErW0/ZTclFxUHdt5camwZMwOReP6wNQAUo7PoY4H
         gdxHq8+ePoWoSDEKfdVi6AqvExpa9qw7kS1HiFMGMr+qrHkeeTYzE+kiY2hI+pOiHpPZ
         nBou9vuEsn7lcOQhq9XRRCFvGSw1EHMErkahPHKyVblktgSZpgUEiPVBD4o6rlGTUT9+
         9oIbh+csuKD7YSpcAM1kNWB2wN5WextBYNUZg1VnV60aqmUhXrVvjgx8F/Qk0gCf/gYz
         gROw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeBVAhS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 19:37:18 -0500
Received: from osg.samsung.com ([64.30.133.232]:39036 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeBVAhR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 19:37:17 -0500
Subject: Re: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
To: Daniel Borkmann <daniel@iogearbox.net>, shuah@kernel.org,
        David Miller <davem@davemloft.net>, anders.roxell@linaro.org
Cc: ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180221213001.18682-1-anders.roxell@linaro.org>
 <20180221.174830.160781272671654190.davem@davemloft.net>
 <89896e14-e4ad-bb3d-2d9f-44cfa084a8cd@kernel.org>
 <54b323b8-6ada-a1d4-c347-9dec15923a92@iogearbox.net>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <06743ec3-071d-6465-acad-9966ce72fc57@osg.samsung.com>
Date: Wed, 21 Feb 2018 17:37:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <54b323b8-6ada-a1d4-c347-9dec15923a92@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593059404543578386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:33 PM, Daniel Borkmann wrote:
> Hi Shuah,
> 
> On 02/22/2018 12:03 AM, Shuah Khan wrote:
>> On 02/21/2018 03:48 PM, David Miller wrote:
>>> From: Anders Roxell <anders.roxell@linaro.org>
>>> Date: Wed, 21 Feb 2018 22:30:01 +0100
>>>
>>>> bpf builds a test program for loading BPF ELF files. Add the executable
>>>> to the .gitignore list.
>>>>
>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>
>>> Acked-by: David S. Miller <davem@davemloft.net>
>>
>> Thanks. I will pull this in for 4.16-rc
> 
> I would have taken this into bpf tree, but fair enough. This one
> in particular doesn't cause any conflicts right now, so feel free
> to pick it up then. But usual paths are via bpf / bpf-next as we
> otherwise would run into real ugly merge conflicts.
> 

Daniel,

Go for it. I know bpf tree stuff causes conflicts. That is why I usually
stay away from bpfs selftests and let you handle them.

You are taking the other one away, pick this up as well.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah

