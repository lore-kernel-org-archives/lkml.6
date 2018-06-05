Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeFENxG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:53:06 -0400
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:63392
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeFENxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:53:03 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; maximintegrated.com; dkim=none (message not signed)
 header.d=none;maximintegrated.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Date: Tue, 5 Jun 2018 09:52:53 -0400
From: <stefan.popa@analog.com>
Message-ID: <201806051352.w55DqrfF028155@zeus.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Undisclosed recipients:;
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(2906002)(7416002)(109986005)(2876002)(39060400002)(6306002)(1076002)(478600001)(106466001)(53416004)(881003)(47776003)(246002)(966005)(72206003)(8936002)(7636002)(305945005)(356003)(336012)(8276002)(1720100001)(8666007)(86152003)(426003)(50466002)(48376002)(126002)(476003)(486006)(575784001)(316002)(106002)(16586007)(25636003)(1671002)(5416005)(77096007)(26005)(186003)(51416003)(59450400001)(5660300001)(25626001)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3524;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD009;1:nVaMIRsPQtPrZZTu86/Z268GQ17KbchgaIJTCX+XYzHHnx+FtACOOnibHXLk3q+dsGTzx5id4qDbETetvB3Ejd3kMQ4r20+I6ftT5zAJMj2DwcagjF/itMS1t0Iavk0j
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN7PR03MB3524;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3524;3:rhD4eiheGscy/RdwRARpx/hmAdEkGZllaB+TcNtah6nWfAcdk146O4EFT1Lkz5yXxfLoYs/nzU2xQVuhLIsh+wdGQ/HCnJuLK+3+V489ooQjjmsMpcu7BeRfBlREWF8STpKtOJkqFSnXOGdZHbGlko9RDaYr43zKOwjDNoW++FmfufoEqR8He7W9PPcoBEZ1xtzn2jInYcSRz7HtpbwX/pWt5yHa/1+JuTEXzGSFVZ7z19xVFH7/DIZrAMcTwwKlySO2ldJME3ir/rX9vDv3hHmW3wnmc4Sd4fRCOyCMfQmACVVGxzs0Jp2lPn/C7JbtVLVW8CntFh6kgyqgJYJU3w==;25:qixgXx+Zn3qWlVs+sdQVOKbcf2Gg+HovLG4U7xP4P9xkMbQ/y5GNaTIwaxyMrNnLflcjrwLwnNlj0C9FXRF9sVTU90FJlHURlWY596nV6woTE1KO75/xteTw1Uzi6F/jolA4jl6mnER/3lIUmbxvwMDAcz1GN/N4vyLw4sOH7Xay5+d8xqdvaYab/28lZ3j/8522PKxJmpxM1Ne2FRe/zecjhyueyOVy71L2rVPhZ9s6OHeDVjgAHIg9b8L8UGnaE/lt/BNmmEPznxGmLJWxAVgzoCUL/a6mgTsLj+4FFbO7f6PJC1Fx9e7Gc4iimBlpdMm8QDCCgdddDBEv0ggzIg==;31:kr1H95BlXugrJyHzRtvjME97b3GVCmjUIXNDISBYkn/tqObO+kOlFEcxsCqBzEDw9CKh8TJqBF1LwzyxcooKHO53NWsqZfeusf5Bni3ZD5hB93hAg75qHpeApZIwLN5mk+Pz4+QmWAUqbBqbhkUtDykYKqJdXQOtcgwlZoEgg5CziaFoja51HNSItYaJ5Q6gvNbgSFRgQHrp/1wHwqp615oK8+KaOwKJBjFT61cPueM=
X-MS-TrafficTypeDiagnostic: BN7PR03MB3524:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3524;20:2nJ8mzWhegwUQwh5cBpdtCg2uoFU+/0vgxEDnuZN+jW1KwKd+TAbEzh83ZkokwWxiu6b4NAsFwCFNRJ8vtNO2ISOmFQpJwAWzomNbIDkQ/N+gGLj6gSteMOpq5n6K5HXvRg9m25uRBk53WmiWOyj0ALk/2tpMd40d3EShnzITni911OvgFNLExwnIkL9gK4Dxqzuo6GrKlf6OEq/7L0JIplq11iw3VO2ky90XHlwk9FOrxPi5rk9cZzm3vftvAnEI5GMT8oWChiiAEMwULX/SC23jPu6fTXJ4Yhfl3kfG5U2JukGodmAwROlVeLBF9l7bN+jFg4ACOlkktkIq9WkU8v4gQWyk2nk2nxFySIteLUcUglxRpoatOdvZ0yxEXM2vr+e6UrWreXIBt0DZPfcjAugBQfcGZh+l06B3j6N/VulxT02IUYFOd+XUnZq0/HS+PXsgROCSePtspuXJ44MUYxU43i8/Rtm9OTPhtuJPhvbNrY58O2EoD9i+Z4+qd3c
X-Microsoft-Antispam-PRVS: <BN7PR03MB35247F7066E81D4492ECC3F49D660@BN7PR03MB3524.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(26323138287068)(9452136761055)(232431446821674)(85827821059158)(95692535739014)(108721460000369)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR03MB3524;BCL:0;PCL:0;RULEID:;SRVR:BN7PR03MB3524;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3524;4:BP8daalnu4XlwSrKfbTuyw2XKP1yJdBx85wIwhWt4nqXa+Isl6FgWZD3gbN5FnCE/I2oHOJkR5SykxCNKEoafO9x591ekacKDN/MDaCfpnm2L67FwLhSpBmCYKSvlQGESZHekVV3qBTTiwCoe49lR0prfThKKmoLncWURW/ezy/lAzibQn6JX+EoxmLhl/7dkdOYKNs8dqH6P5/ykR1L/uUJk0vXgsQ3tNzVVD15G9TN2srtLk/2TlEvyhl/cmqJR6cihjveJxdMjH4WwESDtNyZazEPCatECYGIdy9D69wRIYt7bVrhQuBY/kxxUVl6ZYHHVB5e/lMy/Fyr1vS9xOhY0TrhSKUavZ06YvAshr1g5MsIH/ixEh/ZDWyNvp3ZbeCNcHI4yJLYK1wNy825q8QvoJYoJOzL7nHmXtFOWI6fWus0M32xZTNjLfzDl8bcJwVLXzXTOAub28Gik1j9F15Li7wjxShDn1fYMAj1q+RyrA2dSJ5ao5KWomGKoxMnmaW7WxQlRhPktqcnKTlyZVYCOEYsXZ8jUBS/I/9DZGM=
X-Forefront-PRVS: 0694C54398
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3524;23:kfen4rcVWduA2IH0pklHgrfx8LPPGP37CdQpzEX7u?=
 =?us-ascii?Q?RasHlLOfjtWM547CwI6BCwWBaZQBloVjJku7MTV19cbCpgiVCoVZLNIJpz83?=
 =?us-ascii?Q?DCKWbU9wxmte236roIAh7MMU0IxiD1H8jukAbBmxzP1kKm58k1q41w/rhM+8?=
 =?us-ascii?Q?iI/qZtIwpvuqCmAPxQyB7Cg/u8JlvCIWM++5MuUEW8rXiJ2b19bN3BSsgEhM?=
 =?us-ascii?Q?acioYvR0vu9gsfguyKPsO/ZtBSq8kns5z4CJYvPU/cvfRBdgnncXEN0xTVBd?=
 =?us-ascii?Q?v3i0m+spD/oADHzOzEuNR8Tjh7uTUvbojBJ50z8NLtdMDFbaS5qCJPz/82lb?=
 =?us-ascii?Q?x5E0F75uoakzEqv9Lw7T++paeWhlPdHV0WpbyT0sJMurJYICE5W43fXdHdKv?=
 =?us-ascii?Q?ZP2fRsJnU3PaH9kb1r1nx7lvT/0l3tqS3FhdH66K6cSgcvsPxDEya1MJ99Zt?=
 =?us-ascii?Q?2/Vsj5RKehIj4lE10OjWvPQYyvKAx7KthNBSYZ5lynmBRMIYOGydCUEltfmp?=
 =?us-ascii?Q?VwMSS7ZqYLykIw/cegOWwQzvUyfuo+crRs62rXzxgJrj1ZXhG+/J6UlByR8z?=
 =?us-ascii?Q?+0nyE1J8tzWcW4gr6oO7bmjc/1aJ5M50pxj5HvTTFoP9GamYtw6nZve4nwwP?=
 =?us-ascii?Q?wCQpsOsToN6Df99y1wa+GPA+O48jgc/WhY9C3uY9PtBsuH8yUy0OTMVUMHZd?=
 =?us-ascii?Q?3dtvWqS9yI04FIMau07f1i9YCnFjRB5/AY/vdIAB0+PwlpzZmcpo87VrTYte?=
 =?us-ascii?Q?kuvMV2u8ysad0qU/aRE+nUVoVo+eIMaaryZy/2C/4JgjcLS/MiRPV/Rce/N6?=
 =?us-ascii?Q?U5XSCOBCczn5gszxcDnh7EWNYtpjar2a4QV7lWzdvddh3cfmnpB8fF8r1qxF?=
 =?us-ascii?Q?0DpPxTMSY9KaLVMGhaNIJMpwhL+62FK2g6Bzy1g8+D7NQfCQogKp9Py0DPet?=
 =?us-ascii?Q?8u9tPiwX2j8VkJXZMwAtAkjKTs/pF165w6PIisL2woSkoBgOhXTR20cZnofR?=
 =?us-ascii?Q?667D7bfVnzEsOmZF7mu7gGMilfE3GmGs5Y11c/8azXytdpQ1guM3P9gLoNuE?=
 =?us-ascii?Q?4yhnNSy1ENOts8Xuj0ZEHOTiSCBYpmDi+0AidX7OwBV7CKoDjPJmcvGIu4nq?=
 =?us-ascii?Q?ZG9dfqiep8lNgoS70cNG9fPX3hSry/FSSScZj/HoBW0fBSNKPlSrVzkyUFRg?=
 =?us-ascii?Q?Bt9T8m15Ql6uZ8tHRSIXB9nG2r10fgMYG1x?=
X-Microsoft-Antispam-Message-Info: DudEh/7wGoBApSeSSe81S5ECIqGy24x8UzI0zTK+yLxTaD48/PIENHKoiHu3pBHi8pmjugTK0Jq4YdoTT5T/IGGvWdPKwL74KB7IdfxkPthzxIPQFoS9LtR7HseJCZKBVQm9EjAi7NV5owEcURRH+CkzWf1xDn/8Tw+6j5721/82EM5EwC1uJYgVmLv0PxkF
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3524;6:e1qZaEPwtp5JgdhyZGcUHEuApvepXS+1DeEIibyi7ZK+B1KlMHWznr1wPs5yg0j15CDLssmqxYQQRZkGXUagxqqYFrMdXr08uOrj1yCoP95OwUBJNKGWycgWxcJEVqJUIUHY9fZ4hElI8iS/mNgpD4qvj/p7ee8R8ecFOcZmi941olKg8qXMFUNnJmmYPnJ/jht24/O5gsI2Ma3zhB2rXYgQ1CU8KYOhvFXC4ssRiqKHE2HIsbEagqPLyo6O1QbHbCWMu9TDcrvvnULbuLiKTwVpqFVChEh2KNpx2i1ee0kb0k37ilV2kZBC4KaAP1xj576tGlt2uYOW6BTpJxurMSL2JHOZ3pgL3DBHoYXhzH1u6JkLblkyCM8fHL3cnf8qyhDfhHKARvexT3Rew6NnTUhWWYaFhkPolGNzfn8CByicKvId72HpBxHPEU+JeWSiBGoQ4T8tNYd8oahy+twJig==;5:OIk9tvW4dEwiymnlQ9KFt6Jy/nunX87WNJjVfUxKJ3WpzwELZGmhsyDJS81yeD66NveYvue5Jc4QJizWFnGBnQSiWjwS07TFwSs6OrT0WEXwS9kG2o33gAK2ngL17q2L2cSG9AsfLgbmBPujuBP/VexCjuC0rpglj9zEKbJ8Alg=;24:4NmOYHSRdC0GuypfRCwxe3NvHT/beFNY0PFf1shJ9jTBw7AMj6qO8d+0RB5wWw+GETFYf7oGVT7YFxhSRfbH/RfplzJQ/Fyu26jOw/eE+6s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3524;7:Lyd92e0uFvqSXycj6tpYWSnDWxeD9dxQCOmy27+TFIXd+MwMOHIcV7XACbXidHhXhujpZ2dTak/BMfhkFqcrdKXSJtbWu3vjBAo48/jXjMGXC03jWkKMZBmFBUS3VrFrY5Fp4tC17kaOAzr3RcAZDpHQCD9kaFstcWXw5R9vZB2xSOphgIAw6KweFGvDajn2xVGvk+/a1ppUVudRQS5IHG9XjKQfDEWkSmQ1z2WLAGndcJSmUTnRnd9XdjDq008A
X-MS-Office365-Filtering-Correlation-Id: c3c10229-41a3-4ecd-0eb2-08d5caeba695
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 13:53:00.2301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c10229-41a3-4ecd-0eb2-08d5caeba695
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3524
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>
To: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de
Cc: knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	mchehab@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	lukas@wunner.de,
	Ismail.Kose@maximintegrated.com,
	vilhelm.gray@gmail.com,
	sean.nyekjaer@prevas.dk,
	pombredanne@nexb.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stefan.popa@analog.com
Subject: [PATCH 1/2] iio: dac: Add AD5758 support
Date: Tue,  5 Jun 2018 16:52:34 +0300
Message-Id: <1528206754-13986-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4

The AD5758 is a single channel DAC with 16-bit precision which uses the SPI
interface that operates at clock rates up to 50MHz.

The output can be configured as voltage or current and is available on a
single terminal.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS              |   7 +
 drivers/iio/dac/Kconfig  |  10 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5758.c | 826 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 844 insertions(+)
 create mode 100644 drivers/iio/dac/ad5758.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225..1993779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,13 @@ S:	Supported
 F:	drivers/iio/dac/ad5686*
 F:	drivers/iio/dac/ad5696*
 
+ANALOG DEVICES INC AD5758 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5758.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 06e90de..80beb64 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -167,6 +167,16 @@ config AD5755
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5755.
 
+config AD5758
+	tristate "Analog Devices AD5758 DAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5758 single channel
+	  Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5758.
+
 config AD5761
 	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 57aa230..e859f2d 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
new file mode 100644
index 0000000..0a26b9d
--- /dev/null
+++ b/drivers/iio/dac/ad5758.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5758 Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/property.h>
+
+/* AD5758 registers definition */
+#define AD5758_NOP					0x00
+#define AD5758_DAC_INPUT				0x01
+#define AD5758_DAC_OUTPUT				0x02
+#define AD5758_CLEAR_CODE				0x03
+#define AD5758_USER_GAIN				0x04
+#define AD5758_USER_OFFSET				0x05
+#define AD5758_DAC_CONFIG				0x06
+#define AD5758_SW_LDAC					0x07
+#define AD5758_KEY					0x08
+#define AD5758_GP_CONFIG1				0x09
+#define AD5758_GP_CONFIG2				0x0A
+#define AD5758_DCDC_CONFIG1				0x0B
+#define AD5758_DCDC_CONFIG2				0x0C
+#define AD5758_WDT_CONFIG				0x0F
+#define AD5758_DIGITAL_DIAG_CONFIG			0x10
+#define AD5758_ADC_CONFIG				0x11
+#define AD5758_FAULT_PIN_CONFIG				0x12
+#define AD5758_TWO_STAGE_READBACK_SELECT		0x13
+#define AD5758_DIGITAL_DIAG_RESULTS			0x14
+#define AD5758_ANALOG_DIAG_RESULTS			0x15
+#define AD5758_STATUS					0x16
+#define AD5758_CHIP_ID					0x17
+#define AD5758_FREQ_MONITOR				0x18
+#define AD5758_DEVICE_ID_0				0x19
+#define AD5758_DEVICE_ID_1				0x1A
+#define AD5758_DEVICE_ID_2				0x1B
+#define AD5758_DEVICE_ID_3				0x1C
+
+/* AD5758_DAC_CONFIG */
+#define AD5758_DAC_CONFIG_RANGE_MSK			GENMASK(3, 0)
+#define AD5758_DAC_CONFIG_RANGE_MODE(x)			(((x) & 0xF) << 0)
+#define AD5758_DAC_CONFIG_OVRNG_EN_MSK			BIT(4)
+#define AD5758_DAC_CONFIG_OVRNG_EN_MODE(x)		(((x) & 0x1) << 4)
+#define AD5758_DAC_CONFIG_INT_EN_MSK			BIT(5)
+#define AD5758_DAC_CONFIG_INT_EN_MODE(x)		(((x) & 0x1) << 5)
+#define AD5758_DAC_CONFIG_OUT_EN_MSK			BIT(6)
+#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)		(((x) & 0x1) << 6)
+#define AD5758_DAC_CONFIG_RSET_EXT_EN_MSK		BIT(7)
+#define AD5758_DAC_CONFIG_RSET_EXT_EN_MODE(x)		(((x) & 0x1) << 7)
+#define AD5758_DAC_CONFIG_SR_EN_MSK			BIT(8)
+#define AD5758_DAC_CONFIG_SR_EN_MODE(x)			(((x) & 0x1) << 8)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MSK			GENMASK(12, 9)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)		(((x) & 0xF) << 9)
+#define AD5758_DAC_CONFIG_SR_STEP_MSK			GENMASK(15, 13)
+#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)		(((x) & 0x7) << 13)
+
+/* AD5758_KEY */
+#define AD5758_KEY_CODE_RESET_1				0x15FA
+#define AD5758_KEY_CODE_RESET_2				0xAF51
+#define AD5758_KEY_CODE_SINGLE_ADC_CONV			0x1ADC
+#define AD5758_KEY_CODE_RESET_WDT			0x0D06
+#define AD5758_KEY_CODE_CALIB_MEM_REFRESH		0xFCBA
+
+/* AD5758_DCDC_CONFIG1 */
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK		GENMASK(4, 0)
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)		(((x) & 0x1F) << 0)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK		GENMASK(6, 5)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)		(((x) & 0x3) << 5)
+#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK	BIT(7)
+#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
+
+/* AD5758_DCDC_CONFIG2 */
+#define AD5758_DCDC_CONFIG2_ILIMIT_MSK			GENMASK(3, 1)
+#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)		(((x) & 0x7) << 1)
+#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MSK	GENMASK(5, 4)
+#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MODE(x)	(((x) & 0x3) << 4)
+#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MSK	BIT(6)
+#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MODE(x)	(((x) & 0x1) << 6)
+#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MSK		BIT(7)
+#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MODE(x)	(((x) & 0x1) << 7)
+#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MSK		BIT(10)
+#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MODE(x)	(((x) & 0x1) << 10)
+#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK		BIT(11)
+#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK		BIT(12)
+
+/* AD5758_DIGITAL_DIAG_RESULTS */
+#define AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK	BIT(15)
+
+#define AD5758_REG_WRITE(x)	((0x80) | ((x) & 0x1F))
+
+/* x^8 + x^2 + x^1 + x^0 */
+#define AD5758_CRC8_POLY	0x07
+
+/**
+ * struct ad5758_state - driver instance specific data
+ * @spi:	spi_device
+ * @dc_dc_mode:	variable which stores the mode of operation
+ * @out_range:	variable which stores the output range
+ * @pwr_down:	variable which contains whether a channel is powered down or not
+ * @data:	spi transfer buffers
+ */
+
+struct ad5758_state {
+	struct spi_device *spi;
+	struct mutex lock;
+	unsigned int dc_dc_mode;
+	unsigned int dc_dc_ilim;
+	unsigned int sr_config[3];
+	unsigned int out_range;
+	unsigned int pwr_down;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+
+	union {
+		__be32 d32;
+		u8 d8[4];
+	} data[3] ____cacheline_aligned;
+};
+
+enum ad5758_output_range {
+	AD5758_RANGE_0V_5V,
+	AD5758_RANGE_0V_10V,
+	AD5758_RANGE_PLUSMINUS_5V,
+	AD5758_RANGE_PLUSMINUS_10V,
+	AD5758_RANGE_0mA_20mA = 8,
+	AD5758_RANGE_0mA_24mA,
+	AD5758_RANGE_4mA_24mA,
+	AD5758_RANGE_PLUSMINUS_20mA,
+	AD5758_RANGE_PLUSMINUS_24mA,
+	AD5758_RANGE_MINUS_1mA_PLUS_22mA,
+};
+
+enum ad5758_dc_dc_mode {
+	AD5758_DCDC_MODE_POWER_OFF,
+	AD5758_DCDC_MODE_DPC_CURRENT,
+	AD5758_DCDC_MODE_DPC_VOLTAGE,
+	AD5758_DCDC_MODE_PPC_CURRENT,
+};
+
+struct ad5758_range {
+	int reg;
+	int min;
+	int max;
+};
+
+static const struct ad5758_range ad5758_min_max_table[] = {
+	{ AD5758_RANGE_0V_5V, 0, 5000 },
+	{ AD5758_RANGE_0V_10V, 0, 10000 },
+	{ AD5758_RANGE_PLUSMINUS_5V, -5000, 5000 },
+	{ AD5758_RANGE_PLUSMINUS_10V, -10000, 10000 },
+	{ AD5758_RANGE_0mA_20mA, 0, 20},
+	{ AD5758_RANGE_0mA_24mA, 0, 24 },
+	{ AD5758_RANGE_4mA_24mA, 4, 24 },
+	{ AD5758_RANGE_PLUSMINUS_20mA, -20, 20 },
+	{ AD5758_RANGE_PLUSMINUS_24mA, -24, 24 },
+	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1, 22 },
+};
+
+static const int ad5758_slew_rate_clk[16] = {
+	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
+	1000, 512, 256, 128, 64, 16
+};
+
+static const int ad5758_slew_rate_step[8] = {
+	4, 12, 64, 120, 256, 500, 1820, 2048
+};
+
+static const int ad5758_dc_dc_ilimt[6] = {
+	150, 200, 250, 300, 350, 400
+};
+
+static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int addr)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->data[0].d8[0],
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->data[1].d8[0],
+			.rx_buf = &st->data[2].d8[0],
+			.len = 4,
+		},
+	};
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(
+		(AD5758_REG_WRITE(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
+		(addr << 8));
+	st->data[1].d32 = cpu_to_be32(AD5758_REG_WRITE(AD5758_NOP) << 24);
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return (be32_to_cpu(st->data[2].d32) >> 8) & 0xFFFF;
+}
+
+static int ad5758_spi_reg_write(struct ad5758_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	st->data[0].d32 = cpu_to_be32((AD5758_REG_WRITE(addr) << 24) |
+				      ((val & 0xFFFF) << 8));
+
+	return spi_write(st->spi, &st->data[0].d8[0], 4);
+}
+
+static int ad5758_spi_write_mask(struct ad5758_state *st,
+				 unsigned int addr,
+				 unsigned long int mask,
+				 unsigned int val)
+{
+	int regval;
+
+	regval = ad5758_spi_reg_read(st, addr);
+	if (regval < 0)
+		return regval;
+
+	regval &= ~mask;
+	regval |= val;
+
+	return ad5758_spi_reg_write(st, addr, regval);
+}
+
+static int ad5758_get_array_index(const int *array, unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val == array[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5758_wait_for_task_complete(struct ad5758_state *st,
+					 unsigned int reg,
+					 unsigned int mask)
+{
+	unsigned int timeout;
+	int ret;
+
+	timeout = 4;
+	do {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0)
+			return ret;
+
+		if (!(ret & mask))
+			return 0;
+
+		mdelay(1);
+	} while (--timeout);
+
+	dev_err(&st->spi->dev,
+		"Error reading bit 0x%x in 0x%x register\n", mask, reg);
+
+	return -EIO;
+}
+
+static int ad5758_calib_mem_refresh(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY,
+				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
+
+	if (ret < 0) {
+		dev_err(&st->spi->dev,
+			"Failed to initiate a calibration memory refresh\n");
+		return ret;
+	}
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_soft_reset(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
+	if (ret < 0)
+		return ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
+
+	mdelay(1);
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
+				      unsigned int mode)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->dc_dc_mode = mode;
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_slew_rate_config(struct ad5758_state *st,
+				   unsigned int enable,
+				   unsigned int sr_clk,
+				   unsigned int sr_step)
+{
+	unsigned int mode;
+	unsigned long int mask;
+	int ret;
+
+	mask = (AD5758_DAC_CONFIG_SR_EN_MSK |
+	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
+	       AD5758_DAC_CONFIG_SR_STEP_MSK);
+
+	mode = (AD5758_DAC_CONFIG_SR_EN_MODE(enable) |
+		AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk) |
+		AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step));
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_set_out_range(struct ad5758_state *st, unsigned int range)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_RANGE_MSK,
+				    AD5758_DAC_CONFIG_RANGE_MODE(
+					    ad5758_min_max_table[range].reg));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	ret =  ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->out_range = range;
+
+	return ret;
+}
+
+static int ad5758_fault_prot_switch_en(struct ad5758_state *st,
+				       unsigned char enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK,
+			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_internal_buffers_en(struct ad5758_state *st,
+				      unsigned char enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_INT_EN_MSK,
+				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval == NULL) {
+		ret =  ad5758_spi_reg_write(st, reg, writeval);
+	} else {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0)
+			return ret;
+
+		*readval = ret;
+		ret = 0;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad5758_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int max, min, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		*val = ret;
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		min = ad5758_min_max_table[st->out_range].min;
+		max = ad5758_min_max_table[st->out_range].max;
+		*val = max - min;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5758_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
+		mutex_unlock(&st->lock);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
+				     uintptr_t priv,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->pwr_down);
+}
+
+static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t priv,
+				      struct iio_chan_spec const *chan,
+				      const char *buf, size_t len)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	bool pwr_down;
+	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
+	unsigned long int dcdc_config1_msk, dac_config_msk;
+	int ret;
+
+	ret = strtobool(buf, &pwr_down);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	if (pwr_down) {
+		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
+		val = 0;
+	} else {
+		dc_dc_mode = st->dc_dc_mode;
+		val = 1;
+	}
+
+	dcdc_config1_mode = (AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
+			     AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(val));
+	dcdc_config1_msk = (AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
+			    AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    dcdc_config1_msk,
+				    dcdc_config1_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	dac_config_mode = (AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
+			   AD5758_DAC_CONFIG_INT_EN_MODE(val));
+	dac_config_msk =  (AD5758_DAC_CONFIG_OUT_EN_MSK |
+			   AD5758_DAC_CONFIG_INT_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    dac_config_msk,
+				    dac_config_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	st->pwr_down = pwr_down;
+
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_info ad5758_info = {
+	.read_raw = ad5758_read_raw,
+	.write_raw = ad5758_write_raw,
+	.debugfs_reg_access = &ad5758_reg_access,
+};
+
+static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5758_read_powerdown,
+		.write = ad5758_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ },
+};
+
+static const struct iio_chan_spec ad5758_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.output = 1,
+		.channel = 0,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 32,
+			.shift = 0,
+			.endianness = IIO_BE,
+		},
+		.ext_info = ad5758_ext_info,
+	},
+};
+
+static int ad5758_crc_disable(struct ad5758_state *st)
+{
+	st->data[0].d32 =
+		cpu_to_be32(
+		(AD5758_REG_WRITE(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A);
+
+	return spi_write(st->spi, &st->data[0].d8[0], 4);
+}
+
+static void ad5758_parse_dt(struct ad5758_state *st)
+{
+	unsigned int i, tmp, tmparray[3];
+	int index;
+
+	st->dc_dc_ilim = 150;
+	if (!device_property_read_u32(&st->spi->dev,
+				      "adi,dc-dc-ilim", &tmp)) {
+		index = ad5758_get_array_index(ad5758_dc_dc_ilimt,
+					ARRAY_SIZE(ad5758_dc_dc_ilimt), tmp);
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				 "dc-dc-ilim out of range using default");
+		else
+			st->dc_dc_ilim = index;
+	} else {
+		dev_dbg(&st->spi->dev,
+			 "Missing \"dc-dc-ilim\" property, using default\n");
+	}
+
+	st->dc_dc_mode = AD5758_DCDC_MODE_DPC_VOLTAGE;
+	if (device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
+				     &st->dc_dc_mode))
+		dev_dbg(&st->spi->dev,
+			"Missing \"dc-dc-mode\" property, using DPC_VOLTAGE\n");
+
+	/* 0 V to 5 V voltage range */
+	st->out_range = 0;
+	if (!device_property_read_u32(&st->spi->dev, "adi,range", &tmp)) {
+		for (i = 0; i < ARRAY_SIZE(ad5758_min_max_table); i++) {
+			if (tmp == ad5758_min_max_table[i].reg) {
+				st->out_range = i;
+				break;
+			}
+		}
+
+		if (i == ARRAY_SIZE(ad5758_min_max_table))
+			dev_warn(&st->spi->dev, "range invalid, using default");
+	} else {
+		dev_dbg(&st->spi->dev,
+			"Missing \"range\" property, using default\n");
+	}
+
+	st->sr_config[0] = 1;
+	st->sr_config[1] = 16000;
+	st->sr_config[2] = 4;
+	if (!device_property_read_u32_array(&st->spi->dev, "adi,slew",
+					    tmparray, 3)) {
+		st->sr_config[0] = tmparray[0];
+
+		index = ad5758_get_array_index(ad5758_slew_rate_clk,
+					       ARRAY_SIZE(ad5758_slew_rate_clk),
+					       tmparray[1]);
+
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				"slew rate clock out of range, using default");
+		else
+			st->sr_config[1] = index;
+
+		index = ad5758_get_array_index(ad5758_slew_rate_step,
+					ARRAY_SIZE(ad5758_slew_rate_step),
+					tmparray[2]);
+
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				"slew rate step out of range, using default");
+		else
+			st->sr_config[2] = index;
+	} else {
+		dev_dbg(&st->spi->dev,
+			 "Missing \"slew\" property, using default\n");
+	}
+}
+
+static int ad5758_init(struct ad5758_state *st)
+{
+	int regval, ret;
+
+	ad5758_parse_dt(st);
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a software reset */
+	ret = ad5758_soft_reset(st);
+	if (ret < 0)
+		return ret;
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a calibration memory refresh */
+	ret = ad5758_calib_mem_refresh(st);
+	if (ret < 0)
+		return ret;
+
+	regval = ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
+	if (regval < 0)
+		return regval;
+
+	/* Clear all the error flags */
+	ret = ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
+	if (ret < 0)
+		return ret;
+
+	/* Set the dc-to-dc current limit */
+	ret = ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the dc-to-dc controller mode */
+	ret = ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the output range */
+	ret = ad5758_set_out_range(st, st->out_range);
+	if (ret < 0)
+		return ret;
+
+	/* Enable Slew Rate Control, set the slew rate clock and step */
+	ret = ad5758_slew_rate_config(st, st->sr_config[0],
+				      st->sr_config[1], st->sr_config[2]);
+	if (ret < 0)
+		return ret;
+
+	/* Enable the VIOUT fault protection switch (FPS is closed) */
+	ret = ad5758_fault_prot_switch_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Power up the DAC and internal (INT) amplifiers */
+	ret = ad5758_internal_buffers_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Enable VIOUT */
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_OUT_EN_MSK,
+				    AD5758_DAC_CONFIG_OUT_EN_MODE(1));
+
+	return ret;
+}
+
+static int ad5758_probe(struct spi_device *spi)
+{
+	struct ad5758_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5758_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5758_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5758_channels);
+
+	mutex_init(&st->lock);
+
+	ret = ad5758_init(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD5758 init failed\n");
+		return ret;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to register iio device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct spi_device_id ad5758_id[] = {
+	{ "ad5758", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5758_id);
+
+static struct spi_driver ad5758_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad5758_probe,
+	.id_table = ad5758_id,
+};
+
+module_spi_driver(ad5758_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
