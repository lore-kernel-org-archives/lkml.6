Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeCGD1W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 22:27:22 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34590 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeCGD1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 22:27:20 -0500
X-Google-Smtp-Source: AG47ELs4ZcqF6wUCBGy2TRZYPXadMcKQlFfNv/mJBfuFgEflURi+4Eqzs5sJRrQ/MJEgxVpYSKVMEQ==
MIME-Version: 1.0
In-Reply-To: <5A9F598E.4020704@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com> <20180306032759.29069-4-jeffy.chen@rock-chips.com>
 <CAAFQd5DPewKda7ThqMGKRvnArZ0X8ChD10E06nLZaNa-SBNdwA@mail.gmail.com> <5A9F598E.4020704@rock-chips.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 7 Mar 2018 12:26:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CM+7=RrJ_3OBmpHWAOA4VnxL24j=w-wMobjm_cVd5K3Q@mail.gmail.com>
Message-ID: <CAAFQd5CM+7=RrJ_3OBmpHWAOA4VnxL24j=w-wMobjm_cVd5K3Q@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] iommu/rockchip: Add runtime PM support
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        open@263.net,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, list@263.net:IOMMU DRIVERS
        <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 12:16 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
> On 03/06/2018 06:07 PM, Tomasz Figa wrote:
>>
>> Hi Jeffy,
>>
>> It looks like I missed some details of how runtime PM enable works
>> before, so we might be able to simplify things. Sorry for not getting
>> things right earlier
>
>
> hmm, right, the enable state should be the same during those functions. will
> do it in the next version.

Thanks. I actually realized that we don't even need the
pm_runtime_enabled() checks either.

Actually, we can clean this up in an incremental patch, so no need to
resend if no other changes needed, since current code is still
technically correct.

Best regards,
Tomasz
