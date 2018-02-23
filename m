Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeBWBpB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:45:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:30216 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbeBWBpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:45:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,381,1515484800";
   d="scan'208";a="206287905"
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180222050324.21531-1-joel@jms.id.au>
 <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
 <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
 <1519344667.1024159.1280347184.36AD3FEC@webmail.messagingengine.com>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <d67a8a8d-4b3d-403c-e62d-bc0939e8d08f@linux.intel.com>
Date: Fri, 23 Feb 2018 09:44:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519344667.1024159.1280347184.36AD3FEC@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-02-23 08:11, Andrew Jeffery wrote:
> Hi Haiyue,
>
> On Thu, 22 Feb 2018, at 19:20, Wang, Haiyue wrote:
>> Dear Andrew & Joel,
>>
>> Since you are ASPEED BMC experts, any time and interest in eSPI code
>> review ? I've sent
>>
>> it before, but no more response. Intel recommends eSPI bus than LPC as I
>> know. I just kept
>>
>> the minimal eSPI code which is approved to work well in our real server
>> boards for two more
>>
>> years. Other part of eSPI driver from ASPEED's SDK  has been removed,
>> because ePSI is a new
>>
>> thing, we only use a small feature set like booting host.
>>
>> We Intel submit this eSPI patch for openbmc upstreaming, hope for your
>> response. :-)
>>
>> https://patchwork.kernel.org/patch/10166577/
>>
> There are some comments against the v1 that you linked to above, is there a v2 on the lists?
A long holiday back, will send v2 patch soon.
> Separately it's better to ping us by replying to the patch itself and putting us in To/Cc, that way we keep discussions focused on the patch at hand here.
Got it. Thanks for your reply.
>
> Cheers,
>
> Andrew
