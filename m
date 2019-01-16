Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1FA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404217AbfAPNMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:12:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:7023 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390326AbfAPNMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:12:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 05:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,486,1539673200"; 
   d="gz'50?scan'50,208,50";a="110328905"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2019 05:11:49 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gjkyy-000F6d-LA; Wed, 16 Jan 2019 21:11:48 +0800
Date:   Wed, 16 Jan 2019 21:11:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Message-ID: <201901162139.dkm3lJv5%fengguang.wu@intel.com>
References: <20190116064820.20007-3-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20190116064820.20007-3-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v5.0-rc2 next-20190116]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ran-Wang/usb-dwc3-Add-avoiding-vbus-glitch-happen-during-xhci-reset/20190116-153950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/interrupt.h:268: warning: Function parameter or member 'is_managed' not described in 'irq_affinity_desc'
   include/linux/rcupdate_wait.h:1: warning: no structured comments found
   include/linux/rcutree.h:1: warning: no structured comments found
   kernel/rcu/tree.c:710: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/gfp.h:1: warning: no structured comments found
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2393: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2393: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/rcu/tree.c:711: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/firmware/intel/stratix10-svc-client.h:1: warning: no structured comments found
   include/linux/gpio/driver.h:371: warning: Function parameter or member 'init_valid_mask' not described in 'gpio_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   drivers/mtd/nand/raw/nand_base.c:420: warning: Function parameter or member 'chip' not described in 'nand_fill_oob'
   drivers/mtd/nand/raw/nand_bbt.c:173: warning: Function parameter or member 'this' not described in 'read_bbt'
   drivers/mtd/nand/raw/nand_bbt.c:173: warning: Excess function parameter 'chip' description in 'read_bbt'
   include/linux/regulator/machine.h:199: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:228: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/slimbus/stream.c:1: warning: no structured comments found
   include/linux/spi/spi.h:180: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/target/target_core_device.c:1: warning: no structured comments found
>> drivers/usb/dwc3/core.h:1224: warning: Function parameter or member 'avoid_vbus_glitch_when_set_host' not described in 'dwc3'
   drivers/usb/typec/bus.c:1: warning: no structured comments found
   drivers/usb/typec/class.c:1: warning: no structured comments found
   include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/direct-io.c:257: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/file_table.c:1: warning: no structured comments found
   fs/libfs.c:477: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:382: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:383: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'end' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:845: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3093: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:128: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj_lock' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: no structured comments found
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_dp_helper.c:1364: warning: Function parameter or member 'dsc_dpcd' not described in 'drm_dp_dsc_sink_max_slice_count'
   drivers/gpu/drm/drm_dp_helper.c:1364: warning: Function parameter or member 'is_edp' not described in 'drm_dp_dsc_sink_max_slice_count'
   drivers/gpu/drm/i915/i915_vma.h:49: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   include/linux/skbuff.h:876: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'

vim +1224 drivers/usb/dwc3/core.h

72246da4 Felipe Balbi 2011-08-19 @1224  

:::::: The code at line 1224 was first introduced by commit
:::::: 72246da40f3719af3bfd104a2365b32537c27d83 usb: Introduce DesignWare USB3 DRD Driver

:::::: TO: Felipe Balbi <balbi@ti.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--sm4nu43k4a2Rpi4c--
