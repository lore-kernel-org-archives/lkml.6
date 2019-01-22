Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC45C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AF220854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfAVHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:04:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:6359 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVHEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:04:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 23:04:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; 
   d="scan'208";a="127583648"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2019 23:04:11 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1glq6V-000F6X-Bu; Tue, 22 Jan 2019 15:04:11 +0800
Date:   Tue, 22 Jan 2019 15:03:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     sean.wang@mediatek.com
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: Add protocol support for
 MediaTek MT7668U USB devices
Message-ID: <201901221525.vm7lvaSU%fengguang.wu@intel.com>
References: <508f1c6ddf2e7d2a88d267e418159e929bf133c5.1547849398.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508f1c6ddf2e7d2a88d267e418159e929bf133c5.1547849398.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v5.0-rc2 next-20190116]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/Bluetooth-btusb-Add-protocol-support-for-MediaTek-MT7668U-USB-devices/20190122-041846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btusb.c:2683:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
