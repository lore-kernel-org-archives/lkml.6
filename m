Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeCFMrq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:47:46 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:57869 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeCFMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:47:44 -0500
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
To: Linus Walleij <linus.walleij@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <034dc340-149f-dfdf-a2eb-5f15ce9fb412@mentor.com>
Date: Tue, 6 Mar 2018 18:17:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 02 March 2018 06:23 PM, Linus Walleij wrote:
> On Tue, Feb 27, 2018 at 12:33 PM, Harish Jenny K N
> <harish_kandiga@mentor.com> wrote:
>
>> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>>
>> Since RPMB area is accessible via special ioctl only and boot areas
>> are unlikely to contain any partitions, exclude them all from listing
>> in /proc/partitions. This will hide them from various user-level
>> software (e.g. fdisk), thus avoiding unnecessary access attempts.
>>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> Makes sense to me, at least it makes the problem smaller not bigger.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>


Any other comments/inputs on this ?


Thanks,
Harish Jenny K N
