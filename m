Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58902087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfBYSzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:55:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:26303 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfBYSzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:55:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 10:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="117679809"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2019 10:55:01 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH 2/2] ARM: socfpga_defconfig: enable EDAC by default
To:     Dinh Nguyen <dinguyen@kernel.org>, bp@alien8.de,
        linux@armlinux.org.uk, mchehab@kernel.org, james.morse@arm.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
 <1550602799-22737-3-git-send-email-thor.thayer@linux.intel.com>
 <ed55288c-458a-b770-423e-3691c020f840@kernel.org>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <78bd26f7-861b-0493-c8ed-ccb7a6673825@linux.intel.com>
Date:   Mon, 25 Feb 2019 12:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ed55288c-458a-b770-423e-3691c020f840@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 11:36 AM, Dinh Nguyen wrote:
> Hi Thor,
> 
> On 2/19/19 12:59 PM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Enable the different ECC blocks by default on Cyclone5
>> and Arria10.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   arch/arm/configs/socfpga_defconfig | 36 ++++++++++++++++++++++--------------
>>   1 file changed, 22 insertions(+), 14 deletions(-)
>>
> 
> Looks like you did a 'make savedefconfig' on this as well? can you
> please rebase your patch to the arm/defconfig on the arm-soc tree?
> 
> Thanks,
> Dinh
> 
Yes. I'll send a V2 shortly. Thanks for reviewing.
