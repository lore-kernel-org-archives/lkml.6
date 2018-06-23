Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7BD24B20
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7BD24B20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbeFWEB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 00:01:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:26671 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeFWEB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 00:01:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 21:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,260,1526367600"; 
   d="scan'208";a="49256494"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2018 21:01:55 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fWZkI-000Dv9-Ci; Sat, 23 Jun 2018 12:01:54 +0800
Date:   Sat, 23 Jun 2018 12:01:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     kbuild-all@01.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org,
        jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 3/3] iommu/amd: Add support for IOMMU XT mode
Message-ID: <201806231014.Os3JIL8Q%fengguang.wu@intel.com>
References: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.18-rc1 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suravee-Suthikulpanit/iommu-amd-Enable-x2APIC-support/20180623-032902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
