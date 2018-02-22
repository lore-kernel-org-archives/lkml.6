Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2253XAfd7rpocLkN26ktpfVev83nuQDRzg79YkiQQ+JDY3ypKpRYzesDNLxL67UVqFsdOZQR
ARC-Seal: i=1; a=rsa-sha256; t=1519260248; cv=none;
        d=google.com; s=arc-20160816;
        b=FPwqWf7rDWxfYgnpIhG7JFUxZ+qNHNksCZh9vTCBKQA2C09nPNAiAUap2afGvMElli
         NmD9VTfFJMoPm7H538e72WEaFPVDTRUheOltx+XOkR4fJP44faPf97Dyqh/0vyIc8Puf
         3lt75eZTr49GwcvP1HKCc446Dym3sqfFrSJgCCh/xOlbOBp6vAj0C0b3U4bgfDCUHXor
         27CtqYaY2ow4vpPB3+mJC9jX80T9k1uWdRh9OUnGNcX705Mne2u5nn3QkEBsWToid45t
         0pOTUvgz8/bGHpQ26cG2EKI7IjIq32IK0TNZEw33C7ElC1Xln8YO3aoDmkA8+vtT6/B7
         dwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=Y/GSbWA+16+ocCc4er/NRYg5t2RTbRQHaiO5C56/gok=;
        b=J/PG8InVmaDjUVRRy45kBo4r/rZUgqfDNc5FGMgwD6xWFa8c3440a7VUrsyXkM6n4u
         gOJHWgw+58rKonFF4v2Gk8xwlAf3e2zJyBg2N8+wZAv69Sv3+zI5FyDajNXZEHBsw+fq
         YndD2zFOKpvqL2ePjFcRV8XtPz5ueUrah55fbhuQ2T4/Qkh/WFZ4N00fLXLw6lojTmuU
         SbrPzG13xY7fIvz4zvEx1cxAGXY+jaEj3QBnWKvC5nLvhSDd8zlZRRCleRaaej6J9880
         DcgIJ8ayGf4tRl5QsmlFtSL/1RbPPmwwY+XI94zC4qAfaV2Lmnt3LqgTlrV/MpFrN8Ki
         IAuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBVAoH (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 19:44:07 -0500
Received: from www62.your-server.de ([213.133.104.62]:55150 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBVAoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 19:44:07 -0500
Subject: Re: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
To: Shuah Khan <shuahkh@osg.samsung.com>, shuah@kernel.org,
        David Miller <davem@davemloft.net>, anders.roxell@linaro.org
Cc: ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20180221213001.18682-1-anders.roxell@linaro.org>
 <20180221.174830.160781272671654190.davem@davemloft.net>
 <89896e14-e4ad-bb3d-2d9f-44cfa084a8cd@kernel.org>
 <54b323b8-6ada-a1d4-c347-9dec15923a92@iogearbox.net>
 <06743ec3-071d-6465-acad-9966ce72fc57@osg.samsung.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <de1b371c-52c7-3efd-f1fe-789b6cfa0085@iogearbox.net>
Date: Thu, 22 Feb 2018 01:44:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <06743ec3-071d-6465-acad-9966ce72fc57@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593059833895268237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/22/2018 01:37 AM, Shuah Khan wrote:
> On 02/21/2018 05:33 PM, Daniel Borkmann wrote:
>> Hi Shuah,
>>
>> On 02/22/2018 12:03 AM, Shuah Khan wrote:
>>> On 02/21/2018 03:48 PM, David Miller wrote:
>>>> From: Anders Roxell <anders.roxell@linaro.org>
>>>> Date: Wed, 21 Feb 2018 22:30:01 +0100
>>>>
>>>>> bpf builds a test program for loading BPF ELF files. Add the executable
>>>>> to the .gitignore list.
>>>>>
>>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>>
>>>> Acked-by: David S. Miller <davem@davemloft.net>
>>>
>>> Thanks. I will pull this in for 4.16-rc
>>
>> I would have taken this into bpf tree, but fair enough. This one
>> in particular doesn't cause any conflicts right now, so feel free
>> to pick it up then. But usual paths are via bpf / bpf-next as we
>> otherwise would run into real ugly merge conflicts.
> 
> Daniel,
> 
> Go for it. I know bpf tree stuff causes conflicts. That is why I usually
> stay away from bpfs selftests and let you handle them.
> 
> You are taking the other one away, pick this up as well.

Okay, great, thanks for your understanding, Shuah. Just applied
to bpf tree.

> Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
> 
> thanks,
> -- Shuah
> 

