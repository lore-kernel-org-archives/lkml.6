Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeBAOVg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:21:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbeBAOVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:21:34 -0500
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <christoffer.dall@linaro.org>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20180201125512.7bc96674@canb.auug.org.au>
 <20180201104707.GA21802@cbox> <20180202002227.36db3356@canb.auug.org.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f49453f2-223e-abe0-912a-7288183a1671@redhat.com>
Date: Thu, 1 Feb 2018 09:21:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202002227.36db3356@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2018 08:22, Stephen Rothwell wrote:
> Hi Christoffer,
> 
> On Thu, 1 Feb 2018 11:47:07 +0100 Christoffer Dall <christoffer.dall@linaro.org> wrote:
>>
>> While the suggested fix is functional it does result in some code
>> duplication, and the better resolution is the following:
> 
> OK, I will use that resolution form tomorrow on.
> 
> Someone needs to remember to let Linus know when the pull request is
> sent.

It should be fixed in the KVM tree before it reaches Linus (when we
merge a topic branch that is common between x86/pti & KVM).

Thanks,

Paolo
