Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+Tz7i6G5XCMTfhzN3Oz9b7oEf8whBwMarHy39asQrw/hgLZV6sfaV6SW8fkFcZCfrT8cvU
ARC-Seal: i=1; a=rsa-sha256; t=1524128177; cv=none;
        d=google.com; s=arc-20160816;
        b=ysMVq+G2vIapHwIqNLVSIlHpblkcBOFq+yy6YbNjoidJ1lSoKSJZWosGQA60MhcePX
         GLLO4vNfon/EOM/LkVIz/WFeJGGAKHlbDPnN0z9o5ztWMi8YFrNxxHnKnuaw+Ejk9yYO
         80Cq8ayZs/pe3F5XotbX61XVPm2zmUpFy3I5JEKbt6lpjS+wbCLgftI3lIR4jNL6WDlM
         ZOKYjezJkz4FBlHHN0imNv0adztSw7cTZb5+SY9wYMqgB9X9FX3HXjH5ONpoC3CzsX2g
         ZrQlt76Kf4SR22ijNXes785HdJtn097fvul5L12dY0hpZpplQ0n+4uF3ag0MsNbzvVuu
         NH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=zeeUAWy/6bGCPaxgBXDEMLxkeljB0Z2XpWwoHKOtNx0=;
        b=FUmgHLNOmp7CD4UoleqxI5kfFAAAfj8d31vy7ZBcY96Fdw2QqzHUieKiz1xXGwYUNi
         mKWOg6z8tsTfXNtnAXhBoLIkZmhq3ZMJ/0YnF38AUs6ZV+QgOIRoZCB6MPj2gCoqNgws
         /YAjSdARgW8P2jyDAdJ2sWjAgaBh2jGpHV/awOHUNpksNmx/G0yYxXVaJpKjpeSPAmVt
         ZYguw9mEEa/aNZjL0P92zHaDcSHmutPA6udqLCkzp/mfLzQp71X6iwn5eq/26aV+NOns
         3NqdEqc7bKtSN/84RjfuYaHo9cPfMbqI2TpbDsfzgup2tpVyhkFRrw2chvCB+RKV8A5A
         pc/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=MiLkspbH;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=MiLkspbH;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751046AbeDSI4Q (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 19 Apr 2018 04:56:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35177 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDSI4P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Apr 2018 04:56:15 -0400
MIME-Version: 1.0
In-Reply-To: <CADYN=9Lw0S8yhnRn3u+0A8Cc3R91V=3PBytU1c+Ns3TNPdB1xw@mail.gmail.com>
References: <20180418075256.300-1-anders.roxell@linaro.org>
 <20180418075256.300-2-anders.roxell@linaro.org> <21de28f0-41c2-feac-1fec-63a2d76a2398@kernel.org>
 <CADYN=9Lw0S8yhnRn3u+0A8Cc3R91V=3PBytU1c+Ns3TNPdB1xw@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 19 Apr 2018 10:56:13 +0200
Message-ID: <CADYN=9+B=wwCuZSr24e_W8+tJvWUFZZSFP7Zy73e1DV7np2fEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/filesystems: remove Makefile warning
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuahkh@osg.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598069678446839048?=
X-GMAIL-MSGID: =?utf-8?q?1598164227823556176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19 April 2018 at 10:22, Anders Roxell <anders.roxell@linaro.org> wrote:
> On 18 April 2018 at 16:54, Shuah Khan <shuah@kernel.org> wrote:
>> On 04/18/2018 01:52 AM, Anders Roxell wrote:
>>> When overriding the 'clean' target make throws up warnings:
>>> Makefile:9: warning: overriding recipe for target 'clean'
>>> ../lib.mk:98: warning: ignoring old recipe for target 'clean'
>>>
>>> In current code we change from TEST_PROGS to TEST_GEN_PROGS and that
>>> does that we can remove the target 'clean' and 'all'.
>>>
>>> Fixes: 10924bc64487 ("selftests: move dnotify_test from Documentation/filesystems")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>  tools/testing/selftests/filesystems/Makefile | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
>>> index 427a401aae5c..a55ac3ac09ad 100644
>>> --- a/tools/testing/selftests/filesystems/Makefile
>>> +++ b/tools/testing/selftests/filesystems/Makefile
>>> @@ -1,9 +1,5 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>> -TEST_PROGS := dnotify_test devpts_pts
>>> +TEST_GEN_PROGS := dnotify_test devpts_pts
>>>  CFLAGS += -I../../../../usr/include/
>>> -all: $(TEST_PROGS)
>>>
>>>  include ../lib.mk
>>> -
>>> -clean:
>>> -     rm -fr $(TEST_PROGS)
>>>
>>
>> Hi Anders,
>>
>> Michael sent in a patch to fix the problem already. It is in linux-kselftest fixes
>> branch for 4.17-rc2
>>
>> Classifying dnotify_test to TEST_GEN_PROGS_EXTENDED as Michael is the correct way
>> to handle this problem. It allows the test to be built and installed and it won't
>> be run in the main kselftest run.
>
> Why don't we want to run them in the main kselftest run?
> Is the rationale documented somewhere/somehow?

Think I found the rationale documented in the changelog [1].

What do you think about adding a variable to this test saying run for
xx minutes and if it hasn't
crashed, consider it as a passed test ?

Cheers,
Anders
[1] https://patchwork.kernel.org/patch/10332365/

> If they are long running tests or intrusive tests, can we document
> with a printout like:
> === Test ${foo} - SKIPPED (${short_rationale}) ===
> === Test dnotify_test - SKIPPED (long run) ===
> === Test devpts_pts - SKIPPED (intrusive run) ===
>
> Should there be a variable to turn them on from the main kselftest run?
>
> Cheers,
> Anders
>
>>
>> thanks,
>> -- Shuah
