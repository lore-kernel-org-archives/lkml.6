Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeDXNwO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:52:14 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:48516 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933220AbeDXNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:04 -0400
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>, <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, <oprofile-list@lists.sf.net>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
Date: Tue, 24 Apr 2018 14:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424130511.GB28813@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524575740-637137-13540-10775-1
X-BESS-VER: 2018.5-r1804232011
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192328
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/18 14:05, James Hogan wrote:
> On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
>> Since it appears that MIPS oprofile support is currently broken, core
>> oprofile is not getting many updates and not as many architectures
>> implement support for it compared to perf, remove the MIPS support.
> 
> That sounds reasonable to me. Any idea how long its been broken?

Sorry, not yet. I haven't yet looked into where/how it's broken that 
would narrow that down...

The other thing to bear in mind is that the userspace tools have not 
seen any MIPS additions since 2010, the last commit being to add 1004K 
and 34K support:
https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/events/mips/

Though I'm not sure if anyone is maintaining a vendor specific fork 
containing further support.

> 
> I'll let it sit on the list for a bit in case anybody does object and
> wants to fix it instead.

Cool, sounds good.

Thanks,
Matt

> 
> Thanks
> James
> 
