Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08859ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC84208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC84208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeJRRDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:03:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:53891 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbeJRRDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:03:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 02:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="83585581"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2018 02:03:41 -0700
Subject: Re: [kbuild-all] [PATCH RT] rt: convert mm/kasan/quarantine_lock to
 raw_spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kbuild test robot <lkp@intel.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
References: <20180918152931.17322-1-williams@redhat.com>
 <201809190442.itGUBZK3%fengguang.wu@intel.com>
 <20181005163754.2eexrmhzvdltswdr@linutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <83c8a7a7-00be-b29b-fa2e-be9c8276be94@intel.com>
Date:   Thu, 18 Oct 2018 17:04:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181005163754.2eexrmhzvdltswdr@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2018 12:37 AM, Sebastian Andrzej Siewior wrote:
> On 2018-09-19 04:34:50 [+0800], kbuild test robot wrote:
>> Hi Clark,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linux-rt-devel/for-kbuild-bot/current-stable]
>>
>> url:    https://github.com/0day-ci/linux/commits/Clark-Williams/rt-convert-mm-kasan-quarantine_lock-to-raw_spinlock/20180919-021343
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git for-kbuild-bot/current-stable
>> config: x86_64-allmodconfig (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
> how is this related? Could someone please explain this.
>
>
It Iooks like a kbuild issue, we will looking into it.

Best Regards,
Rong Chen
