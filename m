Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934002AbeEWSkT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:40:19 -0400
Received: from mout.web.de ([217.72.192.78]:44069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933291AbeEWSkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:40:18 -0400
Subject: =?UTF-8?B?UmU6IFN1Z2dlc3Rpb246IOKAnnNwZWN0cmVfdjI9b2Zm4oCcIGFuZCA=?=
 =?UTF-8?Q?=e2=80=9enopti=e2=80=9c_per_default_in_=22Intel_Atom_N270=22_case?=
 =?UTF-8?Q?=3f?=
To: linux-kernel@vger.kernel.org
References: <72a7122d-0020-f307-a76d-bb80a2c19842@web.de>
 <20180523105302.GE15312@amd> <20180523170706.GA21118@probook>
From: =?UTF-8?Q?Christian_Kr=c3=bcger?= <C.Krueger.B@web.de>
Message-ID: <476a4c02-592f-ddf9-d550-c81be74ce931@web.de>
Date: Wed, 23 May 2018 20:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523170706.GA21118@probook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-LU
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ftk22eKySTAJLFYHAK+VD5MbMVjBNxNZu1pmcsikvkZF/iRcwbn
 3APMCmVRtGSJE19N9LUCMR73wVBfAQb2bYqbrPsLfn0J1h4VGjXJj7wjXAMFgEDWP1sarW9
 VmDSZoxxK304/F422BsF/ttlVEIu20LS5vC8QCL03nZWjMxJT9uuQsTB71ewVoBJh1jRHdq
 2VTYP/jeU/n/092mndvNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BfxKNHsfDhQ=:3WYoA+KHbt3P2Bfuv6oTnb
 BirJnaDIQE/gEdsf65zf5izC+vli9hSspOqQKm9PujywwkLzHXU5E77nHRCeHPse8Bs2ynij9
 DE/XBudYHN5D1mXs8DoOAdu2p4Qe14CLY4eelL7aKxrpmiTVoP1JFw6mTLu5jCcH/gx9HK1hB
 O1TpPErtgek+iZ0crtw5jsZMsU/fMwUuuiBsLpGYpm/CnqUiyQPm9ZzlhtHgrsREMY5oVIrDB
 tLT/zSoCgctLz5aNBWBylrKTybaRtLj6pPr1UNUs4fznkDXXaVjtewxH2pnks/qg+y9qQ0+sC
 Qjyo5XZ05u+X9cTFcyD3b4ApdrYf64NYSOI4Sdd6KK9aZJ/jEAjZ5BvouAm3k84Qjhj5/Ubju
 6C3horHET+sEEUGnOqhIAzw8NaQbTYa1JQlcc66TRlbsnfSfFduttVAYm+OLF5oIDOi4FXuyv
 D0kOBZp9EKHyyXEY8xYQpThrj+/o/P8zH9KGfzF2hmF1g4u84oqkRkRFaV1KbR1R4ttD8idcy
 0w6ThMeg/WmeH18WvmFGVFAgE+S/+T5wb6f85MZK0d6U2uHd4iGmM/NJbKhprS5mrkLHOcFyu
 juhCPHU4CBMUJLnQ0NpHIE1solCEuyF3DTUnsckbusvgBMZLgN4PW3HM0Io2UY8Nssn3l9X8K
 yv+Gw6x5n+EexI6W1cvn6j4R0EGu21CAxAO8wnk8gUDsFnarfj5UadInLDgAgRC4M/ijelk+G
 g867wxZYRo3U8MI2v95jkL45h8HEY2OuiO7kTmpQTcOvHac2XueL+MOsYqsNezIsOdd8DfPrw
 hpKgo8y
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.05.2018 um 19:07 schrieb Johannes Hirte:
> On 2018 Mai 23, Pavel Machek wrote:
>> On Sat 2018-05-19 21:53:02, Christian Krüger wrote:
>>> Hi,
>>>
>>> Since the old "in-order-execution" Intel CPUs like the Intel Atom N270
>>> (known for being installed in many Netbooks and Nettops) are not sensitive
>>> for "Meltdown" & "Spectre" , wouldn't it be a good idea to exclude these
>>> anyway "weak" CPUs from the costly patches by default?
>>>
>>> Browsing the web, I can "feel the difference" if the matching kernel options
>>> are applied on such a device.
>>
>> Can you also measure the difference? Placebo effect is hard to avoid.
>>
>> But yes, we do not need to do workarounds on non-buggy machines...
>>
>> 								Pavel
> 
> On my Atom N270 there doesn't seem to be any workaround active with
> kernel 4.14.42:
> 
> localhost ~ # cat /sys/devices/system/cpu/vulnerabilities/*
> Not affected
> Not affected
> Not affected
> 
> Christian, did you verified the mitigations are active on your system?
> What kernels are affected?
> 


$ uname -a
Linux user-device 3.13.0-143-generic #192-Ubuntu SMP Tue Feb 27 10:46:44 
UTC 2018 i686 i686 i686 GNU/Linux

$ cat /sys/devices/system/cpu/vulnerabilities/*
Vulnerable
Mittigation: OSB (observable speculation barrier, Intel v6)
Mittigation: Full generic repoline

OK, so I've updated the OS on my (usually off-line) Netbook:

$ uname -a
Linux user-device 3.13.0-149-generic #199-Ubuntu SMP Thu May 17 10:12:57 
UTC 2018 i686 i686 i686 GNU/Linux

$ cat /sys/devices/system/cpu/vulnerabilities/*
Not affected
Not affected
Not affected
Not affected

Conclusion:
Don't bother others before not checking the latest version. (Actually 
this is the first time it made a difference... ).

Sorry for the noise and thanks for listening and all the great work!
Christian
