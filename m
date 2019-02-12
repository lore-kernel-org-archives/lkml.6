Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81889C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5392B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfBLPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:18:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:60533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfBLPSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:18:34 -0500
Received: from [10.0.0.4] ([113.116.50.220]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LanoO-1hM0lh3zuy-00kLF2; Tue, 12
 Feb 2019 16:18:32 +0100
Subject: Re: [PATCH 2/2] chardev: showing minor range for chardev in the
 output of /proc/devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190212084739.27602-1-cgxu519@gmx.com>
 <20190212084739.27602-2-cgxu519@gmx.com> <20190212090212.GE31657@kroah.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <a8332299-818e-571c-efc9-7885f18eddb8@gmx.com>
Date:   Tue, 12 Feb 2019 23:18:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212090212.GE31657@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:Xa4wh6d0Mod13N5cTbofoHCAh4XwuCAuP1h3KZCFcfnNClZkAFL
 cN32xEp9ono7gfnpy4ugs7iIFPtXmvhA7GdSnfG45p51N3IyIWqqkLu2svlrQRc2Wx/rR5j
 kfg46qeBDvsREV/vN7/mIn5zsHcvd7MdUTL6+3r+JTxk71sNHd7LYIJr4/YRK67vbpkr51S
 V2m4qu3rZ41elPkXkzLRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:trjpudQHjio=:y7sDnD293Qps6sTR0FVvTh
 kUbDdgouXtux0rsTMQGFx7PTqzj4hSU02p1QRvYpHXwt+YFSiPiDya/2v2Em3y1N5QeSdRkyN
 cpWVJpM2kzY1+vF3kxnzRGXeWMDfCNYxfpHdbvHUuOhvRYSJnjUyix5rXPayodwblFy3zx9EA
 wWyJzqrgajZENCKcWTq413wGoD9LfYapEd9baTwVObj6KBi0odurtNbONNzw+Njvbnev6uSXw
 aRK623+EZSk5kVMid9mPcS8w/GrVnWMfNUGiA9BdOwUqldcQMk9jPFVzDv/p3SFC04FKGqjdY
 IQL5qQmz8H6s72J2wUeb+yA+ogGDGQabyXKfJb6KcrXiI4tbLDThhVGVObKMfoS/E+9MS7W2I
 APDqOFebtTe2S11pmcKuf5hR6DXx9OOxFN48rta1ULf/KO8XE8Iw+g8B+meOr6AZQbr1PVNBX
 GYsP/fJFpjjOlWh+IRgAyfHPUcGtqzTJqFnQv69tp0EX22/857vVWHpYohowLw4IcvweoOWW8
 bmU02iQ59mmzzK4NIhfzaWyg2wXPbjNMWadIitUgOvXd/tD4shKfrG5IUqub3t06/qT/ePSpt
 hk+kWGXwLu2kXs4nOQJYkqJrTUxPfs6npWiEafKkHniLxeOEyY+XUBEumZHFbN3b4Tl7NVkuq
 k5bpHN+wGp5+x5a4qGeRAGENxnzXT41q+3zME21b5HUV8AO3Yx5aAUh6upbtHAB7Bl1QEJTEz
 L9djnnAouRMM4ASa8UCzxQoLwyXb6tMbJXSpxNmaL42yApxv5Xzs1ZXikfKMuWQArvAXatUXv
 6tFieMpoUSgaXEs0HsNSCmvV0+MAvM2OQHLUH0cvXqwNMUdc6bKvyVn1bsiLPdVNSIvn7R9rg
 sDgaOEnT2uBB3KXtsVRimw/atn/nQeNFhWQzAVES0Lqadr+cJc0uvJ2d/4V5dbtwzthWHOkVc
 +c+sm9b7tjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 5:02 PM, Greg KH wrote:
> On Tue, Feb 12, 2019 at 04:47:39PM +0800, Chengguang Xu wrote:
>> Currently chardev allows to share major, showing
>> major with minor range for chardev will be more
>> helpful.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>> ---
>>   fs/char_dev.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/char_dev.c b/fs/char_dev.c
>> index b25b1da097d5..6f00acdeb308 100644
>> --- a/fs/char_dev.c
>> +++ b/fs/char_dev.c
>> @@ -55,7 +55,9 @@ void chrdev_show(struct seq_file *f, off_t offset)
>>   	mutex_lock(&chrdevs_lock);
>>   	for (cd = chrdevs[major_to_index(offset)]; cd; cd = cd->next) {
>>   		if (cd->major == offset)
>> -			seq_printf(f, "%3d %s\n", cd->major, cd->name);
>> +			seq_printf(f, "%3d %s (%u-%u)\n", cd->major, cd->name,
>> +				   cd->baseminor,
>> +				   cd->baseminor + cd->minorct - 1);
> You are changing the format of a userspace file, what tools are going to
> break when you do this?

I'll remove this part in V2. Do you have any idea how to get the minor
range info for particular major? Or adding a similar file to somewhere
under /sys is acceptable?

Thanks



