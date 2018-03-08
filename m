Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935649AbeCHIqf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:46:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52640 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S935629AbeCHIqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:46:32 -0500
Subject: Re: [PATCH net-next 00/23] net: hns3: HNS3 bug fixes & code
 improvements
To: David Miller <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
 <20180308.000007.382330152921347908.davem@davemloft.net>
From: "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <89b18cf6-b0aa-14c4-f708-29b4ebde3d53@huawei.com>
Date: Thu, 8 Mar 2018 16:46:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180308.000007.382330152921347908.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.63.173.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/3/8 13:00, David Miller wrote:
> Sorry, this is way too large of a patch series.
>
> Please keep your series to about a dozen or so changes.
>
> Anything longer puts an unreasonable burdon upon patch
> reviewers, and such a large series will often make it
> so that nearly all reviewers are discouraged from taking
> a look at all.
>
> Thank you.
I will split this patchset into 3 patchset:
VF driver related patchset(6 patches) + reset related patchset(9 
patches) + PF bugfix patchset(8 patches).
I think this should be better for review.

Thanks

> .
>
