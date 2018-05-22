Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeEVJXE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:23:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33628 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751268AbeEVJXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:23:00 -0400
Subject: Re: [PATCH 22/33] drm/i915: use match_string() helper
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-23-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Ve0zmHZqESKgB1U9XEhztHPzAWcw9O-8K4JUAamdmYd3A@mail.gmail.com>
 <87lgccw0hd.fsf@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <fc1a13c6-fee5-52a2-936c-097efa6fc6be@huawei.com>
Date: Tue, 22 May 2018 17:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <87lgccw0hd.fsf@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On 2018/5/22 16:36, Jani Nikula wrote:
> On Tue, 22 May 2018, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>> match_string() returns the index of an array for a matching string,
>>> which can be used intead of open coded variant.
>>
>> https://patchwork.kernel.org/patch/10382323/
> 
> Even more convincingly,
> 
> 47d4cb8ae8e7 ("i915: Convert to use match_string() helper")

Sorry, but I will definitely remove them in next version, I just miss these.

Thanks
Yisheng
> 
> BR,
> Jani.
> 
>>
>>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: intel-gfx@lists.freedesktop.org
>>> Cc: dri-devel@lists.freedesktop.org
> 
