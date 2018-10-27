Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393EEC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53ED2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53ED2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeJ1FMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:12:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:12744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeJ1FMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:12:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2018 13:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,433,1534834800"; 
   d="gz'50?scan'50,208,50";a="84987507"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2018 13:30:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gGVE9-000Fsz-Iu; Sun, 28 Oct 2018 04:30:33 +0800
Date:   Sun, 28 Oct 2018 04:30:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers//regulator/bd718x7-regulator.c:364:16: error: implicit
 declaration of function 'of_match_ptr'; did you mean 'hash_ptr'?
Message-ID: <201810280457.kIpnKki4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69d5b97c597307773fe6c59775a5d5a88bb7e6b3
commit: 2ece646c90c5b45dd76c76ea207a3f3459f2c472 regulator: bd718xx: rename bd71837 to 718xx
date:   4 weeks ago
config: x86_64-randconfig-s4-10280315 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 2ece646c90c5b45dd76c76ea207a3f3459f2c472
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

>> drivers//regulator/bd718x7-regulator.c:364:16: error: implicit declaration of function 'of_match_ptr'; did you mean 'hash_ptr'? [-Werror=implicit-function-declaration]
       .of_match = of_match_ptr("BUCK1"),
                   ^~~~~~~~~~~~
                   hash_ptr
>> drivers//regulator/bd718x7-regulator.c:364:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers//regulator/bd718x7-regulator.c:364:16: note: (near initialization for 'bd71847_regulators[0].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:364:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:364:16: note: (near initialization for 'bd71847_regulators[0].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:365:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:365:23: note: (near initialization for 'bd71847_regulators[0].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:365:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:365:23: note: (near initialization for 'bd71847_regulators[0].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:388:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK2"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:388:16: note: (near initialization for 'bd71847_regulators[1].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:388:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:388:16: note: (near initialization for 'bd71847_regulators[1].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:389:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:389:23: note: (near initialization for 'bd71847_regulators[1].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:389:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:389:23: note: (near initialization for 'bd71847_regulators[1].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:411:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK3"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:411:16: note: (near initialization for 'bd71847_regulators[2].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:411:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:411:16: note: (near initialization for 'bd71847_regulators[2].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:412:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:412:23: note: (near initialization for 'bd71847_regulators[2].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:412:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:412:23: note: (near initialization for 'bd71847_regulators[2].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:438:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK4"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:438:16: note: (near initialization for 'bd71847_regulators[3].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:438:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:438:16: note: (near initialization for 'bd71847_regulators[3].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:439:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:439:23: note: (near initialization for 'bd71847_regulators[3].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:439:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:439:23: note: (near initialization for 'bd71847_regulators[3].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:465:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK5"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:465:16: note: (near initialization for 'bd71847_regulators[4].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:465:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:465:16: note: (near initialization for 'bd71847_regulators[4].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:466:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:466:23: note: (near initialization for 'bd71847_regulators[4].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:466:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:466:23: note: (near initialization for 'bd71847_regulators[4].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:487:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK6"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:487:16: note: (near initialization for 'bd71847_regulators[5].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:487:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:487:16: note: (near initialization for 'bd71847_regulators[5].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:488:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:488:23: note: (near initialization for 'bd71847_regulators[5].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:488:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:488:23: note: (near initialization for 'bd71847_regulators[5].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:511:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("LDO1"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:511:16: note: (near initialization for 'bd71847_regulators[6].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:511:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:511:16: note: (near initialization for 'bd71847_regulators[6].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:512:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:512:23: note: (near initialization for 'bd71847_regulators[6].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:512:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:512:23: note: (near initialization for 'bd71847_regulators[6].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:537:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("LDO2"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:537:16: note: (near initialization for 'bd71847_regulators[7].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:537:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:537:16: note: (near initialization for 'bd71847_regulators[7].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:538:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:538:23: note: (near initialization for 'bd71847_regulators[7].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:538:23: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:538:23: note: (near initialization for 'bd71847_regulators[7].desc.regulators_node')
   drivers//regulator/bd718x7-regulator.c:559:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("LDO3"),
                   ^~~~~~~~~~~~
   drivers//regulator/bd718x7-regulator.c:559:16: note: (near initialization for 'bd71847_regulators[8].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:559:16: error: initializer element is not constant
   drivers//regulator/bd718x7-regulator.c:559:16: note: (near initialization for 'bd71847_regulators[8].desc.of_match')
   drivers//regulator/bd718x7-regulator.c:560:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]

vim +364 drivers//regulator/bd718x7-regulator.c

494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  359  
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  360  static const struct bd718xx_regulator_data bd71847_regulators[] = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  361  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  362  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  363  			.name = "buck1",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14 @364  			.of_match = of_match_ptr("BUCK1"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  365  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  366  			.id = BD718XX_BUCK1,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  367  			.ops = &bd718xx_dvs_buck_regulator_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  368  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  369  			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  370  			.linear_ranges = bd718xx_dvs_buck_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  371  			.n_linear_ranges =
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  372  				ARRAY_SIZE(bd718xx_dvs_buck_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  373  			.vsel_reg = BD718XX_REG_BUCK1_VOLT_RUN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  374  			.vsel_mask = DVS_BUCK_RUN_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  375  			.enable_reg = BD718XX_REG_BUCK1_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  376  			.enable_mask = BD718XX_BUCK_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  377  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  378  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  379  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  380  			.reg = BD718XX_REG_BUCK1_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  381  			.mask = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  382  			.val = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  383  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  384  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  385  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  386  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  387  			.name = "buck2",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  388  			.of_match = of_match_ptr("BUCK2"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  389  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  390  			.id = BD718XX_BUCK2,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  391  			.ops = &bd718xx_dvs_buck_regulator_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  392  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  393  			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  394  			.linear_ranges = bd718xx_dvs_buck_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  395  			.n_linear_ranges = ARRAY_SIZE(bd718xx_dvs_buck_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  396  			.vsel_reg = BD718XX_REG_BUCK2_VOLT_RUN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  397  			.vsel_mask = DVS_BUCK_RUN_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  398  			.enable_reg = BD718XX_REG_BUCK2_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  399  			.enable_mask = BD718XX_BUCK_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  400  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  401  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  402  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  403  			.reg = BD718XX_REG_BUCK2_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  404  			.mask = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  405  			.val = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  406  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  407  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  408  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  409  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  410  			.name = "buck3",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  411  			.of_match = of_match_ptr("BUCK3"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  412  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  413  			.id = BD718XX_BUCK3,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  414  			.ops = &bd718xx_pickable_range_buck_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  415  			.type = REGULATOR_VOLTAGE,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  416  			.n_voltages = BD71847_BUCK3_VOLTAGE_NUM,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  417  			.linear_ranges = bd71847_buck3_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  418  			.n_linear_ranges =
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  419  				ARRAY_SIZE(bd71847_buck3_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  420  			.vsel_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  421  			.vsel_mask = BD718XX_1ST_NODVS_BUCK_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  422  			.vsel_range_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  423  			.vsel_range_mask = BD71847_BUCK3_RANGE_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  424  			.linear_range_selectors = bd71847_buck3_volt_range_sel,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  425  			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  426  			.enable_mask = BD718XX_BUCK_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  427  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  428  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  429  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  430  			.reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  431  			.mask = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  432  			.val = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  433  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  434  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  435  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  436  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  437  			.name = "buck4",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  438  			.of_match = of_match_ptr("BUCK4"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  439  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  440  			.id = BD718XX_BUCK4,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  441  			.ops = &bd718xx_pickable_range_buck_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  442  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  443  			.n_voltages = BD71847_BUCK4_VOLTAGE_NUM,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  444  			.linear_ranges = bd71847_buck4_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  445  			.n_linear_ranges =
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  446  				ARRAY_SIZE(bd71847_buck4_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  447  			.enable_reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  448  			.vsel_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  449  			.vsel_mask = BD71847_BUCK4_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  450  			.vsel_range_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  451  			.vsel_range_mask = BD71847_BUCK4_RANGE_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  452  			.linear_range_selectors = bd71847_buck4_volt_range_sel,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  453  			.enable_mask = BD718XX_BUCK_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  454  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  455  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  456  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  457  			.reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  458  			.mask = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  459  			.val = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  460  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  461  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  462  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  463  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  464  			.name = "buck5",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  465  			.of_match = of_match_ptr("BUCK5"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  466  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  467  			.id = BD718XX_BUCK5,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  468  			.ops = &bd718xx_buck_regulator_nolinear_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  469  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  470  			.volt_table = &bd718xx_3rd_nodvs_buck_volts[0],
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  471  			.n_voltages = ARRAY_SIZE(bd718xx_3rd_nodvs_buck_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  472  			.vsel_reg = BD718XX_REG_3RD_NODVS_BUCK_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  473  			.vsel_mask = BD718XX_3RD_NODVS_BUCK_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  474  			.enable_reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  475  			.enable_mask = BD718XX_BUCK_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  476  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  477  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  478  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  479  			.reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  480  			.mask = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  481  			.val = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  482  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  483  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  484  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  485  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  486  			.name = "buck6",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  487  			.of_match = of_match_ptr("BUCK6"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  488  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  489  			.id = BD718XX_BUCK6,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  490  			.ops = &bd718xx_buck_regulator_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  491  			.type = REGULATOR_VOLTAGE,
dd2be639 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  492  			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  493  			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  494  			.n_linear_ranges =
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  495  				ARRAY_SIZE(bd718xx_4th_nodvs_buck_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  496  			.vsel_reg = BD718XX_REG_4TH_NODVS_BUCK_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  497  			.vsel_mask = BD718XX_4TH_NODVS_BUCK_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  498  			.enable_reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  499  			.enable_mask = BD718XX_BUCK_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  500  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  501  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  502  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  503  			.reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  504  			.mask = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  505  			.val = BD718XX_BUCK_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  506  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  507  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  508  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  509  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  510  			.name = "ldo1",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  511  			.of_match = of_match_ptr("LDO1"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  512  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  513  			.id = BD718XX_LDO1,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  514  			.ops = &bd718xx_pickable_range_ldo_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  515  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  516  			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  517  			.linear_ranges = bd718xx_ldo1_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  518  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo1_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  519  			.vsel_reg = BD718XX_REG_LDO1_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  520  			.vsel_mask = BD718XX_LDO1_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  521  			.vsel_range_reg = BD718XX_REG_LDO1_VOLT,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  522  			.vsel_range_mask = BD718XX_LDO1_RANGE_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  523  			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  524  			.enable_reg = BD718XX_REG_LDO1_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  525  			.enable_mask = BD718XX_LDO_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  526  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  527  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  528  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  529  			.reg = BD718XX_REG_LDO1_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  530  			.mask = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  531  			.val = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  532  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  533  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  534  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  535  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  536  			.name = "ldo2",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  537  			.of_match = of_match_ptr("LDO2"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  538  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  539  			.id = BD718XX_LDO2,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  540  			.ops = &bd718xx_ldo_regulator_nolinear_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  541  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  542  			.volt_table = &ldo_2_volts[0],
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  543  			.vsel_reg = BD718XX_REG_LDO2_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  544  			.vsel_mask = BD718XX_LDO2_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  545  			.n_voltages = ARRAY_SIZE(ldo_2_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  546  			.enable_reg = BD718XX_REG_LDO2_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  547  			.enable_mask = BD718XX_LDO_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  548  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  549  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  550  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  551  			.reg = BD718XX_REG_LDO2_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  552  			.mask = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  553  			.val = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  554  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  555  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  556  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  557  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  558  			.name = "ldo3",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  559  			.of_match = of_match_ptr("LDO3"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  560  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  561  			.id = BD718XX_LDO3,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  562  			.ops = &bd718xx_ldo_regulator_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  563  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  564  			.n_voltages = BD718XX_LDO3_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  565  			.linear_ranges = bd718xx_ldo3_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  566  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo3_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  567  			.vsel_reg = BD718XX_REG_LDO3_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  568  			.vsel_mask = BD718XX_LDO3_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  569  			.enable_reg = BD718XX_REG_LDO3_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  570  			.enable_mask = BD718XX_LDO_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  571  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  572  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  573  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  574  			.reg = BD718XX_REG_LDO3_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  575  			.mask = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  576  			.val = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  577  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  578  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  579  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  580  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  581  			.name = "ldo4",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  582  			.of_match = of_match_ptr("LDO4"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  583  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  584  			.id = BD718XX_LDO4,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  585  			.ops = &bd718xx_ldo_regulator_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  586  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  587  			.n_voltages = BD718XX_LDO4_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  588  			.linear_ranges = bd718xx_ldo4_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  589  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo4_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  590  			.vsel_reg = BD718XX_REG_LDO4_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  591  			.vsel_mask = BD718XX_LDO4_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  592  			.enable_reg = BD718XX_REG_LDO4_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  593  			.enable_mask = BD718XX_LDO_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  594  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  595  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  596  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  597  			.reg = BD718XX_REG_LDO4_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  598  			.mask = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  599  			.val = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  600  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  601  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  602  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  603  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  604  			.name = "ldo5",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  605  			.of_match = of_match_ptr("LDO5"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  606  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  607  			.id = BD718XX_LDO5,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  608  			.ops = &bd718xx_pickable_range_ldo_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  609  			.type = REGULATOR_VOLTAGE,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  610  			.n_voltages = BD71847_LDO5_VOLTAGE_NUM,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  611  			.linear_ranges = bd71847_ldo5_volts,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  612  			.n_linear_ranges = ARRAY_SIZE(bd71847_ldo5_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  613  			.vsel_reg = BD718XX_REG_LDO5_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  614  			.vsel_mask = BD71847_LDO5_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  615  			.vsel_range_reg = BD718XX_REG_LDO5_VOLT,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  616  			.vsel_range_mask = BD71847_LDO5_RANGE_MASK,
a4bfc2c2 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  617  			.linear_range_selectors = bd71847_ldo5_volt_range_sel,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  618  			.enable_reg = BD718XX_REG_LDO5_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  619  			.enable_mask = BD718XX_LDO_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  620  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  621  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  622  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  623  			.reg = BD718XX_REG_LDO5_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  624  			.mask = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  625  			.val = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  626  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  627  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  628  	{
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  629  		.desc = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  630  			.name = "ldo6",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  631  			.of_match = of_match_ptr("LDO6"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  632  			.regulators_node = of_match_ptr("regulators"),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  633  			.id = BD718XX_LDO6,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  634  			.ops = &bd718xx_ldo_regulator_ops,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  635  			.type = REGULATOR_VOLTAGE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  636  			.n_voltages = BD718XX_LDO6_VOLTAGE_NUM,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  637  			.linear_ranges = bd718xx_ldo6_volts,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  638  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo6_volts),
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  639  			/* LDO6 is supplied by buck5 */
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  640  			.supply_name = "buck5",
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  641  			.vsel_reg = BD718XX_REG_LDO6_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  642  			.vsel_mask = BD718XX_LDO6_MASK,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  643  			.enable_reg = BD718XX_REG_LDO6_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  644  			.enable_mask = BD718XX_LDO_EN,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  645  			.owner = THIS_MODULE,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  646  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  647  		.init = {
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  648  			.reg = BD718XX_REG_LDO6_VOLT,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  649  			.mask = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  650  			.val = BD718XX_LDO_SEL,
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  651  		},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  652  	},
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  653  };
494edd26 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  654  

:::::: The code at line 364 was first introduced by commit
:::::: 494edd266b945f36908184433dd36eda1719cdb0 regulator/mfd: Support ROHM BD71847 power management IC

:::::: TO: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
eTLA1b0TCQC6cPJ//XqI6DrPAQA=

--vtzGhvizbBRQ85DL--
