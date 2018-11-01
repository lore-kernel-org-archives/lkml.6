Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF036C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FA6205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FA6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeKBBHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:07:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:19711 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbeKBBHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:07:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 09:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,452,1534834800"; 
   d="gz'50?scan'50,208,50";a="246224291"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2018 09:04:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gIFS1-000HZ2-80; Fri, 02 Nov 2018 00:04:05 +0800
Date:   Fri, 2 Nov 2018 00:03:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     thesven73@gmail.com
Cc:     kbuild-all@01.org, svendev@arcx.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v2 5/5] misc: support HMS Profinet IRT industrial
 controller.
Message-ID: <201811020019.v11QNaH7%fengguang.wu@intel.com>
References: <20181031194425.32132-6-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20181031194425.32132-6-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sven,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.19 next-20181101]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/thesven73-gmail-com/Support-HMS-Profinet-Card-over-Anybus/20181101-225600
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> ./usr/include/linux/hms-profinet.h:10: include of <linux/types.h> is preferred over <asm/types.h>
>> ./usr/include/linux/hms-profinet.h:18: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/AdhkdoerVoAAA==

--vtzGhvizbBRQ85DL--
