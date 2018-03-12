Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeCLEo1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:44:27 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:34847 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeCLEo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:44:26 -0400
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
To: Linus Walleij <linus.walleij@linaro.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
 <67491d8c-7eb3-e8c5-7eb0-3006ff668a60@wdc.com>
 <CACRpkdaPk6=DNH_Wk6q-8_Sa8BCCHA28Jr5FO64Q0eeUCFCBXQ@mail.gmail.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <1714e1a4-c591-34e6-125e-3eb2e074e698@mentor.com>
Date: Mon, 12 Mar 2018 10:14:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaPk6=DNH_Wk6q-8_Sa8BCCHA28Jr5FO64Q0eeUCFCBXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 05:29 PM, Linus Walleij wrote:
>
> But this patch doesn't hide the partition from userspace does it?
>
> They will still appear in /dev/mmcblk0boot1 etc.
>
> Just not reported as "real" partitions in /proc/partitions.
>
> Or do I misunderstand it?
>
>

You are correct. This patch does not hide partition from userspace.
They will still appear in /dev/. But not reported as "real" partitions in /proc/partiotions.

Thanks,
Harish Jenny K N
