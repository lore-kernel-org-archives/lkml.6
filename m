Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeEPJuD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:50:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753280AbeEPJuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:50:00 -0400
Subject: Re: [RFC][PATCH] KVM: APPLES can improve the performance of
 applications and virtualized systems by up to 49%
To: Weiwei Jia <harrynjit@gmail.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, xen-devel@lists.xenproject.org, dingxn@gmail.com,
        jianchen.shan@gmail.com, Weiwei Jia <harryxiyou@gmail.com>
References: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <395e16c4-f764-604f-f37e-d178ab753920@redhat.com>
Date: Wed, 16 May 2018 11:49:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.2018 10:27, Weiwei Jia wrote:
> Dear all,
> 
> Recently, we made a few improvements on effectively utilizing Pause
> Loop Exiting (PLE) support for higher throughput on virtualized
> systems. Basically, it solves two problems: 1) how to adjust
> PLE_Window; 2) how to select virtual CPUs to schedule on VM_EXITs
> caused by PLE. Our tests with standard benchmarks show that the
> approach can improve performance by up to 49%. The approach shows
> promising performance and is easy to implement. We think that it would
> be wonderful if Linux/KVM and XEN can consider the approach.
> 
> We already have a prototype implementation based on KVM (Linux Kernel
> 3.19.8). Our patch for Linux Kernel 3.19.8 and the paper describing
> our idea are available in Github repository [1][2][3]. We are pleased
> to revise our patch in order to merge it into Linux/KVM and XEN. We
> hope that you can test and adopt our approach/techniques. We are
> pleased to get some comments/suggestions on the approach and on how
> the idea can be adopted/tested by Linux/KVM and XEN. Thank you.
> 

Hi,

Please port the patch to latest upstream and send it as a proper patch
to this mailing list. (otherwise you won't get feedback on it WHP)

If you want some initial comment if this makes sense at all in the
context of KVM and can be implemented, you can send the patch itself as
RFC (based on an older kernel version).

Thanks!

> [1] APPLES paper: https://github.com/sysmen/apples/tree/master/paper
> [2] APPLES patch:
> https://github.com/sysmen/apples/blob/master/patches/3.19.8-APPLES.patch
> [3] APPLES patch README:
> https://github.com/sysmen/apples/blob/master/patches/README.txt
> 
> Best Regards,
> Sysmen Research Group
> 


-- 

Thanks,

David / dhildenb
