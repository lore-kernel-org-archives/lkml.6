Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9919CC31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68135217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAUHL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:11:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:12335 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfAUHL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:11:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2019 17:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,501,1539673200"; 
   d="scan'208";a="136321136"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2019 17:50:07 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1glOj1-000GUB-BF; Mon, 21 Jan 2019 09:50:07 +0800
Date:   Mon, 21 Jan 2019 09:49:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     kbuild-all@01.org, freedreno@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v8] arm64: dts: sdm845: Add gpu and gmu device nodes
Message-ID: <201901210901.DmsvvntI%fengguang.wu@intel.com>
References: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.0-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jordan-Crouse/arm64-dts-sdm845-Add-gpu-and-gmu-device-nodes/20190118-051651
config: arm64-allyesconfig
compiler: aarch64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        GCC_VERSION=8.2.0 make.cross ARCH=arm64  allyesconfig
        GCC_VERSION=8.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
