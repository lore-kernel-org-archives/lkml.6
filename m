Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E67C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F92F20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F92F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbeHALrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:47:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:42576 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388818AbeHALrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:47:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 02:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,431,1526367600"; 
   d="gz'50?scan'50,208,50";a="76349720"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2018 02:53:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fknoh-000EHo-8h; Wed, 01 Aug 2018 17:53:15 +0800
Date:   Wed, 1 Aug 2018 17:53:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     kbuild-all@01.org, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/8] drm/fb_helper: Introduce hotplug_suspend/resume()
Message-ID: <201808011735.EYRUJCEd%fengguang.wu@intel.com>
References: <20180731003954.19962-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20180731003954.19962-4-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lyude,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc7]
[cannot apply to next-20180731]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lyude-Paul/Fix-connector-probing-deadlocks-from-RPM-bugs/20180801-153816
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
>> drivers/gpu/drm/drm_fb_helper.c:2750: warning: Function parameter or member 'fb_helper' not described in 'drm_fb_helper_resume_hotplug'
   drivers/gpu/drm/i915/i915_vma.h:48: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   include/drm/tinydrm/tinydrm.h:34: warning: Function parameter or member 'fb_dirty' not described in 'tinydrm_device'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'crtc_state' not described in 'mipi_dbi_enable_flush'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'plane_state' not described in 'mipi_dbi_enable_flush'
   include/linux/skbuff.h:852: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:852: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:234: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:493: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:493: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:1997: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   sound/soc/soc-core.c:2787: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'
   include/linux/rcupdate.h:571: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:575: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:579: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:581: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:581: WARNING: Inline literal start-string without end-string.
   lib/reed_solomon/reed_solomon.c:287: ERROR: Unknown target name: "gfp".
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1129: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:327: WARNING: Inline literal start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/ata/libata-core.c:5946: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5054: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1892: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/mtd/rawnand.h:1446: WARNING: Inline strong start-string without end-string.
   include/linux/mtd/rawnand.h:1448: WARNING: Inline strong start-string without end-string.
   include/linux/regulator/driver.h:279: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   Documentation/driver-api/soundwire/locking.rst:50: ERROR: Inconsistent literal block quoting.
   Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
   Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
   Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.
   Documentation/driver-api/soundwire/stream.rst:177: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:203: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:248: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:277: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:304: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:328: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:352: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   Documentation/driver-api/soundwire/stream.rst:364: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   include/linux/spi/spi.h:373: ERROR: Unexpected indentation.
   block/bio.c:958: WARNING: Inline emphasis start-string without end-string.
   Documentation/gpu/drivers.rst:5: WARNING: toctree contains reference to nonexisting document u'gpu/v3d'
   Documentation/misc-devices/ibmvmc.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
   net/core/dev.c:4650: ERROR: Unknown target name: "page_is".
   Documentation/networking/net_failover.rst:48: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/networking/net_failover.rst:50: ERROR: Unexpected indentation.

vim +2750 drivers/gpu/drm/drm_fb_helper.c

  2735	
  2736	/**
  2737	 * drm_fb_helper_resume_hotplug - Allow fb_helper to handle probing new
  2738	 *                                connectors again, and bring it up to date
  2739	 *                                with the current device's connector status
  2740	 * fb_helper: driver-allocated fbdev helper, can be NULL
  2741	 *
  2742	 * Allow fb_helper to react to connector status changes again after having
  2743	 * been disabled through drm_fb_helper_suspend_hotplug(). This also schedules
  2744	 * a fb_helper hotplug event to bring fb_helper up to date with the current
  2745	 * status of the DRM device's connectors.
  2746	 */
  2747	void
  2748	drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper)
  2749	{
> 2750		fb_helper->hotplug_suspended = false;
  2751		drm_fb_helper_hotplug_event(fb_helper);
  2752	}
  2753	EXPORT_SYMBOL(drm_fb_helper_resume_hotplug);
  2754	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
egM+ZjiJi/cfHEd3TepZAAA=

--3MwIy2ne0vdjdPXF--
