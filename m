Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225NC11JYPS8Y4RPZzU7QVmDdbCvb81UfRKN4wfPHUpoMM//7fzdEx81xMxcBWLw6zt62oiM
ARC-Seal: i=1; a=rsa-sha256; t=1519254709; cv=none;
        d=google.com; s=arc-20160816;
        b=vzffToRX9O+MWvbB9UqIcUvclM1vC6wEPqRJTGuiYRXcMyQcKSMNxk3nXX3/jyyKII
         8P4h0ZSVIcYXzOvD7coSQe6ezrVR5eoZ9GVDjRegVUnLVHa6nTpYpTeqy+7budXwx7wP
         5gveZQcojfqRWY4/G3wEENYoBElNmBhLDHTm7HyMpnl9EilAY3DxODSLlvcplLfy/StJ
         K9wYxrzP9yAhfHgD/ChJ7nbTnN5ifG7+MirPEXFeQTcWRnxW5hinlxS5zhG3fDSuhHvu
         dn0ZUozhualZLqWSo6JtUHGYteJy1MdF0HQ6tRPEmAX7EQc6g0DtRwknzIBzGMjZ+5SQ
         RhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=4WeJz9TUvJLyGPianMcV/+/1I89anjgpXQjFRA0Oxv0=;
        b=uIAKuviAgPuqEYKgy6Cb6jYqdm+H9pVKsr2YPP1174pbBQopSvfJiuMt6xhn8kqTqW
         YZmD76H0LBUp+54wboefuVwS4etmDnlLdZXeRgL8npkiDJ7DcNUx1QYvB/TYGLyt8VKz
         tHJiJApgss9FUGbWdaeVnWkAjOPzWfspNvauwPaTAH7IvvBx8zgeq/7LLGzy7N+zZCkp
         NCUOFcd5fd1hkuykBZtA3UoNl87ahfVCf7di4UMqAe3SRwyUIh/VVov0oufffwuO7M7T
         iwt25qIgUbG+5ROadMV+L+p1GDZ/3/MKy77VFYopRgK33tem6po8H5DbGfcNbCXMYkl1
         Oh0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeBUXLg (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 18:11:36 -0500
Received: from osg.samsung.com ([64.30.133.232]:39178 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbeBUXL3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 18:11:29 -0500
Subject: Re: [PATCH 2/2] selftests/gpio: Fix OUTPUT directory in Makefile
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
Cc: linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
 <1519249964-1630-2-git-send-email-daniel.diaz@linaro.org>
 <CAHp75VdMCaKnqbUPzU2QTxOk6gjyor69w+sVVoaKyjnO+zU=+A@mail.gmail.com>
 <8e7b8d40-99ac-3f4f-a25d-e0df0dd104d5@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <634e5fb7-4f2b-7313-e8f3-17a2eec112ef@osg.samsung.com>
Date: Wed, 21 Feb 2018 16:11:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8e7b8d40-99ac-3f4f-a25d-e0df0dd104d5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049155220283470?=
X-GMAIL-MSGID: =?utf-8?q?1593054026329629311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 04:04 PM, Daniel Díaz wrote:
> Hello!
> 
> 
> On 02/21/2018 04:09 PM, Andy Shevchenko wrote:
>> On Wed, Feb 21, 2018 at 11:52 PM, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>>> When simply running `make' from the selftests top dir, this
>>> error shows up:
>>>
>>>   cc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c ../../../gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
>>>   cc: error: ../../../gpio/gpio-utils.o: No such file or directory
>>>   <builtin>: recipe for target 'gpio-mockup-chardev' failed
>>>   make[1]: *** [gpio-mockup-chardev] Error 1
>>>
>>> because the output directory is set to "selftests/gpio" and
>>> all binaries built from ../../../gpio/ end up there. In fact,
>>> they appear as, exempli gratia:
>>> * gpiogpio-event-mon
>>> * gpiogpio-hammer
>>> * gpioinclude/
>>> * gpiolsgpio
>>> which is wrong, as it's missing directory separator somewhere.
>>>
>>> This patch sets straight the output directory when building
>>> ../../../gpio/ so that binaries don't cross paths.
>>
>> This patch doesn't sound right like previous one.
>> Does selftest infrastructure have it's own build system like tools?
> 
> Yes. See linux/Documentation/dev-tools/kselftest.rst § "Contributing new
> tests (details)" or linux/tools/testing/selftests/lib.mk itself, which
> starts saying:
> # This mimics the top-level Makefile. We do it explicitly here so that this
> # Makefile can operate with or without the kbuild infrastructure.
> 
> 
>> Does it use tools' one?
> 
> No, as far as I can tell. If anything, it uses it only to build inside
> tools/gpio/ whatever is needed.
> 
> 
>> What's wrong with the current approach?
> 
> When building from the tools/testing/selftests/ directory, binaries end
> up in the current directory (and with an improper name), which is
> undesirable. The gpio/ selftest fails to build when make'ing from there.
> 
> This is with current master:
>   /linux/tools/testing/selftests$ make
>   make[1]: Entering directory '/linux/tools/testing/selftests/gpio'
>   [...]
>   gcc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
> gpio-mockup-chardev.c ../../../gpio/gpio-utils.o
> ../../../../usr/include/linux/gpio.h  -lmount -I/usr/include/libmount -o
> gpio-mockup-chardev
>   gcc: error: ../../../gpio/gpio-utils.o: No such file or directory
>   <builtin>: recipe for target 'gpio-mockup-chardev' failed
>   make[1]: *** [gpio-mockup-chardev] Error 1
>   make[1]: Leaving directory '/linux/tools/testing/selftests/gpio'
>   Makefile:32: recipe for target 'all' failed
>   make: *** [all] Error 2
> 
> 
>> Why do you need tools in selftests?
> 
> I'll leave that to the test author to answer, as this is only a fix in
> the Makefile, but the only part of tools needed here is tools/gpio/*,
> for make'ing the object files this test will be built against.
> 

This test depends on tools/libs built in tools/gpio. The original
commit has details on the benefits of adding this test. Adding author
to the thread for further comments.

22f6592b23ef8a0c09283bcb13087340721e1154
commit 22f6592b23ef8a0c09283bcb13087340721e1154
Author: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>

thanks,
-- Shuah
