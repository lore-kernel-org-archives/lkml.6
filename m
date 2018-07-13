Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E8EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0F82075B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0F82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGMUxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:53:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:65403 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbeGMUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:53:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 13:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,349,1526367600"; 
   d="scan'208";a="64537315"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2018 13:37:17 -0700
Subject: Re: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
 <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
 <20180713203327.47yq4gucidbzn2hd@katana>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <0840cfe8-e18a-ae7c-5593-fc43b9b47291@linux.intel.com>
Date:   Fri, 13 Jul 2018 13:37:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713203327.47yq4gucidbzn2hd@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/2018 1:33 PM, Wolfram Sang wrote:
> 
>> BTW, to whom should I ask applying this patch? Should I send v2 after
>> adding your reviewed-by tag?
> 
> Not needed, thanks. I use 'patchwork' and this tool collects all the
> tags for me. If I see a patch reviewed by a driver maintainer, I'll pick
> it up in the next queue.
> 

Oh, I see. Thanks a lot Wolfram!
