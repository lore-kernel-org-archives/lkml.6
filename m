Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDMQZO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:25:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:18530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbeDMQZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:25:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="220216714"
Subject: Re: [PATCH ipmi/kcs_bmc v1] ipmi: add an NPCM7xx KCS BMC driver
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: joel@jms.id.au, avifishman70@gmail.com
References: <1521723015-19142-1-git-send-email-haiyue.wang@linux.intel.com>
 <4a878c46-9451-8ee6-c067-955a0bd651d0@acm.org>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <9fffe8eb-5e9b-db84-be9e-fa415d52a88b@linux.intel.com>
Date: Sat, 14 Apr 2018 00:25:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4a878c46-9451-8ee6-c067-955a0bd651d0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Corey.

BR,

Haiyue


On 2018-04-13 23:56, Corey Minyard wrote:
> On 03/22/2018 07:50 AM, Haiyue Wang wrote:
>> This driver exposes the Keyboard Controller Style (KCS) interface on
>> Novoton NPCM7xx SoCs as a character device. Such SOCs are commonly used
>> as a BaseBoard Management Controller (BMC) on a server board, and KCS
>> interface is commonly used to perform the in-band IPMI communication
>> between the server and its BMC.
>
> Sorry, I missed this.  It is queued for the next kernel release.
>
> Thanks,
>
> -corey 
