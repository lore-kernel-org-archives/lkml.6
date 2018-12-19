Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2DF218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeLSKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:03:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:62621 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbeLSKDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:03:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 02:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="305048790"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2018 02:03:33 -0800
Subject: Re: [LKP] 5404a7f1c2 [ 90.902541] watchdog: BUG: soft lockup - CPU#0
 stuck for 22s! [swapper:1]
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20181218002028.GG23332@shao2-debian>
 <20181218121710.GT10600@bombadil.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <38ee8a35-1bb3-7a63-8ef6-75f0ff46d198@intel.com>
Date:   Wed, 19 Dec 2018 18:03:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181218121710.GT10600@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2018 08:17 PM, Matthew Wilcox wrote:
> On Tue, Dec 18, 2018 at 08:20:28AM +0800, kernel test robot wrote:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit 5404a7f1c21cfda061712bedf2d06cc0f6c755e9
> I feel like you're wasting my time.  This is the fourth time in a row
> you've reported something I can't reproduce.  At least this time the
> instructions work, but I've tried it a dozen times and it doesn't produce
> the error you're showing.
>
> $ git branch
> * (HEAD detached at 5404a7f1c21c)
> ...
> [    0.000000] Linux version 4.20.0-rc1-00012-g5404a7f1c21c (willy@bobo) (gcc version 8.2.0 (Debian 8.2.0-9)) #4 Mon Dec 17 23:28:21 EST 2018
> ...
> [    9.848471] test_uuid: all 18 tests passed
> [   11.019267] XArray: 19496249 of 19496249 tests passed
>
> Your logs show it failing every time.  I can't help but wonder if it's
> something else in your setup that's causing it to fail -- maybe the
> machines doing the testing are overloaded?

Please accept my apologies for taking your time, it might be a false 
positive,
we have uploaded the original 
bzImage(https://download.01.org/0day-ci/lkp-qemu/fbc/5404a7f1c21cfda061712bedf2d06cc0f6c755e9/) 
for your reference.

Best Regards,
Rong Chen
