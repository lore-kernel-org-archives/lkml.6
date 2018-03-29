Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeC2Xao (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:30:44 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36143 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeC2Xam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:30:42 -0400
X-Google-Smtp-Source: AG47ELuAQP8PKsvHq+t1WWlLW2VBefuG8Uop8VFk0oYPd70jfEeodCl+MoytNGtBAOFg+KX3F8NLzQ==
Subject: Re: [GIT PULL 00/37] lightnvm patches for 4.17
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com
References: <20180329220524.30363-1-mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2926fe22-ff91-67a0-ffba-0b0707e2b798@kernel.dk>
Date: Thu, 29 Mar 2018 17:30:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/18 4:04 PM, Matias Bjørling wrote:
> Hi Jens,
> 
> Here is a bunch of patches for 4.17. They include:
> 
>  - Open-Channel 2.0 support by Javier and I.
>  - Lots of refactoring patches to enable 2.0 support.
>  - Fixes to pblk from Hans, Markus, and Dan.
>  - Introduction of write amplication and padding counters. From Hans.
>  - Fix from Johannes to unify the permission checks for the lightnvm
>    ioctls.
>  - Fixes from Heiner for bad block initialization and
>    over-provisioning validation.
> 
> Please pick up when convenient.

Applied, thanks.

-- 
Jens Axboe
