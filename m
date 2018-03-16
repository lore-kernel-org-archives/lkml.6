Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeCPMPB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:15:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:35501 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeCPMPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:15:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="25797287"
Date: Fri, 16 Mar 2018 20:14:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: kbuild-all@01.org, jakob.unterwurzacher@theobroma-systems.com,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Message-ID: <201803161925.uZhtkT5m%fengguang.wu@intel.com>
References: <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5]
[cannot apply to next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jakob-Unterwurzacher/can-ucan-add-driver-for-Theobroma-Systems-UCAN-devices/20180316-111528
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/can/usb/ucan.c:406:25: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:406:25:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:406:25:    got restricted __le16 [usertype] <noident>
   drivers/net/can/usb/ucan.c:425:25: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:425:25:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:425:25:    got restricted __le16 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:444:30: sparse: cast to restricted __le32
   drivers/net/can/usb/ucan.c:452:30: sparse: cast to restricted __le32
   drivers/net/can/usb/ucan.c:453:30: sparse: cast to restricted __le32
>> drivers/net/can/usb/ucan.c:454:30: sparse: cast to restricted __le16
   drivers/net/can/usb/ucan.c:456:21: sparse: cast to restricted __le16
   drivers/net/can/usb/ucan.c:559:15: sparse: cast to restricted __le16
   drivers/net/can/usb/ucan.c:568:17: sparse: cast to restricted __le32
   drivers/net/can/usb/ucan.c:582:22: sparse: cast to restricted __le32
   drivers/net/can/usb/ucan.c:622:19: sparse: cast to restricted __le16
>> drivers/net/can/usb/ucan.c:681:44: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:681:44:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:681:44:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:698:44: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:698:44:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:698:44:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:728:23: sparse: cast to restricted __le16
   drivers/net/can/usb/ucan.c:746:25: sparse: cast to restricted __le16
>> drivers/net/can/usb/ucan.c:772:36: sparse: incorrect type in argument 5 (different base types) @@    expected int [signed] buffer_length @@    got restricted __le1int [signed] buffer_length @@
   drivers/net/can/usb/ucan.c:772:36:    expected int [signed] buffer_length
   drivers/net/can/usb/ucan.c:772:36:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:784:54: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:784:54:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:784:54:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:842:62: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:842:62:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:842:62:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:866:61: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long [unsigned] [usertype] size @@    got d long [unsigned] [usertype] size @@
   drivers/net/can/usb/ucan.c:866:61:    expected unsigned long [unsigned] [usertype] size
   drivers/net/can/usb/ucan.c:866:61:    got restricted __le16 [usertype] wMaxPacketSize
   drivers/net/can/usb/ucan.c:880:44: sparse: incorrect type in argument 5 (different base types) @@    expected int [signed] buffer_length @@    got restricted __le1int [signed] buffer_length @@
   drivers/net/can/usb/ucan.c:880:44:    expected int [signed] buffer_length
   drivers/net/can/usb/ucan.c:880:44:    got restricted __le16 [usertype] wMaxPacketSize
>> drivers/net/can/usb/ucan.c:968:44: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] mode @@    got  short [unsigned] [usertype] mode @@
   drivers/net/can/usb/ucan.c:968:44:    expected unsigned short [unsigned] [usertype] mode
   drivers/net/can/usb/ucan.c:968:44:    got restricted __le16 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:1051:27: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] id @@    got ed int [unsigned] [usertype] id @@
   drivers/net/can/usb/ucan.c:1051:27:    expected unsigned int [unsigned] [usertype] id
   drivers/net/can/usb/ucan.c:1051:27:    got restricted __le32 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:1063:16: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] len @@    got  short [unsigned] [usertype] len @@
   drivers/net/can/usb/ucan.c:1063:16:    expected unsigned short [unsigned] [usertype] len
   drivers/net/can/usb/ucan.c:1063:16:    got restricted __le16 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:1212:31: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] tq @@    got ed int [unsigned] [usertype] tq @@
   drivers/net/can/usb/ucan.c:1212:31:    expected unsigned int [unsigned] [usertype] tq
   drivers/net/can/usb/ucan.c:1212:31:    got restricted __le32 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:1213:32: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] brp @@    got  short [unsigned] [usertype] brp @@
   drivers/net/can/usb/ucan.c:1213:32:    expected unsigned short [unsigned] [usertype] brp
   drivers/net/can/usb/ucan.c:1213:32:    got restricted __le16 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:1214:41: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] sample_point @@    got  short [unsigned] [usertype] sample_point @@
   drivers/net/can/usb/ucan.c:1214:41:    expected unsigned short [unsigned] [usertype] sample_point
   drivers/net/can/usb/ucan.c:1214:41:    got restricted __le32 [usertype] <noident>
>> drivers/net/can/usb/ucan.c:1334:18: sparse: restricted __le16 degrades to integer
   drivers/net/can/usb/ucan.c:1338:19: sparse: restricted __le16 degrades to integer
   drivers/net/can/usb/ucan.c:1372:31: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:1372:31:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:1372:31:    got restricted __le16 [usertype] <noident>
   drivers/net/can/usb/ucan.c:1392:17: sparse: cast to restricted __le32
   drivers/net/can/usb/ucan.c:1412:31: sparse: incorrect type in argument 5 (different base types) @@    expected unsigned short [unsigned] [usertype] value @@    got  short [unsigned] [usertype] value @@
   drivers/net/can/usb/ucan.c:1412:31:    expected unsigned short [unsigned] [usertype] value
   drivers/net/can/usb/ucan.c:1412:31:    got restricted __le16 [usertype] <noident>

vim +406 drivers/net/can/usb/ucan.c

   393	
   394	static int ucan_ctrl_command_out(struct ucan_priv *up,
   395					 u8 cmd,
   396					 u16 subcmd,
   397					 size_t datalen)
   398	{
   399		if (datalen > sizeof(union ucan_ctl_payload))
   400			return -ENOMEM;
   401	
   402		return usb_control_msg(up->udev,
   403				usb_sndctrlpipe(up->udev, 0),
   404				cmd,
   405				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 > 406				cpu_to_le16(subcmd),
   407				up->intf_index,
   408				up->ctl_msg_buffer,
   409				datalen,
   410				UCAN_USB_CTL_PIPE_TIMEOUT);
   411	}
   412	
   413	static int ucan_device_request_in(struct ucan_priv *up,
   414					  u8 cmd,
   415					  u16 subcmd,
   416					  size_t datalen)
   417	{
   418		if (datalen > sizeof(union ucan_ctl_payload))
   419			return -ENOMEM;
   420	
   421		return usb_control_msg(up->udev,
   422				usb_rcvctrlpipe(up->udev, 0),
   423				cmd,
   424				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
   425				cpu_to_le16(subcmd),
   426				0,
   427				up->ctl_msg_buffer,
   428				datalen,
   429				UCAN_USB_CTL_PIPE_TIMEOUT);
   430	}
   431	
   432	/* Parse the device information structure reported by the device and
   433	 * setup private variables accordingly
   434	 */
   435	static void ucan_parse_device_info(struct ucan_priv *up,
   436					   struct ucan_ctl_cmd_device_info
   437						*ctl_cmd_device_info)
   438	{
   439		struct can_bittiming_const *bittiming =
   440			&up->device_info.bittiming_const;
   441		u16 ctrlmodes;
   442	
   443		/* store the data */
 > 444		up->can.clock.freq = le32_to_cpu(ctl_cmd_device_info->freq);
   445		up->device_info.tx_fifo = ctl_cmd_device_info->tx_fifo;
   446		strcpy(bittiming->name, "ucan");
   447		bittiming->tseg1_min = ctl_cmd_device_info->tseg1_min;
   448		bittiming->tseg1_max = ctl_cmd_device_info->tseg1_max;
   449		bittiming->tseg2_min = ctl_cmd_device_info->tseg2_min;
   450		bittiming->tseg2_max = ctl_cmd_device_info->tseg2_max;
   451		bittiming->sjw_max = ctl_cmd_device_info->sjw_max;
   452		bittiming->brp_min = le32_to_cpu(ctl_cmd_device_info->brp_min);
   453		bittiming->brp_max = le32_to_cpu(ctl_cmd_device_info->brp_max);
 > 454		bittiming->brp_inc = le16_to_cpu(ctl_cmd_device_info->brp_inc);
   455	
   456		ctrlmodes = le16_to_cpu(ctl_cmd_device_info->ctrlmodes);
   457	
   458		up->can.ctrlmode_supported = 0;
   459	
   460		if (ctrlmodes & UCAN_MODE_LOOPBACK)
   461			up->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
   462		if (ctrlmodes & UCAN_MODE_SILENT)
   463			up->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
   464		if (ctrlmodes & UCAN_MODE_3_SAMPLES)
   465			up->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
   466		if (ctrlmodes & UCAN_MODE_ONE_SHOT)
   467			up->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
   468		if (ctrlmodes & UCAN_MODE_BERR_REPORT)
   469			up->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
   470	}
   471	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
