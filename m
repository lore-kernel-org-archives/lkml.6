Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeDKCog (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:44:36 -0400
Received: from mx-fe5-210.meituan.com ([103.37.138.210]:38905 "EHLO
        mx02.meituan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeDKCof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:44:35 -0400
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com 927AC2974A0D
Subject: Re: [PATCH] writeback: safer lock nesting
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg Thelen <gthelen@google.com>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        heguanjun@meituan.com
References: <20180406080324.160306-1-gthelen@google.com>
 <DM5PR2101MB10326066D3508A2D9892B508FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
From: Wang Long <wanglong19@meituan.com>
Message-ID: <ea1a6d50-b8bd-237b-5ccd-2726da54d8d6@meituan.com>
Date: Wed, 11 Apr 2018 10:44:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <DM5PR2101MB10326066D3508A2D9892B508FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>
> [This is an automated email]
>
> This commit has been processed by the -stable helper bot and determined
> to be a high probability candidate for -stable trees. (score: 44.5575)
>
> The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.93, v4.4.127.
>
> v4.16.1: Build OK!
> v4.15.16: Build OK!
> v4.14.33: Build OK!
> v4.9.93: Build OK!
> v4.4.127: Failed to apply! Possible dependencies:
>      62cccb8c8e7a ("mm: simplify lock_page_memcg()")
Hi Sasha,

I test the memory cgroup in lts v4.4, for this issue, 62cccb8c8e7a ("mm: 
simplify lock_page_memcg()")
need to adjust and there are several other places that need to be fixed.

I will make the patch for lts v4.4 if no one did.

Thanks.
>
>
> Please let us know if you'd like to have this patch included in a stable tree.
>
> --
> Thanks,
> Sasha
