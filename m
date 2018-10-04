Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6898E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6898E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJDXHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:07:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:26726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeJDXHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:07:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 09:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="238500877"
Received: from unknown (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2018 09:11:45 -0700
Subject: Re: [PATCH i2c-next v5 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
To:     Joel Stanley <joel@jms.id.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
 <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <185b73f1-ad5f-eedb-7c56-2a2e266f5960@linux.intel.com>
Date:   Thu, 4 Oct 2018 09:11:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2018 1:32 AM, Joel Stanley wrote:
> On Thu, 4 Oct 2018 at 00:31, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit removes hard-coded bus timeout value setting so that
>> it can be set by i2c-core-base.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 

Thanks for the review, Joel!
