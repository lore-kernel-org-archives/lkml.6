Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEEDECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98201214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98201214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeIRPp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:45:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:35728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeIRPp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:45:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 03:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="gz'50?scan'50,208,50";a="75240916"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 18 Sep 2018 03:13:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g2D14-000ENy-SR; Tue, 18 Sep 2018 18:13:58 +0800
Date:   Tue, 18 Sep 2018 18:13:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild-all@01.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 7/7] regulator: bd718xx: rename bd71837 to 718xx
Message-ID: <201809181853.7HyPgIo6%fengguang.wu@intel.com>
References: <6b3e7b3aeef67d85083f49894e0b0fe482fc08c4.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <6b3e7b3aeef67d85083f49894e0b0fe482fc08c4.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matti,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on regulator/for-next]
[also build test ERROR on next-20180913]
[cannot apply to v4.19-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/regulator-mfd-dt_bindings-bd718x7-Support-ROHM-bd71847/20180914-210454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: x86_64-randconfig-s4-09181517 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

>> drivers/regulator/bd718x7-regulator.c:364:16: error: implicit declaration of function 'of_match_ptr'; did you mean 'hash_ptr'? [-Werror=implicit-function-declaration]
       .of_match = of_match_ptr("BUCK1"),
                   ^~~~~~~~~~~~
                   hash_ptr
>> drivers/regulator/bd718x7-regulator.c:364:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/regulator/bd718x7-regulator.c:364:16: note: (near initialization for 'bd71847_regulators[0].desc.of_match')
>> drivers/regulator/bd718x7-regulator.c:364:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:364:16: note: (near initialization for 'bd71847_regulators[0].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:365:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:365:23: note: (near initialization for 'bd71847_regulators[0].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:365:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:365:23: note: (near initialization for 'bd71847_regulators[0].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:388:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK2"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:388:16: note: (near initialization for 'bd71847_regulators[1].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:388:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:388:16: note: (near initialization for 'bd71847_regulators[1].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:389:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:389:23: note: (near initialization for 'bd71847_regulators[1].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:389:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:389:23: note: (near initialization for 'bd71847_regulators[1].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:411:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK3"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:411:16: note: (near initialization for 'bd71847_regulators[2].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:411:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:411:16: note: (near initialization for 'bd71847_regulators[2].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:412:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:412:23: note: (near initialization for 'bd71847_regulators[2].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:412:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:412:23: note: (near initialization for 'bd71847_regulators[2].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:438:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK4"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:438:16: note: (near initialization for 'bd71847_regulators[3].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:438:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:438:16: note: (near initialization for 'bd71847_regulators[3].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:439:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:439:23: note: (near initialization for 'bd71847_regulators[3].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:439:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:439:23: note: (near initialization for 'bd71847_regulators[3].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:465:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK5"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:465:16: note: (near initialization for 'bd71847_regulators[4].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:465:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:465:16: note: (near initialization for 'bd71847_regulators[4].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:466:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:466:23: note: (near initialization for 'bd71847_regulators[4].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:466:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:466:23: note: (near initialization for 'bd71847_regulators[4].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:487:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("BUCK6"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:487:16: note: (near initialization for 'bd71847_regulators[5].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:487:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:487:16: note: (near initialization for 'bd71847_regulators[5].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:488:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:488:23: note: (near initialization for 'bd71847_regulators[5].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:488:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:488:23: note: (near initialization for 'bd71847_regulators[5].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:511:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("LDO1"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:511:16: note: (near initialization for 'bd71847_regulators[6].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:511:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:511:16: note: (near initialization for 'bd71847_regulators[6].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:512:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:512:23: note: (near initialization for 'bd71847_regulators[6].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:512:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:512:23: note: (near initialization for 'bd71847_regulators[6].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:537:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("LDO2"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:537:16: note: (near initialization for 'bd71847_regulators[7].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:537:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:537:16: note: (near initialization for 'bd71847_regulators[7].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:538:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:538:23: note: (near initialization for 'bd71847_regulators[7].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:538:23: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:538:23: note: (near initialization for 'bd71847_regulators[7].desc.regulators_node')
   drivers/regulator/bd718x7-regulator.c:559:16: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .of_match = of_match_ptr("LDO3"),
                   ^~~~~~~~~~~~
   drivers/regulator/bd718x7-regulator.c:559:16: note: (near initialization for 'bd71847_regulators[8].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:559:16: error: initializer element is not constant
   drivers/regulator/bd718x7-regulator.c:559:16: note: (near initialization for 'bd71847_regulators[8].desc.of_match')
   drivers/regulator/bd718x7-regulator.c:560:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
       .regulators_node = of_match_ptr("regulators"),
                          ^~~~~~~~~~~~

vim +364 drivers/regulator/bd718x7-regulator.c

41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  359  
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  360  static const struct bd718xx_regulator_data bd71847_regulators[] = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  361  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  362  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  363  			.name = "buck1",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14 @364  			.of_match = of_match_ptr("BUCK1"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  365  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  366  			.id = BD718XX_BUCK1,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  367  			.ops = &bd718xx_dvs_buck_regulator_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  368  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  369  			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  370  			.linear_ranges = bd718xx_dvs_buck_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  371  			.n_linear_ranges =
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  372  				ARRAY_SIZE(bd718xx_dvs_buck_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  373  			.vsel_reg = BD718XX_REG_BUCK1_VOLT_RUN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  374  			.vsel_mask = DVS_BUCK_RUN_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  375  			.enable_reg = BD718XX_REG_BUCK1_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  376  			.enable_mask = BD718XX_BUCK_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  377  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  378  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  379  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  380  			.reg = BD718XX_REG_BUCK1_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  381  			.mask = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  382  			.val = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  383  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  384  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  385  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  386  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  387  			.name = "buck2",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  388  			.of_match = of_match_ptr("BUCK2"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  389  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  390  			.id = BD718XX_BUCK2,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  391  			.ops = &bd718xx_dvs_buck_regulator_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  392  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  393  			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  394  			.linear_ranges = bd718xx_dvs_buck_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  395  			.n_linear_ranges = ARRAY_SIZE(bd718xx_dvs_buck_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  396  			.vsel_reg = BD718XX_REG_BUCK2_VOLT_RUN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  397  			.vsel_mask = DVS_BUCK_RUN_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  398  			.enable_reg = BD718XX_REG_BUCK2_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  399  			.enable_mask = BD718XX_BUCK_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  400  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  401  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  402  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  403  			.reg = BD718XX_REG_BUCK2_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  404  			.mask = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  405  			.val = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  406  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  407  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  408  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  409  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  410  			.name = "buck3",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  411  			.of_match = of_match_ptr("BUCK3"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  412  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  413  			.id = BD718XX_BUCK3,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  414  			.ops = &bd718xx_pickable_range_buck_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  415  			.type = REGULATOR_VOLTAGE,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  416  			.n_voltages = BD71847_BUCK3_VOLTAGE_NUM,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  417  			.linear_ranges = bd71847_buck3_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  418  			.n_linear_ranges =
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  419  				ARRAY_SIZE(bd71847_buck3_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  420  			.vsel_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  421  			.vsel_mask = BD718XX_1ST_NODVS_BUCK_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  422  			.vsel_range_reg = BD718XX_REG_1ST_NODVS_BUCK_VOLT,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  423  			.vsel_range_mask = BD71847_BUCK3_RANGE_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  424  			.linear_range_selectors = bd71847_buck3_volt_range_sel,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  425  			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  426  			.enable_mask = BD718XX_BUCK_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  427  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  428  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  429  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  430  			.reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  431  			.mask = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  432  			.val = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  433  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  434  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  435  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  436  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  437  			.name = "buck4",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  438  			.of_match = of_match_ptr("BUCK4"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  439  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  440  			.id = BD718XX_BUCK4,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  441  			.ops = &bd718xx_pickable_range_buck_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  442  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  443  			.n_voltages = BD71847_BUCK4_VOLTAGE_NUM,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  444  			.linear_ranges = bd71847_buck4_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  445  			.n_linear_ranges =
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  446  				ARRAY_SIZE(bd71847_buck4_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  447  			.enable_reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  448  			.vsel_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  449  			.vsel_mask = BD71847_BUCK4_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  450  			.vsel_range_reg = BD718XX_REG_2ND_NODVS_BUCK_VOLT,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  451  			.vsel_range_mask = BD71847_BUCK4_RANGE_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  452  			.linear_range_selectors = bd71847_buck4_volt_range_sel,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  453  			.enable_mask = BD718XX_BUCK_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  454  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  455  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  456  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  457  			.reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  458  			.mask = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  459  			.val = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  460  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  461  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  462  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  463  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  464  			.name = "buck5",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  465  			.of_match = of_match_ptr("BUCK5"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  466  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  467  			.id = BD718XX_BUCK5,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  468  			.ops = &bd718xx_buck_regulator_nolinear_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  469  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  470  			.volt_table = &bd718xx_3rd_nodvs_buck_volts[0],
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  471  			.n_voltages = ARRAY_SIZE(bd718xx_3rd_nodvs_buck_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  472  			.vsel_reg = BD718XX_REG_3RD_NODVS_BUCK_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  473  			.vsel_mask = BD718XX_3RD_NODVS_BUCK_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  474  			.enable_reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  475  			.enable_mask = BD718XX_BUCK_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  476  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  477  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  478  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  479  			.reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  480  			.mask = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  481  			.val = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  482  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  483  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  484  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  485  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  486  			.name = "buck6",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  487  			.of_match = of_match_ptr("BUCK6"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  488  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  489  			.id = BD718XX_BUCK6,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  490  			.ops = &bd718xx_buck_regulator_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  491  			.type = REGULATOR_VOLTAGE,
67534934c drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  492  			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  493  			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  494  			.n_linear_ranges =
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  495  				ARRAY_SIZE(bd718xx_4th_nodvs_buck_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  496  			.vsel_reg = BD718XX_REG_4TH_NODVS_BUCK_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  497  			.vsel_mask = BD718XX_4TH_NODVS_BUCK_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  498  			.enable_reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  499  			.enable_mask = BD718XX_BUCK_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  500  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  501  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  502  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  503  			.reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  504  			.mask = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  505  			.val = BD718XX_BUCK_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  506  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  507  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  508  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  509  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  510  			.name = "ldo1",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  511  			.of_match = of_match_ptr("LDO1"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  512  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  513  			.id = BD718XX_LDO1,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  514  			.ops = &bd718xx_pickable_range_ldo_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  515  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  516  			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  517  			.linear_ranges = bd718xx_ldo1_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  518  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo1_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  519  			.vsel_reg = BD718XX_REG_LDO1_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  520  			.vsel_mask = BD718XX_LDO1_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  521  			.vsel_range_reg = BD718XX_REG_LDO1_VOLT,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  522  			.vsel_range_mask = BD718XX_LDO1_RANGE_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  523  			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  524  			.enable_reg = BD718XX_REG_LDO1_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  525  			.enable_mask = BD718XX_LDO_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  526  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  527  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  528  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  529  			.reg = BD718XX_REG_LDO1_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  530  			.mask = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  531  			.val = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  532  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  533  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  534  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  535  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  536  			.name = "ldo2",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  537  			.of_match = of_match_ptr("LDO2"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  538  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  539  			.id = BD718XX_LDO2,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  540  			.ops = &bd718xx_ldo_regulator_nolinear_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  541  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  542  			.volt_table = &ldo_2_volts[0],
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  543  			.vsel_reg = BD718XX_REG_LDO2_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  544  			.vsel_mask = BD718XX_LDO2_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  545  			.n_voltages = ARRAY_SIZE(ldo_2_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  546  			.enable_reg = BD718XX_REG_LDO2_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  547  			.enable_mask = BD718XX_LDO_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  548  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  549  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  550  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  551  			.reg = BD718XX_REG_LDO2_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  552  			.mask = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  553  			.val = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  554  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  555  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  556  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  557  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  558  			.name = "ldo3",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  559  			.of_match = of_match_ptr("LDO3"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  560  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  561  			.id = BD718XX_LDO3,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  562  			.ops = &bd718xx_ldo_regulator_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  563  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  564  			.n_voltages = BD718XX_LDO3_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  565  			.linear_ranges = bd718xx_ldo3_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  566  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo3_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  567  			.vsel_reg = BD718XX_REG_LDO3_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  568  			.vsel_mask = BD718XX_LDO3_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  569  			.enable_reg = BD718XX_REG_LDO3_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  570  			.enable_mask = BD718XX_LDO_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  571  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  572  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  573  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  574  			.reg = BD718XX_REG_LDO3_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  575  			.mask = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  576  			.val = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  577  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  578  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  579  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  580  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  581  			.name = "ldo4",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  582  			.of_match = of_match_ptr("LDO4"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  583  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  584  			.id = BD718XX_LDO4,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  585  			.ops = &bd718xx_ldo_regulator_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  586  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  587  			.n_voltages = BD718XX_LDO4_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  588  			.linear_ranges = bd718xx_ldo4_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  589  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo4_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  590  			.vsel_reg = BD718XX_REG_LDO4_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  591  			.vsel_mask = BD718XX_LDO4_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  592  			.enable_reg = BD718XX_REG_LDO4_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  593  			.enable_mask = BD718XX_LDO_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  594  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  595  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  596  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  597  			.reg = BD718XX_REG_LDO4_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  598  			.mask = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  599  			.val = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  600  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  601  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  602  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  603  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  604  			.name = "ldo5",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  605  			.of_match = of_match_ptr("LDO5"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  606  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  607  			.id = BD718XX_LDO5,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  608  			.ops = &bd718xx_pickable_range_ldo_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  609  			.type = REGULATOR_VOLTAGE,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  610  			.n_voltages = BD71847_LDO5_VOLTAGE_NUM,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  611  			.linear_ranges = bd71847_ldo5_volts,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  612  			.n_linear_ranges = ARRAY_SIZE(bd71847_ldo5_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  613  			.vsel_reg = BD718XX_REG_LDO5_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  614  			.vsel_mask = BD71847_LDO5_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  615  			.vsel_range_reg = BD718XX_REG_LDO5_VOLT,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  616  			.vsel_range_mask = BD71847_LDO5_RANGE_MASK,
248269ce1 drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  617  			.linear_range_selectors = bd71847_ldo5_volt_range_sel,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  618  			.enable_reg = BD718XX_REG_LDO5_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  619  			.enable_mask = BD718XX_LDO_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  620  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  621  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  622  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  623  			.reg = BD718XX_REG_LDO5_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  624  			.mask = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  625  			.val = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  626  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  627  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  628  	{
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  629  		.desc = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  630  			.name = "ldo6",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  631  			.of_match = of_match_ptr("LDO6"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  632  			.regulators_node = of_match_ptr("regulators"),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  633  			.id = BD718XX_LDO6,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  634  			.ops = &bd718xx_ldo_regulator_ops,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  635  			.type = REGULATOR_VOLTAGE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  636  			.n_voltages = BD718XX_LDO6_VOLTAGE_NUM,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  637  			.linear_ranges = bd718xx_ldo6_volts,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  638  			.n_linear_ranges = ARRAY_SIZE(bd718xx_ldo6_volts),
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  639  			/* LDO6 is supplied by buck5 */
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  640  			.supply_name = "buck5",
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  641  			.vsel_reg = BD718XX_REG_LDO6_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  642  			.vsel_mask = BD718XX_LDO6_MASK,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  643  			.enable_reg = BD718XX_REG_LDO6_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  644  			.enable_mask = BD718XX_LDO_EN,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  645  			.owner = THIS_MODULE,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  646  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  647  		.init = {
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  648  			.reg = BD718XX_REG_LDO6_VOLT,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  649  			.mask = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  650  			.val = BD718XX_LDO_SEL,
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  651  		},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  652  	},
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  653  };
41b976fda drivers/regulator/bd71837-regulator.c Matti Vaittinen 2018-09-14  654  

:::::: The code at line 364 was first introduced by commit
:::::: 41b976fdab20799f28511dbbefb0c2957060545e regulator/mfd: Support ROHM BD71847 power management IC

:::::: TO: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--EeQfGwPcQSOJBaQU--
