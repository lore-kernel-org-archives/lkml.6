Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBKCdp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 21:33:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751050AbeBKCdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 21:33:44 -0500
Subject: Re: [V9fs-developer] [RFC] we should solve create-unlink-getattr
 idiom
To: Greg Kurz <groug@kaod.org>
References: <5A7D4976.6060407@huawei.com> <20180209123342.11b17062@bahia.lan>
CC: Eric Van Hensbergen <ericvh@gmail.com>,
        <v9fs-developer@lists.sourceforge.net>, <qemu-devel@nongnu.org>,
        <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Veaceslav Falico <veaceslav.falico@huawei.com>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5A7FAB6B.2090802@huawei.com>
Date: Sun, 11 Feb 2018 10:33:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180209123342.11b17062@bahia.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/9 19:33, Greg Kurz wrote:
> On Fri, 9 Feb 2018 15:10:46 +0800
> jiangyiwen <jiangyiwen@huawei.com> wrote:
> 
>> Hi Eric and Greg,
>>
>> I encountered the similar problem with create-unlink-getattr idiom.
>> I use the testcase that create-unlink-setattr idiom, and I see the
>> bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
>> Then I also see you already fix the issue and push the patch to upstream.
>> https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
>> http://patchwork.ozlabs.org/patch/626194/
>>
>> Unfortunately, the two patches are not merged into master, I don't know
>> the reason, so I suggest if the patche can be merged into master, and
>> it will solve the create-unlink-getattr idiom.
>>
> 
> I had tried to go a bit further and address the general issue of f*() syscalls
> versus unlinked files:
> 
> QEMU:
> http://lists.gnu.org/archive/html/qemu-devel/2016-06/msg07586.html
> 
> Linux 9p driver:
> https://sourceforge.net/p/v9fs/mailman/message/35175775/
> 
> I remember that some issues were then reported during review of the
> linux patches, and I never got bandwidth to investigate further...
> 
> But if you'd like to resurrect these threads, please do. :)
> 
>> Thanks,
>> Yiwen
>>
> 
> Cheers,
> 
> --
> Greg
> 
> .
> 
Thanks Greg,

Ok, we will move forward, I hope we can solve these problems that you
encountered.

Thanks,
Yiwen.
