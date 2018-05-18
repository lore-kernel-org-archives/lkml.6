Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERRpG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:45:06 -0400
Received: from foss.arm.com ([217.140.101.70]:57562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeERRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:45:05 -0400
Subject: Re: [PATCH] arm64: kvm: use -fno-jump-tables with clang
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, christoffer.dall@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        LKML <linux-kernel@vger.kernel.org>
References: <20180518170202.11458-1-samitolvanen@google.com>
 <05d14ac7-0feb-63a3-e7ef-b8ca1ae2fd1d@arm.com>
 <CAKwvOdm1kYedukCq=g74AvqJHp6KC03oNoouQy2nkvfo4idoEw@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8c7be44f-086d-65e3-9969-8182261ce82f@arm.com>
Date: Fri, 18 May 2018 18:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdm1kYedukCq=g74AvqJHp6KC03oNoouQy2nkvfo4idoEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 18:40, Nick Desaulniers wrote:
> On Fri, May 18, 2018 at 10:30 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>> I'm going to ask the question I've asked before when this patch cropped
>> up (must be the 4th time now):
> 
>> Is it guaranteed that this is the only case where LLVM/clang is going to
>> generate absolute addresses instead of using relative addressing?
> 
> It seems like if there's requirements that only relative addressing be
> used, then the compiler should be told explicitly about this restriction,
> no?

Certainly. What's the rune?

	M.
-- 
Jazz is not dead. It just smells funny...
