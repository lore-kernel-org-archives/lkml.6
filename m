Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AEBC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB60127D80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB60127D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755075AbeF2K4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:56:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:44706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeF2K4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:56:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 03:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="gz'50?scan'50,208,50";a="68325492"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2018 03:56:08 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fYr4R-0008gC-Q6; Fri, 29 Jun 2018 18:56:07 +0800
Date:   Fri, 29 Jun 2018 18:56:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     ning.a.zhang@intel.com
Cc:     kbuild-all@01.org, gregkh@linuxfoundation.org,
        rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, mark.gross@intel.com,
        Zhang Ning <ning.a.zhang@intel.com>
Subject: Re: [PATCH] driver core: support bus manage deferred probe
Message-ID: <201806291718.F4HLyXHA%fengguang.wu@intel.com>
References: <20180629070226.24506-1-ning.a.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20180629070226.24506-1-ning.a.zhang@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zhang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.18-rc2 next-20180628]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/ning-a-zhang-intel-com/driver-core-support-bus-manage-deferred-probe/20180629-150608
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   mm/mempool.c:228: warning: Function parameter or member 'pool' not described in 'mempool_init'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/sched/fair.c:3760: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   include/linux/device.h:93: warning: bad line: this bus.
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/device.h:94: warning: bad line: this bus.
>> include/linux/device.h:150: warning: Function parameter or member 'manage_deferred' not described in 'bus_type'
>> include/linux/device.h:150: warning: Function parameter or member 'deferred_probe_pending_list' not described in 'bus_type'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/regulator/driver.h:227: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4465: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/usb/dwc3/gadget.c:510: warning: Excess function parameter 'dwc' description in 'dwc3_gadget_start_config'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   drivers/gpu/drm/i915/i915_vma.h:48: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   include/drm/tinydrm/tinydrm.h:34: warning: Function parameter or member 'fb_dirty' not described in 'tinydrm_device'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'crtc_state' not described in 'mipi_dbi_enable_flush'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'plane_state' not described in 'mipi_dbi_enable_flush'

vim +150 include/linux/device.h

^1da177e4 Linus Torvalds        2005-04-16   62  
880ffb5c6 Wanlong Gao           2011-05-05   63  /**
880ffb5c6 Wanlong Gao           2011-05-05   64   * struct bus_type - The bus type of the device
880ffb5c6 Wanlong Gao           2011-05-05   65   *
880ffb5c6 Wanlong Gao           2011-05-05   66   * @name:	The name of the bus.
ca22e56de Kay Sievers           2011-12-14   67   * @dev_name:	Used for subsystems to enumerate devices like ("foo%u", dev->id).
ca22e56de Kay Sievers           2011-12-14   68   * @dev_root:	Default device to use as the parent.
12478ba07 Greg Kroah-Hartman    2013-08-08   69   * @bus_groups:	Default attributes of the bus.
fa6fdb33b Greg Kroah-Hartman    2013-08-08   70   * @dev_groups:	Default attributes of the devices on the bus.
ed0617b5c Greg Kroah-Hartman    2013-08-08   71   * @drv_groups: Default attributes of the device drivers on the bus.
880ffb5c6 Wanlong Gao           2011-05-05   72   * @match:	Called, perhaps multiple times, whenever a new device or driver
656b8035b Tomeu Vizoso          2016-02-15   73   *		is added for this bus. It should return a positive value if the
656b8035b Tomeu Vizoso          2016-02-15   74   *		given device can be handled by the given driver and zero
656b8035b Tomeu Vizoso          2016-02-15   75   *		otherwise. It may also return error code if determining that
656b8035b Tomeu Vizoso          2016-02-15   76   *		the driver supports the device is not possible. In case of
656b8035b Tomeu Vizoso          2016-02-15   77   *		-EPROBE_DEFER it will queue the device for deferred probing.
880ffb5c6 Wanlong Gao           2011-05-05   78   * @uevent:	Called when a device is added, removed, or a few other things
880ffb5c6 Wanlong Gao           2011-05-05   79   *		that generate uevents to add the environment variables.
880ffb5c6 Wanlong Gao           2011-05-05   80   * @probe:	Called when a new device or driver add to this bus, and callback
880ffb5c6 Wanlong Gao           2011-05-05   81   *		the specific driver's probe to initial the matched device.
880ffb5c6 Wanlong Gao           2011-05-05   82   * @remove:	Called when a device removed from this bus.
880ffb5c6 Wanlong Gao           2011-05-05   83   * @shutdown:	Called at shut-down time to quiesce the device.
4f3549d72 Rafael J. Wysocki     2013-05-02   84   *
4f3549d72 Rafael J. Wysocki     2013-05-02   85   * @online:	Called to put the device back online (after offlining it).
4f3549d72 Rafael J. Wysocki     2013-05-02   86   * @offline:	Called to put the device offline for hot-removal. May fail.
4f3549d72 Rafael J. Wysocki     2013-05-02   87   *
880ffb5c6 Wanlong Gao           2011-05-05   88   * @suspend:	Called when a device on this bus wants to go to sleep mode.
880ffb5c6 Wanlong Gao           2011-05-05   89   * @resume:	Called to bring a device on this bus out of sleep mode.
582a686f5 Phil Sutter           2017-01-18   90   * @num_vf:	Called to find out how many virtual functions a device on this
582a686f5 Phil Sutter           2017-01-18   91   *		bus supports.
07397df29 Nipun Gupta           2018-04-28   92   * @dma_configure:	Called to setup DMA configuration on a device on
07397df29 Nipun Gupta           2018-04-28   93  			this bus.
880ffb5c6 Wanlong Gao           2011-05-05  @94   * @pm:		Power management operations of this bus, callback the specific
880ffb5c6 Wanlong Gao           2011-05-05   95   *		device driver's pm-ops.
7b08fae8f Marcos Paulo de Souza 2011-11-01   96   * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
ff21776d1 Joerg Roedel          2011-08-26   97   *              driver implementations to a bus and allow the driver to do
ff21776d1 Joerg Roedel          2011-08-26   98   *              bus-specific setup
880ffb5c6 Wanlong Gao           2011-05-05   99   * @p:		The private data of the driver core, only the driver core can
880ffb5c6 Wanlong Gao           2011-05-05  100   *		touch this.
bfd63cd24 Michael Opdenacker    2013-06-26  101   * @lock_key:	Lock class key for use by the lock validator
8c97a46af Martin Liu            2018-05-31  102   * @need_parent_lock:	When probing or removing a device on this bus, the
8c97a46af Martin Liu            2018-05-31  103   *			device core should lock the device's parent.
880ffb5c6 Wanlong Gao           2011-05-05  104   *
880ffb5c6 Wanlong Gao           2011-05-05  105   * A bus is a channel between the processor and one or more devices. For the
880ffb5c6 Wanlong Gao           2011-05-05  106   * purposes of the device model, all devices are connected via a bus, even if
880ffb5c6 Wanlong Gao           2011-05-05  107   * it is an internal, virtual, "platform" bus. Buses can plug into each other.
880ffb5c6 Wanlong Gao           2011-05-05  108   * A USB controller is usually a PCI device, for example. The device model
880ffb5c6 Wanlong Gao           2011-05-05  109   * represents the actual connections between buses and the devices they control.
880ffb5c6 Wanlong Gao           2011-05-05  110   * A bus is represented by the bus_type structure. It contains the name, the
880ffb5c6 Wanlong Gao           2011-05-05  111   * default attributes, the bus' methods, PM operations, and the driver core's
880ffb5c6 Wanlong Gao           2011-05-05  112   * private data.
880ffb5c6 Wanlong Gao           2011-05-05  113   */
^1da177e4 Linus Torvalds        2005-04-16  114  struct bus_type {
8d790d740 Dmitry Torokhov       2005-04-26  115  	const char		*name;
ca22e56de Kay Sievers           2011-12-14  116  	const char		*dev_name;
ca22e56de Kay Sievers           2011-12-14  117  	struct device		*dev_root;
12478ba07 Greg Kroah-Hartman    2013-08-08  118  	const struct attribute_group **bus_groups;
fa6fdb33b Greg Kroah-Hartman    2013-08-08  119  	const struct attribute_group **dev_groups;
ed0617b5c Greg Kroah-Hartman    2013-08-08  120  	const struct attribute_group **drv_groups;
^1da177e4 Linus Torvalds        2005-04-16  121  
^1da177e4 Linus Torvalds        2005-04-16  122  	int (*match)(struct device *dev, struct device_driver *drv);
7eff2e7a8 Kay Sievers           2007-08-14  123  	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
594c8281f Russell King          2006-01-05  124  	int (*probe)(struct device *dev);
594c8281f Russell King          2006-01-05  125  	int (*remove)(struct device *dev);
594c8281f Russell King          2006-01-05  126  	void (*shutdown)(struct device *dev);
7c8265f51 Linus Torvalds        2006-06-24  127  
4f3549d72 Rafael J. Wysocki     2013-05-02  128  	int (*online)(struct device *dev);
4f3549d72 Rafael J. Wysocki     2013-05-02  129  	int (*offline)(struct device *dev);
4f3549d72 Rafael J. Wysocki     2013-05-02  130  
^1da177e4 Linus Torvalds        2005-04-16  131  	int (*suspend)(struct device *dev, pm_message_t state);
^1da177e4 Linus Torvalds        2005-04-16  132  	int (*resume)(struct device *dev);
b8c5cec23 Kay Sievers           2007-02-16  133  
582a686f5 Phil Sutter           2017-01-18  134  	int (*num_vf)(struct device *dev);
582a686f5 Phil Sutter           2017-01-18  135  
07397df29 Nipun Gupta           2018-04-28  136  	int (*dma_configure)(struct device *dev);
07397df29 Nipun Gupta           2018-04-28  137  
8150f32b9 Dmitry Torokhov       2009-07-24  138  	const struct dev_pm_ops *pm;
1eede070a Rafael J. Wysocki     2008-05-20  139  
b22f6434c Thierry Reding        2014-06-27  140  	const struct iommu_ops *iommu_ops;
ff21776d1 Joerg Roedel          2011-08-26  141  
6b6e39a6a Kay Sievers           2010-11-15  142  	struct subsys_private *p;
be871b7e5 Michal Hocko          2013-03-12  143  	struct lock_class_key lock_key;
d89e2378a Robin Murphy          2017-10-12  144  
8c97a46af Martin Liu            2018-05-31  145  	bool need_parent_lock;
1bb174019 Zhang Ning            2018-06-29  146  
1bb174019 Zhang Ning            2018-06-29  147  	bool manage_deferred;
1bb174019 Zhang Ning            2018-06-29  148  	struct list_head deferred_probe_pending_list;
^1da177e4 Linus Torvalds        2005-04-16  149  };
^1da177e4 Linus Torvalds        2005-04-16 @150  

:::::: The code at line 150 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vQEfM5zExfsPwbgr9upZAAA=

--7JfCtLOvnd9MIVvH--
