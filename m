Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935432AbeEYFc2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:32:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53583 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeEYFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:32:27 -0400
X-Google-Smtp-Source: AB8JxZpmKqLmGz82ejrP1bE5+eHo/eWqbCLYokU+3kqQbCSpG6P2tgywzryECpDbuVc1kVBt1LvoCw==
Subject: Re: [PATCH v2] drm/xen-front: fix pointer casts
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@intel.com, boris.ostrovsky@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180523113630.29811-1-andr2000@gmail.com>
 <b516542b-a0f5-cbce-d351-25b88a7f3288@suse.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a8cff47d-a990-924a-0a63-b6f3aea3279b@gmail.com>
Date: Fri, 25 May 2018 08:32:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b516542b-a0f5-cbce-d351-25b88a7f3288@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 02:46 PM, Juergen Gross wrote:
> On 23/05/18 13:36, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Building for a 32-bit target results in warnings from casting
>> between a 32-bit pointer and a 64-bit integer. Fix the warnings
>> by casting those pointers to uintptr_t first.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
Thank you, applied to drm-misc-next
>
> Juergen
