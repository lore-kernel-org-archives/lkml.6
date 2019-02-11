Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D87CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4844321B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfBKS3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:29:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:27897 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbfBKS3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:29:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="274205804"
Received: from unknown (HELO [10.7.153.148]) ([10.7.153.148])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2019 10:29:33 -0800
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
 <20190208214849.GH12451@kunai>
 <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
 <20190211181658.u55ggc2xi4nsxxvy@katana>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <f444a8eb-06cf-4119-da9d-aab1029830e6@linux.intel.com>
Date:   Mon, 11 Feb 2019 10:29:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190211181658.u55ggc2xi4nsxxvy@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2019 10:16 AM, Wolfram Sang wrote:
> 
>> Can you please apply above changes on top of this patch? Or I can submit
>> v2 with it.
> 
> Please send v2.
> 

Okay, I'll send v2.

Thanks,
Jae
