Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6153C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67372216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67372216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbeHCJQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:61959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732738AbeHCJQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 00:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="59391313"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2018 00:21:46 -0700
Subject: Re: [PATCH v2 15/18] serial: intel: Support more platform
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-16-songjun.wu@linux.intel.com>
 <20180803055709.GB32226@kroah.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <2bd3f808-ed93-ac2c-a802-957a88129e67@linux.intel.com>
Date:   Fri, 3 Aug 2018 15:21:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180803055709.GB32226@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2018 1:57 PM, Greg Kroah-Hartman wrote:
> On Fri, Aug 03, 2018 at 11:02:34AM +0800, Songjun Wu wrote:
>> Support more platform.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
> Your changelog text makes no sense, sorry.
Thanks for your comment.
I will describe it more clearly.
