Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA38C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 00:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A452189B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 00:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A452189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeHMDPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 23:15:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:58989 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeHMDPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 23:15:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2018 17:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,231,1531810800"; 
   d="scan'208";a="61892616"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2018 17:35:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fp0ot-000FCb-VD; Mon, 13 Aug 2018 08:34:51 +0800
Date:   Mon, 13 Aug 2018 08:35:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     linux-kernel-owner@vger.kernel.org
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: mediatek: Add protocol support for
 MediaTek MT7668U USB devices
Message-ID: <201808130807.Y9VO6O2r%fengguang.wu@intel.com>
References: <d976d455588eb0e3007cee1c3447e0455a06573e.1534062988.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d976d455588eb0e3007cee1c3447e0455a06573e.1534062988.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v4.18 next-20180810]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/linux-kernel-owner-vger-kernel-org/Bluetooth-mediatek-Add-protocol-support-for-MediaTek-MT7668U-USB-devices/20180813-043802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btmtk.c:86:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
