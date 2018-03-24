Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCXLnz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 07:43:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:39378 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbeCXLnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 07:43:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,354,1517904000";
   d="scan'208";a="28063281"
Date: Sat, 24 Mar 2018 19:43:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: kbuild-all@01.org, jakob.unterwurzacher@theobroma-systems.com,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Message-ID: <201803241907.upf6wIeD%fengguang.wu@intel.com>
References: <20180322135338.60923-2-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322135338.60923-2-jakob.unterwurzacher@theobroma-systems.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.16-rc6]
[cannot apply to next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jakob-Unterwurzacher/can-ucan-add-driver-for-Theobroma-Systems-UCAN-devices/20180324-164143
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/can/usb/ucan.c:301:16: sparse: restricted __le32 degrades to integer
   drivers/net/can/usb/ucan.c:414:32: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:414:32:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:414:32:    got restricted __le16 [usertype] <noident>
   drivers/net/can/usb/ucan.c:428:32: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:428:32:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:428:32:    got restricted __le16 [usertype] <noident>
   drivers/net/can/usb/ucan.c:683:44: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:683:44:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:683:44:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:700:44: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:700:44:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:700:44:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:752:25: sparse: cast to restricted __le16
   drivers/net/can/usb/ucan.c:779:36: sparse: incorrect type in argument 5 (different base types) @@    expected int [signed] buffer_length @@    got restricted __le1int [signed] buffer_length @@
   drivers/net/can/usb/ucan.c:779:36:    expected int [signed] buffer_length
   drivers/net/can/usb/ucan.c:779:36:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:793:54: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:793:54:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:793:54:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:853:62: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:853:62:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:853:62:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:877:61: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:877:61:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:877:61:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:891:44: sparse: incorrect type in argument 5 (different base types) @@    expected int [signed] buffer_length @@    got restricted __le1int [signed] buffer_length @@
   drivers/net/can/usb/ucan.c:891:44:    expected int [signed] buffer_length
   drivers/net/can/usb/ucan.c:891:44:    got restricted __le16 [usertype] wMaxPacketSize
>> drivers/net/can/usb/ucan.c:1238:41: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] sample_point @@    got restricted __le16 [usertype] sample_point @@
   drivers/net/can/usb/ucan.c:1238:41:    expected restricted __le16 [usertype] sample_point
   drivers/net/can/usb/ucan.c:1238:41:    got restricted __le32 [usertype] <noident>
   drivers/net/can/usb/ucan.c:1368:18: sparse: restricted __le16 degrades to integer
   drivers/net/can/usb/ucan.c:1373:19: sparse: restricted __le16 degrades to integer
   drivers/net/can/usb/ucan.c:1407:31: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:1407:31:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:1407:31:    got restricted __le16 [usertype] <noident>
   drivers/net/can/usb/ucan.c:1448:31: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:1448:31:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:1448:31:    got restricted __le16 [usertype] <noident>

vim +301 drivers/net/can/usb/ucan.c

   298	
   299	static u8 ucan_get_can_dlc(struct ucan_can_msg *msg, u16 len)
   300	{
 > 301		if (msg->id & CAN_RTR_FLAG)
   302			return get_can_dlc(msg->dlc);
   303		else
   304			return get_can_dlc(len - (UCAN_IN_HDR_SIZE + sizeof(msg->id)));
   305	}
   306	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
