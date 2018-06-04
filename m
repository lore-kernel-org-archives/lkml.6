Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeFDKCo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:02:44 -0400
Received: from mout1.freenet.de ([195.4.92.91]:39524 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753041AbeFDKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:02:41 -0400
Subject: Re: Spectre mitigation doesn't seem to work at all?!
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
 <20180604081502.GE12258@hirez.programming.kicks-ass.net>
 <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
 <20180604091931.sziimdeei54jgwzn@salmiak>
From: Andreas Hartmann <andihartmann@01019freenet.de>
Openpgp: preference=signencrypt
Autocrypt: addr=andihartmann@01019freenet.de; keydata=
 xsDiBDz/vtQRBAC+OSpes1p57fA8ENLYy3Nl/CpEvtRoDdhy7DPyc1+adE57vpK52naRfaZB
 f0RSMvIZwJYggMio+emiN5Du7kL9y2IEjmHBvp/1x68dEwswHP9X4hJmHmyOJL3IB2WsvEdh
 QF97913bWX34MYCeuOoSJ1OWvBLGfNs0zv70HOTfJwCgricyy8N1itEryLwoeu5HWz0SmDED
 /2IiuDhPZ332i0Ylp40RQb2Wb0xBvpscVeRZDItsYYbJ/Sgmso1sn93sFFWmmrvGUyg3MNCt
 +u+7P8Wg3VXte8cHbNwdzNtXHTfYyTcgZXC4xJN2akZt4pdR531mXyP2kFxmKtAEmW6bNpvV
 oNnkgZVWvoT4BHLloLzA62JUEgFJA/9dHilAVS3Ezv5ECB02Lt2vNNzMvPlyNbxBhWnrb6VC
 mFMCRg9bOK2io1zYb8C4gEpJ33wl8hEBxOWfCOEEKesAUCjViosNvxqGNtGWjk5p1O2QBWE2
 D6u5+itACQRqhmmgNl+dK6Of2yGG9GxOYWozIELEfL9ZB4xQ7A2tDFR0Zs1HQW5kcmVhcyBI
 YXJ0bWFubiAod2VpbCBkZXIgUmVjaG5lciBuZXUgaGVpc3N0KSA8YW5kcmVhc0BkdWFsYy5t
 YXlhLm9yZz7CYAQTEQIAIAUCTMsY3gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBhU
 mcTgYeNVT1QAoJ4cJ2jl6Jgmi+PmWCXPk4m8lgAGAKCjkxgK/PjE3+cNsLa/xEpReqYwRs7A
 TQQ8/77WEAQAqBBex8oxPC1srpaSFbq8NCM/Gy7SKucKsQPqG/De46WQESbmnMElVft2xCBC
 rOJ7E02k10h/twe0yQnNdXMJDMDM0w0EEyX9ljekIr3SFbXpU2S4wUl3C6CW2hizUgOyLsg0
 chpfGMB9+wiVycyjZahafoc14wuuDj5BqWEOCccAAwcD/14lh1PTPKx4hs7ITtFZh5TI6+5f
 xAWIBBUeQL+GEt+CKwyNc/hWp8YTPJ3SAedmDrEMX+2yPO95KeIfg6bnnIVvI/aTR/vJFsWK
 GKMx+KaKx+IEwuhCpNIMUASpJWRvVlo3lMIvqAMJIBj79uKq/X9fppblcJst29QVO6aWf3Gh
 wkYEGBECAAYFAjz/vtYACgkQGFSZxOBh41VBAgCfZRiPCQ+jNvdT5iR2fEblqTtBrF0An0nb
 M8B1Lpkm44214BbtIQKneVrY
Message-ID: <9a977dda-c6c8-1193-58f8-d51d135e0d8a@01019freenet.de>
Date: Mon, 4 Jun 2018 12:00:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604091931.sziimdeei54jgwzn@salmiak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-score: -3.1
X-Spamreport: Action: no action
 Symbol: MIME_GOOD(-0.10)
 Symbol: MID_RHS_MATCH_FROM(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: NEURAL_HAM(-3.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: RCPT_COUNT_THREE(0.00)
 Symbol: SUBJECT_ENDS_EXCLAIM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: SUBJECT_HAS_QUESTION(0.00)
 Symbol: ASN(0.00)
 Message-ID: 9a977dda-c6c8-1193-58f8-d51d135e0d8a@01019freenet.de
X-FN-Spambar: 
X-Originated-At: 2003:de:53d7:1800:5054:ff:fe15:ac42!47940
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 06/04/2018 at 11:19 AM Mark Rutland wrote:
> On Mon, Jun 04, 2018 at 10:50:07AM +0200, Andreas Hartmann wrote:
>> Hello Peter,
>>
>> thanks for your answer! I appreciate it!
>>
>> On 06/04/2018 at 10:15 AM Peter Zijlstra wrote:
>>> On Fri, Jun 01, 2018 at 02:19:38PM +0200, Andreas Hartmann wrote:
>>>
>>>> I tested the spectre mitigation of different machines and kernels with
>>>> https://github.com/crozone/SpectrePoC
>>>>
>>>> You can see the results below.
>>>
>>>> My question: Did I miss something?
>>>
>>> Yes.
>>>
>>>> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
>>>> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
>>>> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
>>>
>>>                               ^^^^^^^^                         ^^^^^^^^
>>>
>>> The POC is a v1 on itself. V1 needs to be fixed for every individual
>>> executable (worse, for every individual location in the code, and we're
>>> still finding them). The kernel mitigation status for v1 only indicates
>>> the kernel itself has mitigations (for some locations).
>>>
>>> The POC is meant to test effectiveness of these mitigations, either the
>>> original LFENCE or the dependent instruction thing, but you have to
>>> enable one or the other.
>>
>> Ok, this means every program running on the machine has to care itself
>> to be spectre v1 - safe.
> 
> Correct. Primiarily this matters for things like JITs, where untrusted code may
> be run in the same address space as sensitive data.
> 
>> A malicious program most probably won't care about that. Therefore, my
>> next question is: which memory regions can be exploited by a malicious
>> program? The complete physical memory or only the memory provided to the
>> malicious program? Should be the latter if this approach should have any
>> impact.
> 
> Assuming you have a CPU which is not vulnerable to meltdown / variant-3, or you
> have mitigated this, (e.g. with KPTI), a malicious program can only access data
> within its own address space.
> 
> Spectre variant-1 alone only gives access to memory in the address space of the
> program itself.

Thanks Mark! Now I've a better understanding about the effects the
different vulnerabilities around Spectre and Meltdown do have and I'm
now hopefully able to better estimate them.

As I'm mostly using AMD-CPUs (like Ryzen 1 e.g.) for virtualization, I
should be secure by default regarding unwanted global memory access from
the VM to the host memory, because the Ryzen 1 CPU is not affected by
Meltdown at all.


Regards,
Andreas
