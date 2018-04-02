Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeDBGGY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:06:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47310 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751231AbeDBGGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:06:23 -0400
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_Re:_[PATCH_v2]_scsi:_Introduce_sd?=
 =?UTF-8?Q?ev=5fprintk=5fratelimited_to_throttlefrequent_printk?=
To: <wen.yang99@zte.com.cn>
References: 1522634332-151328-1-git-send-email-wen.yang99@zte.com.cn
 5AC1976F.1040801@huawei.com <201804021314481872986@zte.com.cn>
CC: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Bart.VanAssche@wdc.com>, <pmladek@suse.com>,
        <sergey.senozhatsky.work@gmail.com>, <tj@kernel.org>,
        <jiang.biao2@zte.com.cn>, <zhong.weidong@zte.com.cn>,
        <tan.hu@zte.com.cn>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <5AC1C85B.4010804@huawei.com>
Date: Mon, 2 Apr 2018 14:06:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <201804021314481872986@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/2 13:14, wen.yang99@zte.com.cn wrote:
> Hello,
>
>  > It's true that this print for the same device is useless. But it's
>
>  > useful for different devices. Is it possible to limit the print only
>
>  > for the same device?
>
>
> In our scene, it's  just for the same device (q->queuedata), Thanks.
>

I mean the print limit you add will affect all devices. One device's 
print *may* cause another device's print limited even if it only printed 
one message.
