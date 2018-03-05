Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeCEEIE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 23:08:04 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:57412 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbeCEEIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 23:08:02 -0500
Subject: Re: [PATCH] mmc: Export host capabilities to debugfs.
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>,
        <avri.altman@wdc.com>, <andriy.shevchenko@linux.intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519910255-6296-1-git-send-email-harish_kandiga@mentor.com>
 <ba1aa77a-88ea-faba-8dec-33373b65664c@mentor.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <a5c9d802-47b0-b020-b93a-7747b469d594@mentor.com>
Date: Mon, 5 Mar 2018 09:37:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ba1aa77a-88ea-faba-8dec-33373b65664c@mentor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 03 March 2018 10:02 PM, Vladimir Zapolskiy wrote:
> Hi Harish,
>
> On 03/01/2018 03:17 PM, Harish Jenny K N wrote:
>> This patch exports the host capabilities to debugfs
>>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
> would you mind to restore the authorship to Abbas Raza and send v2?
Sure. Abbas had left Mentor and this was being done as part of new project.
Still, I will resend the patch by changing the Author.

Thanks,
Harish
