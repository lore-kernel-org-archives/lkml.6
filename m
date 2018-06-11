Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kWlBKO+kHltfYAAAmS7hNA
	; Mon, 11 Jun 2018 16:36:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D165560792; Mon, 11 Jun 2018 16:36:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C82B560351;
	Mon, 11 Jun 2018 16:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C82B560351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933686AbeFKQgM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:36:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:45499 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932703AbeFKQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:36:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 09:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="48125573"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2018 09:36:08 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fSPnb-000U75-Ut; Tue, 12 Jun 2018 00:36:07 +0800
Date: Tue, 12 Jun 2018 00:35:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: kbuild-all@01.org, davem@davemloft.net, tobin@apporbit.com,
        Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/6] arcnet: com20020: Add com20020 io mapped version
Message-ID: <201806120034.bUpoIKOC%fengguang.wu@intel.com>
References: <20180611142635.20712-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611142635.20712-1-andrea.greco.gapmilano@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrea-Greco/arcnet-leds-Removed-leds-dependecy/20180611-222941
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/arcnet/com20020-io.c:34:45: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got sn:2>*<noident> @@
   drivers/net/arcnet/com20020-io.c:34:45:    expected void [noderef] <asn:2>*<noident>
   drivers/net/arcnet/com20020-io.c:34:45:    got void *
   drivers/net/arcnet/com20020-io.c:39:45: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got sn:2>*<noident> @@
   drivers/net/arcnet/com20020-io.c:39:45:    expected void [noderef] <asn:2>*<noident>
   drivers/net/arcnet/com20020-io.c:39:45:    got void *
>> drivers/net/arcnet/com20020-io.c:44:22: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2>*port @@    got void [noderef] <asn:2>*port @@
   drivers/net/arcnet/com20020-io.c:44:22:    expected void [noderef] <asn:2>*port
   drivers/net/arcnet/com20020-io.c:44:22:    got void *[noderef] <asn:2><noident>
   drivers/net/arcnet/com20020-io.c:49:23: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2>*port @@    got void [noderef] <asn:2>*port @@
   drivers/net/arcnet/com20020-io.c:49:23:    expected void [noderef] <asn:2>*port
   drivers/net/arcnet/com20020-io.c:49:23:    got void *[noderef] <asn:2><noident>
>> drivers/net/arcnet/com20020-io.c:219:19: sparse: cast removes address space of expression
   drivers/net/arcnet/com20020-io.c: In function 'io_arc_inb':
   drivers/net/arcnet/com20020-io.c:34:17: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     return ioread8((void *__iomem) addr + offset);
                    ^
   drivers/net/arcnet/com20020-io.c: In function 'io_arc_outb':
   drivers/net/arcnet/com20020-io.c:39:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8(value, (void *__iomem)addr + offset);
                     ^
   drivers/net/arcnet/com20020-io.c: In function 'io_arc_insb':
   drivers/net/arcnet/com20020-io.c:44:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8_rep((void *__iomem) (addr + offset), buffer, count);
                 ^
   drivers/net/arcnet/com20020-io.c: In function 'io_arc_outsb':
   drivers/net/arcnet/com20020-io.c:49:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8_rep((void *__iomem) (addr + offset), buffer, count);
                  ^
   drivers/net/arcnet/com20020-io.c: In function 'com20020_probe':
   drivers/net/arcnet/com20020-io.c:219:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     ioaddr = (int)devm_ioremap(&pdev->dev, iores->start,
              ^
   drivers/net/arcnet/com20020-io.c:288:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     devm_iounmap(&pdev->dev, (void __iomem *)ioaddr);
                              ^

vim +34 drivers/net/arcnet/com20020-io.c

    31	
    32	static unsigned int io_arc_inb(int addr, int offset)
    33	{
  > 34		return ioread8((void *__iomem) addr + offset);
    35	}
    36	
    37	static void io_arc_outb(int value, int addr, int offset)
    38	{
  > 39		iowrite8(value, (void *__iomem)addr + offset);
    40	}
    41	
    42	static void io_arc_insb(int  addr, int offset, void *buffer, int count)
    43	{
  > 44		ioread8_rep((void *__iomem) (addr + offset), buffer, count);
    45	}
    46	
    47	static void io_arc_outsb(int addr, int offset, void *buffer, int count)
    48	{
    49		iowrite8_rep((void *__iomem) (addr + offset), buffer, count);
    50	}
    51	
    52	enum com20020_xtal_freq {
    53		freq_10Mhz = 10,
    54		freq_20Mhz = 20,
    55	};
    56	
    57	enum com20020_arcnet_speed {
    58		arc_speed_10M_bps = 10000000,
    59		arc_speed_5M_bps = 5000000,
    60		arc_speed_2M50_bps = 2500000,
    61		arc_speed_1M25_bps = 1250000,
    62		arc_speed_625K_bps = 625000,
    63		arc_speed_312K5_bps = 312500,
    64		arc_speed_156K25_bps = 156250,
    65	};
    66	
    67	enum com20020_timeout {
    68		arc_timeout_328us =   328000,
    69		arc_timeout_164us = 164000,
    70		arc_timeout_82us =  82000,
    71		arc_timeout_20u5s =  20500,
    72	};
    73	
    74	static int setup_clock(int *clockp, int *clockm, int xtal, int arcnet_speed)
    75	{
    76		int pll_factor, req_clock_frq = 20;
    77	
    78		switch (arcnet_speed) {
    79		case arc_speed_10M_bps:
    80			req_clock_frq = 80;
    81			*clockp = 0;
    82			break;
    83		case arc_speed_5M_bps:
    84			req_clock_frq = 40;
    85			*clockp = 0;
    86			break;
    87		case arc_speed_2M50_bps:
    88			*clockp = 0;
    89			break;
    90		case arc_speed_1M25_bps:
    91			*clockp = 1;
    92			break;
    93		case arc_speed_625K_bps:
    94			*clockp = 2;
    95			break;
    96		case arc_speed_312K5_bps:
    97			*clockp = 3;
    98			break;
    99		case arc_speed_156K25_bps:
   100			*clockp = 4;
   101			break;
   102		default:
   103			return -EINVAL;
   104		}
   105	
   106		if (xtal != freq_10Mhz && xtal != freq_20Mhz)
   107			return -EINVAL;
   108	
   109		pll_factor = (unsigned int)req_clock_frq / xtal;
   110	
   111		switch (pll_factor) {
   112		case 1:
   113			*clockm = 0;
   114			break;
   115		case 2:
   116			*clockm = 1;
   117			break;
   118		case 4:
   119			*clockm = 3;
   120			break;
   121		default:
   122			return -EINVAL;
   123		}
   124	
   125		return 0;
   126	}
   127	
   128	static int setup_timeout(int *timeout)
   129	{
   130		switch (*timeout) {
   131		case arc_timeout_328us:
   132			*timeout = 0;
   133			break;
   134		case arc_timeout_164us:
   135			*timeout = 1;
   136			break;
   137		case arc_timeout_82us:
   138			*timeout = 2;
   139			break;
   140		case arc_timeout_20u5s:
   141			*timeout = 3;
   142			break;
   143		default:
   144			return -EINVAL;
   145		}
   146	
   147		return 0;
   148	}
   149	
   150	static int com20020_probe(struct platform_device *pdev)
   151	{
   152		struct device_node *np;
   153		struct net_device *dev;
   154		struct arcnet_local *lp;
   155		struct resource res, *iores;
   156		int ret, phy_reset;
   157		u32 timeout, xtal, arc_speed;
   158		int clockp, clockm;
   159		bool backplane = false;
   160		int ioaddr;
   161	
   162		np = pdev->dev.of_node;
   163	
   164		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   165	
   166		ret = of_address_to_resource(np, 0, &res);
   167		if (ret)
   168			return ret;
   169	
   170		ret = of_property_read_u32(np, "timeout-ns", &timeout);
   171		if (ret) {
   172			dev_err(&pdev->dev, "timeout is required param");
   173			return ret;
   174		}
   175	
   176		ret = of_property_read_u32(np, "smsc,xtal-mhz", &xtal);
   177		if (ret) {
   178			dev_err(&pdev->dev, "xtal-mhz is required param");
   179			return ret;
   180		}
   181	
   182		ret = of_property_read_u32(np, "bus-speed-bps", &arc_speed);
   183		if (ret) {
   184			dev_err(&pdev->dev, "Bus speed is required param");
   185			return ret;
   186		}
   187	
   188		if (of_property_read_bool(np, "smsc,backplane-enabled"))
   189			backplane = true;
   190	
   191		phy_reset = of_get_named_gpio(np, "reset-gpios", 0);
   192		if (!gpio_is_valid(phy_reset)) {
   193			dev_err(&pdev->dev, "reset gpio not valid");
   194			return phy_reset;
   195		}
   196	
   197		ret = devm_gpio_request_one(&pdev->dev, phy_reset, GPIOF_OUT_INIT_LOW,
   198					    "arcnet-reset");
   199		if (ret) {
   200			dev_err(&pdev->dev, "failed to get phy reset gpio: %d\n", ret);
   201			return ret;
   202		}
   203	
   204		dev = alloc_arcdev(NULL);
   205		dev->netdev_ops = &com20020_netdev_ops;
   206		lp = netdev_priv(dev);
   207	
   208		lp->card_flags = ARC_CAN_10MBIT;
   209	
   210		/* Peak random address,
   211		 * if required user could set a new-one in userspace
   212		 */
   213		get_random_bytes(dev->dev_addr, dev->addr_len);
   214	
   215		if (!devm_request_mem_region(&pdev->dev, res.start, resource_size(&res),
   216					     lp->card_name))
   217			return -EBUSY;
   218	
 > 219		ioaddr = (int)devm_ioremap(&pdev->dev, iores->start,
   220					 resource_size(iores));
   221		if (!ioaddr) {
   222			dev_err(&pdev->dev, "ioremap fallied\n");
   223			return -ENOMEM;
   224		}
   225	
   226		gpio_set_value_cansleep(phy_reset, 0);
   227		ndelay(RESET_DELAY);
   228		gpio_set_value_cansleep(phy_reset, 1);
   229	
   230		lp->hw.arc_inb = io_arc_inb;
   231		lp->hw.arc_outb = io_arc_outb;
   232		lp->hw.arc_insb = io_arc_insb;
   233		lp->hw.arc_outsb = io_arc_outsb;
   234	
   235		/* ARCNET controller needs this access to detect bustype */
   236		lp->hw.arc_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
   237		lp->hw.arc_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
   238	
   239		dev->base_addr = (unsigned long)ioaddr;
   240	
   241		dev->irq = of_get_named_gpio(np, "interrupts", 0);
   242		if (dev->irq == -EPROBE_DEFER) {
   243			return dev->irq;
   244		} else if (!gpio_is_valid(dev->irq)) {
   245			dev_err(&pdev->dev, "irq-gpios not valid !");
   246			return -EIO;
   247		}
   248		dev->irq = gpio_to_irq(dev->irq);
   249	
   250		ret = setup_clock(&clockp, &clockm, xtal, arc_speed);
   251		if (ret) {
   252			dev_err(&pdev->dev,
   253				"Impossible use oscillator:%dMhz and arcnet bus speed:%dKbps",
   254				xtal, arc_speed / 1000);
   255			return ret;
   256		}
   257	
   258		ret = setup_timeout(&timeout);
   259		if (ret) {
   260			dev_err(&pdev->dev, "Timeout:%d is not valid value", timeout);
   261			return ret;
   262		}
   263	
   264		lp->backplane = (int)backplane;
   265		lp->timeout = timeout;
   266		lp->clockm = clockm;
   267		lp->clockp = clockp;
   268		lp->hw.owner = THIS_MODULE;
   269	
   270		if (lp->hw.arc_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
   271			ret = -EIO;
   272			goto err_release_mem;
   273		}
   274	
   275		if (com20020_check(dev)) {
   276			ret = -EIO;
   277			goto err_release_mem;
   278		}
   279	
   280		ret = com20020_found(dev, IRQF_TRIGGER_FALLING);
   281		if (ret)
   282			goto err_release_mem;
   283	
   284		dev_dbg(&pdev->dev, "probe Done\n");
   285		return 0;
   286	
   287	err_release_mem:
   288		devm_iounmap(&pdev->dev, (void __iomem *)ioaddr);
   289		devm_release_mem_region(&pdev->dev, res.start, resource_size(&res));
   290		dev_err(&pdev->dev, "probe failed!\n");
   291		return ret;
   292	}
   293	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
