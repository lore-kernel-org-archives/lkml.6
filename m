Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FAFECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881272082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881272082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeJ0Tks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 15:40:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:37277 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbeJ0Tkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 15:40:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2018 04:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,431,1534834800"; 
   d="scan'208";a="91667124"
Received: from rwang-mobl4.amr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.211.80])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2018 04:00:04 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gGMK3-0001Rf-G0; Sat, 27 Oct 2018 19:00:03 +0800
Date:   Sat, 27 Oct 2018 19:00:03 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com,
        thomas.lendacky@amd.com, akpm@linux-foundation.org,
        mhocko@suse.com, linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
Message-ID: <20181027110003.5opfjr7q36rhumah@wfg-t540p.sh.intel.com>
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

What's the base tree for this patchset? I tried 4.19, linux-next and
Dan's libnvdimm-for-next branch, but none applies cleanly.

Thanks,
Fengguang
