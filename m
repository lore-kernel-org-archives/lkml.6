Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeBWSFJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:05:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751623AbeBWSFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:05:07 -0500
Subject: Re: [PATCH] kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.LFD.2.21.1802221304430.1603@schleppi>
 <e95a0813-d421-f01c-8708-224758a1b117@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <236c47d7-1932-59cf-1eff-698e0d89b7bd@redhat.com>
Date: Fri, 23 Feb 2018 19:05:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e95a0813-d421-f01c-8708-224758a1b117@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2018 16:21, Christian Borntraeger wrote:
> I can see this warnings as well and yes, kvm_arch_irq_routing_update seems to be available
> for CONFIG_HAVE_KVM_EVENTFD=y and =n.
> Seems that irqchip.c is compile independly from CONFIG_HAVE_KVM_EVENTFD,
> 
> so
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Queued, thanks for the review!

Paolo
