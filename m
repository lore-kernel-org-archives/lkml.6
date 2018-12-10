Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031BBC67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3942081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3942081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeLJEXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:23:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:6513 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeLJEXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:23:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 20:23:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="106195606"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2018 20:23:32 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gWD6S-0009Ly-2H; Mon, 10 Dec 2018 12:23:32 +0800
Date:   Mon, 10 Dec 2018 12:23:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     kbuild-all@01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: chemical: add support for Sensirion SPS30
 sensor
Message-ID: <201812101217.mLlmhLgt%fengguang.wu@intel.com>
References: <20181206210443.21052-3-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206210443.21052-3-tduszyns@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.20-rc6 next-20181207]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Duszynski/add-support-for-Sensirion-SPS30-PM-sensor/20181209-204432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg


coccinelle warnings: (new ones prefixed by >>)

>> drivers/iio/chemical/sps30.c:115:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
