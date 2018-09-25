Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59801C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC19820870
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC19820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeIYNGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:06:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:26231 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbeIYNGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:06:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 23:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="94565063"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by orsmga002.jf.intel.com with ESMTP; 24 Sep 2018 23:59:55 -0700
Subject: Re: [LKP] [mm, oom] 6209f6fc62: general_protection_fault:#[##]
To:     Michal Hocko <mhocko@kernel.org>
Cc:     lkp@01.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180925054820.GC27173@shao2-debian>
 <20180925060653.GN18685@dhcp22.suse.cz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <084cf8cd-f384-8694-16c0-d1e2abfb9099@intel.com>
Date:   Tue, 25 Sep 2018 15:00:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180925060653.GN18685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/25/2018 02:06 PM, Michal Hocko wrote:
> On Tue 25-09-18 13:48:20, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 6209f6fc62835d84c2a92d237588a114e39436ce ("mm, oom: rework mmap_exit vs. oom_reaper synchronization")
>> https://github.com/0day-ci/linux UPDATE-20180911-024633/Tetsuo-Handa/mm-oom-Fix-unnecessary-killing-of-additional-processes/20180910-163452
> Do you have a msg-id to the patch that has been tested?

message_id: 20180910125513.311-2-mhocko@kernel.org

Best Regards,
Rong Chen
