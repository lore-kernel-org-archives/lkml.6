Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 04:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E5720881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 04:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeIOKFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:05:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:18822 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeIOKFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:05:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 21:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,375,1531810800"; 
   d="scan'208";a="233076452"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.76.78]) ([10.254.76.78])
  by orsmga004.jf.intel.com with ESMTP; 14 Sep 2018 21:47:59 -0700
Subject: Re: [PATCH 4/9] x86/intel_rdt: Fix invalid mode warning when
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
 <1536957129-70380-5-git-send-email-fenghua.yu@intel.com>
 <16d5173e-080e-9a4b-bdbb-16101a774d91@intel.com>
Message-ID: <3bea56ac-43d0-276f-7bb1-4a6a60ea5a6c@intel.com>
Date:   Fri, 14 Sep 2018 21:47:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <16d5173e-080e-9a4b-bdbb-16101a774d91@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2018 9:36 PM, Reinette Chatre wrote:
> On 9/14/2018 1:32 PM, Fenghua Yu wrote:
>> From: Reinette Chatre <reinette.chatre@intel.com>
>>
>> multiple resources are managed
> 
> The above snippet is redundant. We can remove it in the next version.

Apologies, I responded too fast. The subject intended to read:
x86/intel_rdt: Fix invalid mode warning when multiple resources are managed

Reinette

