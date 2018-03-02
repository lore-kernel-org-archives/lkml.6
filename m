Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428102AbeCBNYZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:24:25 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:28173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1425029AbeCBNYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:24:23 -0500
Subject: Re: [Question PATCH 0/1] mm: crash in vmalloc_to_page - misuse or
 bug?
To: <mhocko@kernel.org>
CC: <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20180222141324.5696-1-igor.stoppa@huawei.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <921e8bb3-3c4d-be75-3029-35fde00087c7@huawei.com>
Date: Fri, 2 Mar 2018 15:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222141324.5696-1-igor.stoppa@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

The kernel test automation seems to confirm my findings:

https://marc.info/?l=linux-mm&m=151999308428656&w=2

Is this really a bug?

On 22/02/18 16:13, Igor Stoppa wrote:
> While trying to change the code of find_vm_area, I got an automated
> notification that my code was breaking the testing of i386, based on the
> 0-day testing automation from 01.org
> 
> I started investigating the issue and noticed that it seems to be
> reproducible also on top of plain 4.16-rc2, without any of my patches.
> 
> I'm still not 100% sure that I'm doing something sane, but I thought it
> might be good to share the finding.
> 
> The patch contains both a minimal change, to trigger the crash, and a
> snippet of the log of the crash i get.
> 
> Igor Stoppa (1):
>   crash vmalloc_to_page()
> 
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


--
igor
