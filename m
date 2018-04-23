Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+c/A5xXzEZujJzkWMlLHUVqi4UT0h2+2YbuUose3SH3gOQ7yQsYs8KSLZsLQnDl/hlstPi
ARC-Seal: i=1; a=rsa-sha256; t=1524521694; cv=none;
        d=google.com; s=arc-20160816;
        b=H8AsSjMU6jwUF7boa32tEaR2zNetjnqOqLDT27NEDNzGAz3sBOLQDxmebRrSdqwYA7
         9YN13/+84tw1CEKD9UlxXiL2tHfygSwolCb38/Rj8wR9nd/uY1H3Ubr4R9AI1HT9ggeN
         MOZwZPfT4bDbJGXJLL45a3mPW5thr9Jaf3AxTv8v8AHj5N7tRnx93XAwHvCCwHJ9ZPug
         p+HJa5I4xHpbL0Z7HsmlilqP7TpJaU4HBX5YSJEfE44/nkk/kIPDd89rQli35PG/LvIe
         omABjD2Z5zQaTiodykcUYkXrk5CLr4a5/SPgv7nL07hOCBGIdArhYZ/a9OLFsQ8o/aCr
         PXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=URQ8pkvuPGAKYCnUWmj0NRc2cW1Sd78dsc2CejDDnoU=;
        b=ej6TbcPgGFUpU6mEjLc6jc05hfwj7osKUF0JHAYg0TDDeaMtgDi071M7YAb/nUAt/6
         Ow51zJViqZJC0zabPbmH10AbA9qAtiTXJsF7nVYTWhxJms8bNGmNeIweCTwgP9IFCGam
         y6OyyVYW1O7QXplrMKTPEGzDNxpKNrTP3cwvtSwRNH/csFevK4bvaj6evcGz0+XxpoM7
         I4wC/n2AhAVkfOxkCJMcpRv6fFk1OdfYn3ISYkTXeAQwizreIvrzGER0b+PErdpbiBoU
         gbQcxqW2eZklOnIDe0cz/HrY9OFEaAKO1jsurdXirQohY7PEgN3k8Gj+EVQK46XCO6nO
         z6Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=O+alr0b+;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=O+alr0b+;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeDWWO2 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 18:14:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34897 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeDWWO1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 18:14:27 -0400
MIME-Version: 1.0
In-Reply-To: <5ea150a6-8af1-3aa8-7ff0-5fdb64054bab@iogearbox.net>
References: <20180423135057.951-1-anders.roxell@linaro.org> <5ea150a6-8af1-3aa8-7ff0-5fdb64054bab@iogearbox.net>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 24 Apr 2018 00:14:26 +0200
Message-ID: <CADYN=9KAorrGBh+2_LZ+6cxaf4yU-pOmU4BSzkMKT8sdU7hhUw@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: update .gitignore with missing file
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545167658218974?=
X-GMAIL-MSGID: =?utf-8?q?1598576860259629788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 April 2018 at 23:34, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 04/23/2018 03:50 PM, Anders Roxell wrote:
>> Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>  tools/testing/selftests/bpf/.gitignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
>> index 5e1ab2f0eb79..3e3b3ced3f7c 100644
>> --- a/tools/testing/selftests/bpf/.gitignore
>> +++ b/tools/testing/selftests/bpf/.gitignore
>> @@ -15,3 +15,4 @@ test_libbpf_open
>>  test_sock
>>  test_sock_addr
>>  urandom_read
>> +test_btf
>
> Against which tree is this? This doesn't apply to bpf-next. It would
> apply against bpf tree, but c0fa1b6c3efc ("bpf: btf: Add BTF tests")
> is part of bpf-next, so fits to neither of them.

I'm sorry,

I did it against this patch [1] that I thought was already applied to
the bpf tree.

Cheers,
Anders
[1] https://patchwork.kernel.org/patch/10332907/
