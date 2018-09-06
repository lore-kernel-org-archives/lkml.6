Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70902075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70902075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeIFXKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:10:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:59814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbeIFXKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:10:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 11:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="261330520"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2018 11:33:47 -0700
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-aspeed@lists.ozlabs.org, james.feist@linux.intel.com,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, vernon.mauery@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g46fRrYW8E8FsPB=5fWSGxemgc4ENc4D2fT7yBfH6p4ERg@mail.gmail.com>
 <eab56d58-0703-d201-dc9a-f9fd257e96cf@linux.intel.com>
 <20180906180837.GA8607@kunai>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <0e844fc2-777b-7aee-2402-9fe579cbcf51@linux.intel.com>
Date:   Thu, 6 Sep 2018 11:33:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906180837.GA8607@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Please don't quote the whole message. Everyone else has to scroll down
> a lot to find the relevant information. Thanks!
> 

Will keep that in mind. Thanks Wolfram!
