Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72835C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC0220881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfA3D2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:28:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:63034 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfA3D2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:28:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 19:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,539,1539673200"; 
   d="scan'208";a="122438444"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.107]) ([10.239.13.107])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2019 19:28:18 -0800
Subject: Re: [kbuild-all] arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm'
 operand has impossible constraints
To:     Borislav Petkov <bp@alien8.de>, Philip Li <philip.li@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
References: <201901221204.ZqZgxRnA%fengguang.wu@intel.com>
 <20190122100815.GA26587@zn.tnic> <20190122111359.GA9888@intel.com>
 <20190122115544.GC26587@zn.tnic>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <84021d10-0711-d94e-c2d3-92cc670d8a2f@intel.com>
Date:   Wed, 30 Jan 2019 11:28:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122115544.GC26587@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/19 7:55 PM, Borislav Petkov wrote:
> On Tue, Jan 22, 2019 at 07:13:59PM +0800, Philip Li wrote:
>> thanks for the feedback, we will blacklist this. So may i understand based on
>> the thread at https://lists.01.org/pipermail/kbuild-all/2018-December/056225.html,
>> this is gcc-4.9 problem?
> AFAICT, this triggers only on gcc-4.9, 32-bit build. Or do you have
> other configurations which trigger it?


Hi Boris,

we have added it to the blacklist, and there's no other configuration 
found in the past reports.

Best Regards,
Rong Chen

