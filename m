Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeDXJOJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:14:09 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40566 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbeDXJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:14:07 -0400
X-Google-Smtp-Source: AIpwx49qaBvGC+dV6fBkel4JUzUrk7zkpPV4P76Tq2qqb7e5gBmn9VagMvgsNmJ7DeeU24BsD/ZJPpY7dxf2eA+f7uI=
MIME-Version: 1.0
In-Reply-To: <623cef28-530e-21af-e90c-64905f5c84b5@amd.com>
References: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com> <623cef28-530e-21af-e90c-64905f5c84b5@amd.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 24 Apr 2018 12:13:35 +0300
Message-ID: <CAFCwf13NW33eX4T9hYyLJ1Q8Yk+1hdmyfkDTaD2AY=05Ce6VaA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdkfd: Make function kfd_dev_is_large_bar() static
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:03 PM, Felix Kuehling <felix.kuehling@amd.com> wrote:
> This patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> On 2018-03-29 10:25 PM, Wei Yongjun wrote:
>> Fixes the following sparse warning:
>>
>> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:1150:6: warning:
>>  symbol 'kfd_dev_is_large_bar' was not declared. Should it be static?
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index cd679cf..fb5d997 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1147,7 +1147,7 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>>       return ret;
>>  }
>>
>> -bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>> +static bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>>  {
>>       struct kfd_local_mem_info mem_info;
>>
>
Thanks, already applied the fix from the kbuild robot.
Oded
