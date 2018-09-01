Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1420841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F1420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIAP5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 11:57:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:46657 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeIAP5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 11:57:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 04:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,315,1531810800"; 
   d="gz'50?scan'50,208,50";a="259904473"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2018 04:46:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fw4Kh-000FDm-66; Sat, 01 Sep 2018 19:44:51 +0800
Date:   Sat, 1 Sep 2018 19:43:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     kbuild-all@01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v5 2/2] clk: Add functions to get optional clocks
Message-ID: <201809011734.dCcCNJQY%fengguang.wu@intel.com>
References: <1535724443-21150-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1535724443-21150-3-git-send-email-phil.edworthy@renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Phil,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Phil-Edworthy/clk-Add-functions-to-get-optional-clocks/20180901-154009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: m68k-m5475evb_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   drivers/clk/clk-devres.o: In function `__devm_clk_get':
>> clk-devres.c:(.text+0xb6): undefined reference to `clk_get_optional'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--45Z9DzgjV8m4Oswq--
