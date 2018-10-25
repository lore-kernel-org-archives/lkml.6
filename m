Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7746C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7672082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7672082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJZEL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:11:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:9394 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeJZEL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:11:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 12:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="gz'50?scan'50,208,50";a="102688931"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2018 12:37:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gFlRW-00037t-NQ; Fri, 26 Oct 2018 03:37:18 +0800
Date:   Fri, 26 Oct 2018 03:37:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/regulator/bd718x7-regulator.c:364:4: error: implicit
 declaration of function 'of_match_ptr'
Message-ID: <201810260303.WnRwh7WI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   01aa9d518eae8a4d75cd3049defc6ed0b6d0a658
commit: 2ece646c90c5b45dd76c76ea207a3f3459f2c472 regulator: bd718xx: rename bd71837 to 718xx
date:   4 weeks ago
config: x86_64-randconfig-g0-10260315 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 2ece646c90c5b45dd76c76ea207a3f3459f2c472
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/regulator/bd718x7-regulator.c:364:4: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
       .of_match = of_match_ptr("BUCK1"),
       ^
>> drivers/regulator/bd718x7-regulator.c:364:4: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:364:4: error: (near initialization for 'bd71847_regulators[0].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:365:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:365:4: error: (near initialization for 'bd71847_regulators[0].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:388:4: error: initializer element is not constant
       .of_match = of_match_ptr("BUCK2"),
       ^
   drivers/regulator/bd718x7-regulator.c:388:4: error: (near initialization for 'bd71847_regulators[1].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:389:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:389:4: error: (near initialization for 'bd71847_regulators[1].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:411:4: error: initializer element is not constant
       .of_match = of_match_ptr("BUCK3"),
       ^
   drivers/regulator/bd718x7-regulator.c:411:4: error: (near initialization for 'bd71847_regulators[2].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:412:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:412:4: error: (near initialization for 'bd71847_regulators[2].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:438:4: error: initializer element is not constant
       .of_match = of_match_ptr("BUCK4"),
       ^
   drivers/regulator/bd718x7-regulator.c:438:4: error: (near initialization for 'bd71847_regulators[3].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:439:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:439:4: error: (near initialization for 'bd71847_regulators[3].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:465:4: error: initializer element is not constant
       .of_match = of_match_ptr("BUCK5"),
       ^
   drivers/regulator/bd718x7-regulator.c:465:4: error: (near initialization for 'bd71847_regulators[4].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:466:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:466:4: error: (near initialization for 'bd71847_regulators[4].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:487:4: error: initializer element is not constant
       .of_match = of_match_ptr("BUCK6"),
       ^
   drivers/regulator/bd718x7-regulator.c:487:4: error: (near initialization for 'bd71847_regulators[5].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:488:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:488:4: error: (near initialization for 'bd71847_regulators[5].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:511:4: error: initializer element is not constant
       .of_match = of_match_ptr("LDO1"),
       ^
   drivers/regulator/bd718x7-regulator.c:511:4: error: (near initialization for 'bd71847_regulators[6].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:512:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:512:4: error: (near initialization for 'bd71847_regulators[6].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:537:4: error: initializer element is not constant
       .of_match = of_match_ptr("LDO2"),
       ^
   drivers/regulator/bd718x7-regulator.c:537:4: error: (near initialization for 'bd71847_regulators[7].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:538:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:538:4: error: (near initialization for 'bd71847_regulators[7].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:559:4: error: initializer element is not constant
       .of_match = of_match_ptr("LDO3"),
       ^
   drivers/regulator/bd718x7-regulator.c:559:4: error: (near initialization for 'bd71847_regulators[8].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:560:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:560:4: error: (near initialization for 'bd71847_regulators[8].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:582:4: error: initializer element is not constant
       .of_match = of_match_ptr("LDO4"),
       ^
   drivers/regulator/bd718x7-regulator.c:582:4: error: (near initialization for 'bd71847_regulators[9].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:583:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:583:4: error: (near initialization for 'bd71847_regulators[9].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:605:4: error: initializer element is not constant
       .of_match = of_match_ptr("LDO5"),
       ^
   drivers/regulator/bd718x7-regulator.c:605:4: error: (near initialization for 'bd71847_regulators[10].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:606:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:606:4: error: (near initialization for 'bd71847_regulators[10].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:631:4: error: initializer element is not constant
       .of_match = of_match_ptr("LDO6"),
       ^
   drivers/regulator/bd718x7-regulator.c:631:4: error: (near initialization for 'bd71847_regulators[11].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:632:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^
   drivers/regulator/bd718x7-regulator.c:632:4: error: (near initialization for 'bd71847_regulators[11].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:659:4: error: initializer element is not constant
       .of_match = of_match_ptr("BUCK1"),
       ^
   drivers/regulator/bd718x7-regulator.c:659:4: error: (near initialization for 'bd71837_regulators[0].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:660:4: error: initializer element is not constant
       .regulators_node = of_match_ptr("regulators"),
       ^

vim +/of_match_ptr +364 drivers/regulator/bd718x7-regulator.c

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

--ew6BAiZeqk4r7MaW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ew6BAiZeqk4r7MaW--
