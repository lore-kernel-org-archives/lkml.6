Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F31C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F662082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F662082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJ3KqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:46:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:64959 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbeJ3KqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:46:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 18:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,442,1534834800"; 
   d="scan'208";a="245433275"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2018 18:54:47 -0700
Received: from [10.251.20.185] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DC7405803FA;
        Mon, 29 Oct 2018 18:54:45 -0700 (PDT)
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
References: <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
 <20181029183258.GL21857@kernel.org>
 <097fb051-25e3-cdb6-570b-22c2e9f83861@linux.intel.com>
 <20181029.154226.179933039670602298.davem@davemloft.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3ea21329-48ec-c353-2cfc-659fbf85421b@linux.intel.com>
Date:   Mon, 29 Oct 2018 21:54:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029.154226.179933039670602298.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 6:42 PM, David Miller wrote:
> From: "Liang, Kan" <kan.liang@linux.intel.com>
> Date: Mon, 29 Oct 2018 18:32:40 -0400
> 
>> -				  struct annotation_options *annotation_options __maybe_unused)
>> + struct annotation_options *annotation_options __maybe_unused,
>> +				  atomic_t *nr_rb_read __maybe_unused)
>>   {
> 
> What is going on with the indentations of this patch?
> 

Sorry, my editor auto wraps the line.
The patch has been sent in a separate email.

Thanks,
Kan
