Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeCPI16 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:27:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7888 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752538AbeCPI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:27:56 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37877562"
Subject: Re: [PATCH] kernel/cpu: Move cpuhp_is_atomic_state() into #ifdef
 CONFIG_SMP
To: Thomas Gleixner <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>,
        <mingo@elte.hu>, <peterz@infradead.org>, <jiangshanlai@gmail.com>
References: <20180316063852.22701-1-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1803160858290.1598@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <da090caa-ac92-d0f4-dee3-b11610e69d47@cn.fujitsu.com>
Date: Fri, 16 Mar 2018 16:27:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803160858290.1598@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 2DA7E4D0EFFC.AF932
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 03/16/2018 03:59 PM, Thomas Gleixner wrote:
> On Fri, 16 Mar 2018, Dou Liyang wrote:
> 
>> Commit 17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")
>> removed the last use of cpuhp_is_atomic_state() in common case, that caused
>> Kernel produced a warning:
>>
>>    'cpuhp_is_ap_state' defined but not used
>>
>> So, Move it into #ifdef CONFIG_SMP
> 
> Thanks for the patch, but a fix is already queued in the smp/hotplug
> branch. It just did not make it into the for-next branch yet,
> 

Oops, yes, let's ignore this patch.

Thanks,
	dou

> Thanks,
> 
> 	tglx
> 
> 
> 
