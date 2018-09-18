Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325D420657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325D420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeIRS5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:57:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:59167 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeIRS5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:57:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 06:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="264545335"
Received: from mylly.fi.intel.com (HELO [10.237.72.64]) ([10.237.72.64])
  by fmsmga006.fm.intel.com with ESMTP; 18 Sep 2018 06:25:17 -0700
Subject: Re: [PATCH v3 3/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180917112633.252c591c@xhacker.debian>
 <20180917112949.414dd56f@xhacker.debian>
 <20180917113418.16881f6c@xhacker.debian>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <8160d36b-2fb5-c037-893c-c23568a9f6ac@linux.intel.com>
Date:   Tue, 18 Sep 2018 16:25:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917113418.16881f6c@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 06:34 AM, Jisheng Zhang wrote:
> + DT maintainers
> 
> On Mon, 17 Sep 2018 11:29:49 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
>> On some platforms, the sda/scl pins are muxed with gpio functions, so
>> they could be used for recovery. Select the gpio/default pin function
>> when prepare/unprepare recovery.
>>
>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-core.h   |  3 +++
>>   drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
