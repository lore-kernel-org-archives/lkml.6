Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZojAhGIJN2sItg0wmc3wvY/JBbiqE5pZRKctQ9/x1++Rq3j/wy7DAqfjWTJIEezps94EoWc
ARC-Seal: i=1; a=rsa-sha256; t=1524522722; cv=none;
        d=google.com; s=arc-20160816;
        b=ZyPp0hlFLN3fU9UL+FaKy0omCRYGF8WEOdtVMBs6VDAAmZUpPd0e4s5zV6BXbWZzFP
         hSyZcOi34UEI637uHPqBvcxkYw6TAiTUbb5hsz3hEt90K/g5JrX1ibOc028CnPKi2vsM
         R1evWQ6eOWfp5dyYO20kfXiHKaD/+DODwaP7RWAcvgFY+o3+zO12du+sA297lbaf9epu
         7xJ3Ou+xrVIZvR00REF2tZDBob+HGVcv5iia7Bgm3MZ0zo31jmo0bU/XU1Y37+O+ughw
         dVpp8Pifqgh70t0L6+yBmFwzqNVFsJX4/0zX6edgMUduvgUIqOpCzJOHCYDiQZ4MFE1H
         lAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=r5ic4QUv9nueGnJzk3yQvA+l0bGWTH8ao+dJO5xxy9U=;
        b=M/JoIrkzHhMCo3pHwRfvdKkd5Enxvhi6u6ZHZApyiCVdA+C1M6OceE6jYyi/AkCh+i
         c07cskLn4d8Tqty9LdgIzeyPBPJy5yq90tCLOhg7dDL1XoA40wCOis+F2WbDprS/4+/E
         c8hKSqzUVekI7h6q7sHcbQpA15JlfRVFcx4gCycBMgfGfdG/SZVS7u5PkiwOItHAhPP9
         LKL4Gd1K53+cv3z4V7eZfF70qrSSDTOWWHvyko4vaqQUXipzGkeTay9CR+F7ODZb/hzH
         xLNfIHYaH8gdhg2aWpjE81EloGcP3r0D07iJ8Pb3PktBBIM/OTg+ixI/xZwfIolsPnrM
         jchA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbeDWWbp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 18:31:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:49525 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWbp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 18:31:45 -0400
Subject: Re: [PATCH] selftests: bpf: update .gitignore with missing file
To: Anders Roxell <anders.roxell@linaro.org>
Cc: ast@kernel.org, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20180423135057.951-1-anders.roxell@linaro.org>
 <5ea150a6-8af1-3aa8-7ff0-5fdb64054bab@iogearbox.net>
 <CADYN=9KAorrGBh+2_LZ+6cxaf4yU-pOmU4BSzkMKT8sdU7hhUw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <065a8bc2-6065-3d43-8b03-35ed693de7ce@iogearbox.net>
Date: Tue, 24 Apr 2018 00:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9KAorrGBh+2_LZ+6cxaf4yU-pOmU4BSzkMKT8sdU7hhUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545167658218974?=
X-GMAIL-MSGID: =?utf-8?q?1598577937760316639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 12:14 AM, Anders Roxell wrote:
> On 23 April 2018 at 23:34, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 04/23/2018 03:50 PM, Anders Roxell wrote:
>>> Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>  tools/testing/selftests/bpf/.gitignore | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
>>> index 5e1ab2f0eb79..3e3b3ced3f7c 100644
>>> --- a/tools/testing/selftests/bpf/.gitignore
>>> +++ b/tools/testing/selftests/bpf/.gitignore
>>> @@ -15,3 +15,4 @@ test_libbpf_open
>>>  test_sock
>>>  test_sock_addr
>>>  urandom_read
>>> +test_btf
>>
>> Against which tree is this? This doesn't apply to bpf-next. It would
>> apply against bpf tree, but c0fa1b6c3efc ("bpf: btf: Add BTF tests")
>> is part of bpf-next, so fits to neither of them.
> 
> I'm sorry,
> 
> I did it against this patch [1] that I thought was already applied to
> the bpf tree.

That was bpf tree since the original change already went to mainline; the
BTF is in bpf-next however, so you need to rebase your change against that.

Thanks,
Daniel
