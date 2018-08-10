Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2855A22404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2855A22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeHJN6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:58:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:1305 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeHJN6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:58:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 04:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,219,1531810800"; 
   d="scan'208";a="64134312"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2018 04:28:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fo5ai-000Dne-Nn; Fri, 10 Aug 2018 19:28:24 +0800
Date:   Fri, 10 Aug 2018 19:27:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     kbuild-all@01.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: fbtft: Moves ";" from macro definition to
 macro usage.
Message-ID: <201808101921.Ee4K5ZhN%fengguang.wu@intel.com>
References: <d3d79581fccabb25174f5679415c2f985d1271a4.1533857298.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d79581fccabb25174f5679415c2f985d1271a4.1533857298.git.leobras.c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v4.18-rc8 next-20180809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Leonardo-Br-s/staging-fbtft-Moves-from-macro-definition-to-macro-usage/20180810-154004
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/fbtft/fbtft-bus.c:66:1: sparse: incorrect type in assignment (different base types) @@    expected restricted __be16 [usertype] <noident> @@    got unsignedrestricted __be16 [usertype] <noident> @@
   drivers/staging/fbtft/fbtft-bus.c:66:1:    expected restricted __be16 [usertype] <noident>
   drivers/staging/fbtft/fbtft-bus.c:66:1:    got unsigned short [unsigned] [usertype] <noident>
>> drivers/staging/fbtft/fbtft-bus.c:66:1: sparse: incorrect type in assignment (different base types) @@    expected restricted __be16 [usertype] <noident> @@    got unsignedrestricted __be16 [usertype] <noident> @@
   drivers/staging/fbtft/fbtft-bus.c:66:1:    expected restricted __be16 [usertype] <noident>
   drivers/staging/fbtft/fbtft-bus.c:66:1:    got unsigned short [unsigned] [usertype] <noident>
>> drivers/staging/fbtft/fbtft-bus.c:66:1: sparse: incorrect type in assignment (different base types) @@    expected restricted __be16 [usertype] <noident> @@    got unsignedrestricted __be16 [usertype] <noident> @@
   drivers/staging/fbtft/fbtft-bus.c:66:1:    expected restricted __be16 [usertype] <noident>
   drivers/staging/fbtft/fbtft-bus.c:66:1:    got unsigned short [unsigned] [usertype] <noident>
   drivers/staging/fbtft/fbtft-bus.c:156:27: sparse: expression using sizeof(void)
   drivers/staging/fbtft/fbtft-bus.c:156:27: sparse: expression using sizeof(void)
   drivers/staging/fbtft/fbtft-bus.c:200:27: sparse: expression using sizeof(void)
   drivers/staging/fbtft/fbtft-bus.c:200:27: sparse: expression using sizeof(void)

vim +66 drivers/staging/fbtft/fbtft-bus.c

    64	
    65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, );
  > 66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, );
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, );
    68	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
