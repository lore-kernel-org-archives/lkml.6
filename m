Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428016AbeCBNSC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:18:02 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:58051 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424506AbeCBNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:17:58 -0500
Subject: Re: [PATCH] mmc: Export host capabilities to debugfs.
To: Linus Walleij <linus.walleij@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519910255-6296-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkda26vE3vfuX3ioJduuTh8fyWOZgsZ-e1BbQiwAf=3ZuAg@mail.gmail.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <09fabc35-438c-2634-b582-bf5a7888b930@mentor.com>
Date: Fri, 2 Mar 2018 18:47:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda26vE3vfuX3ioJduuTh8fyWOZgsZ-e1BbQiwAf=3ZuAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 01 March 2018 07:54 PM, Linus Walleij wrote:
> On Thu, Mar 1, 2018 at 2:17 PM, Harish Jenny K N
> <harish_kandiga@mentor.com> wrote:
>
> Thanks for your patch!
>
>> This patch exports the host capabilities to debugfs
>>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> Is there a corresponding patch to the mmc utils to make use
> of the exported information? An opaque u32 seems pretty hard
> to interpret.
>
> Yours,
> Linus Walleij
A sample patch "[RFC PATCH] mmc-utils: host_caps: Add parser to read host capabilities" is submitted.

Thanks,
Harish Jenny K N
