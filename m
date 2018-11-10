Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B206E214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B206E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeKKIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:32:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:31819 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeKKIcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:32:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2018 14:45:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,489,1534834800"; 
   d="scan'208";a="248709833"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2018 14:45:48 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gLc0h-000GM1-Rz; Sun, 11 Nov 2018 06:45:47 +0800
Date:   Sun, 11 Nov 2018 06:44:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kbuild-all@01.org, alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, christian.ehrhardt@canonical.com
Subject: Re: [PATCH] vfio/pci: Parallelize device open and release
Message-ID: <201811110624.k0DEwdIm%fengguang.wu@intel.com>
References: <154180134334.31154.16289123769826098135.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154180134334.31154.16289123769826098135.stgit@gimli.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I love your patch! Perhaps something to improve:

[auto build test WARNING on vfio/next]
[also build test WARNING on v4.20-rc1 next-20181109]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alex-Williamson/vfio-pci-Parallelize-device-open-and-release/20181111-025016
base:   https://github.com/awilliam/linux-vfio.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/vfio/pci/vfio_pci.c:1396:8-14: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
