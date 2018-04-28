Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeD1VyX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 17:54:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeD1VyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 17:54:22 -0400
Subject: Re: PROBLEM: error due to conflicting types during build of
 kselftests
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
References: <CAG=yYwnMXFxHxCnYNWCb-HhpAb21kc5_e_6q-N_DRGhMVurPMQ@mail.gmail.com>
 <bd125268-a685-ba6e-efc4-130a0621855f@infradead.org>
 <CAG=yYwnq1KwAmKL5t=KFTMcRY9rDFM_5XBDNpbvzM-8J-U7TKQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <49022295-d118-4aa7-c750-36f36b6b6821@infradead.org>
Date: Sat, 28 Apr 2018 14:54:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAG=yYwnq1KwAmKL5t=KFTMcRY9rDFM_5XBDNpbvzM-8J-U7TKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 02:42 PM, Jeffrin Thalakkottoor wrote:
> anyway my current is gcc (Debian 7.3.0-16) 7.3.0
> 
> may be you can try ... make -C tools/testing/selftests 2> error.txt

I have a much older gcc, so newer must be better.  :)


> On Sat, Apr 28, 2018 at 5:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 04/20/2018 11:03 AM, Jeffrin Thalakkottoor wrote:
>>> hello,
>>>
>>> the following is the error found...
>>> -----------------------------------------------------------------------------------
>>> protection_keys.c:421:5: error: conflicting types for ‘pkey_set’
>>>  int pkey_set(int pkey, unsigned long rights, unsigned long flags)
>>>      ^~~~~~~~
>>> ------------------------------------------------------------------------------------
>>>
>>> to reproduce this error...
>>> make -C tools/testing/selftests
>>
>> Hi,
>>
>> I can't reproduce this problem.  What is your gcc --version?
>>
>> Thanks.
>>
>>> Details about software:
>>>
>>> Linux debian 4.17.0-rc1+ #1 SMP Thu Apr 19 18:59:45 IST 2018 x86_64 GNU/Linux
>>>
>>> GNU Make             4.2.1
>>> Binutils             2.30
>>> Util-linux           2.31.1
>>> Mount                2.31.1
>>> Linux C Library      2.27
>>> Dynamic linker (ldd) 2.27
>>> readlink: missing operand
>>> Try 'readlink --help' for more information.
>>> Procps               3.3.14
>>> Kbd                  2.0.4
>>> Console-tools        2.0.4
>>> Sh-utils             8.28
>>> Udev                 238


-- 
~Randy
