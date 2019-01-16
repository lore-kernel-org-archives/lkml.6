Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF46C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29420214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfAPTSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:18:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:15619 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbfAPTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:18:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 11:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="292095748"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2019 11:18:47 -0800
Date:   Wed, 16 Jan 2019 11:13:05 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] selftests/resctrl: Add resctrl selftest
Message-ID: <20190116191304.GA221444@romley-ivt3.sc.intel.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
 <09e6d4f2-94c8-918c-4d54-0000c3d809b2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e6d4f2-94c8-918c-4d54-0000c3d809b2@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:54:07PM +0000, Moger, Babu wrote:
> Hi Fenghua/Sai/Arshiya,
>   We were thinking of updating these selftests to work on both Intel and
> AMD. What do you guys think?
> 
> If that is ok, I can update these patches and resubmit. If you have
> already updated, please post the latest series. I will use the latest
> version. Please let me know.
> Thanks

Hi, Babu,

Sure. Please go ahead to update the selftests to work on both Intel and AMD.
That's wonderful for resctrl overall.

We do plan to update selftest and add resctrl fs interface testing. But
as of now we don't have updated selftest yet. Please work on the v4 patch
set.

Thanks.

-Fenghua

