Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeBVIuW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:50:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:45054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752979AbeBVIuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:50:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="20213038"
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180222050324.21531-1-joel@jms.id.au>
 <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
Date: Thu, 22 Feb 2018 16:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew & Joel,

Since you are ASPEED BMC experts, any time and interest in eSPI code 
review ? I've sent

it before, but no more response. Intel recommends eSPI bus than LPC as I 
know. I just kept

the minimal eSPI code which is approved to work well in our real server 
boards for two more

years. Other part of eSPI driver from ASPEED's SDK  has been removed, 
because ePSI is a new

thing, we only use a small feature set like booting host.

We Intel submit this eSPI patch for openbmc upstreaming, hope for your 
response. :-)

https://patchwork.kernel.org/patch/10166577/



On 2018-02-22 16:39, Andrew Jeffery wrote:
>
> On Thu, 22 Feb 2018, at 15:33, Joel Stanley wrote:
>> I am interested in all ASPEED drivers, and the previous match wasn't
>> grabbing files in nested directories. Use N instead.
>>
>> Add the arm kernel mailing list so that patches get reviewed there, and
>> the linux-aspeed list which exists only so I can use patchwork to track
>> patches.
>>
>> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
>> stuff.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
