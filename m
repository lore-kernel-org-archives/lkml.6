Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C41C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE9020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE9020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967245AbeFSULV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:11:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:20245 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967194AbeFSULT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:11:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 13:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,244,1526367600"; 
   d="gz'50?scan'50,208,50";a="209427630"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2018 13:11:16 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fVMyB-000W2y-QJ; Wed, 20 Jun 2018 04:11:15 +0800
Date:   Wed, 20 Jun 2018 04:11:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     kbuild-all@01.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/2] iommu: Introduce interface for unsetting bus IOMMU
Message-ID: <201806200454.6xzM7B56%fengguang.wu@intel.com>
References: <1529426734-20639-2-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <1529426734-20639-2-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Suravee,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.18-rc1 next-20180619]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suravee-Suthikulpanit/iommu-amd-Handle-IOMMU-initialization-failure/20180620-022013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
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
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/sched/fair.c:3719: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
>> include/linux/device.h:143: warning: Function parameter or member 'iommu_nb' not described in 'bus_type'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/mtd/rawnand.h:752: warning: Function parameter or member 'timings.sdr' not described in 'nand_data_interface'
   include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf.in' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf.out' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.cmd' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.data' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.waitrdy' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:1016: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1016: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1016: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1319: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
   include/linux/mtd/rawnand.h:1319: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
   include/linux/regulator/driver.h:222: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4306: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/usb/typec/mux.c:186: warning: Function parameter or member 'mux' not described in 'typec_mux_unregister'
   drivers/usb/typec/mux.c:186: warning: Excess function parameter 'sw' description in 'typec_mux_unregister'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   drivers/gpu/drm/drm_prime.c:342: warning: Function parameter or member 'attach' not described in 'drm_gem_unmap_dma_buf'
   drivers/gpu/drm/drm_prime.c:342: warning: Function parameter or member 'sgt' not described in 'drm_gem_unmap_dma_buf'
   drivers/gpu/drm/drm_prime.c:342: warning: Function parameter or member 'dir' not described in 'drm_gem_unmap_dma_buf'
   drivers/gpu/drm/drm_prime.c:438: warning: Function parameter or member 'dma_buf' not described in 'drm_gem_dmabuf_kmap_atomic'
   drivers/gpu/drm/drm_prime.c:438: warning: Function parameter or member 'page_num' not described in 'drm_gem_dmabuf_kmap_atomic'
   drivers/gpu/drm/drm_prime.c:450: warning: Function parameter or member 'dma_buf' not described in 'drm_gem_dmabuf_kunmap_atomic'
   drivers/gpu/drm/drm_prime.c:450: warning: Function parameter or member 'page_num' not described in 'drm_gem_dmabuf_kunmap_atomic'
   drivers/gpu/drm/drm_prime.c:450: warning: Function parameter or member 'addr' not described in 'drm_gem_dmabuf_kunmap_atomic'
   drivers/gpu/drm/drm_prime.c:461: warning: Function parameter or member 'dma_buf' not described in 'drm_gem_dmabuf_kmap'
   drivers/gpu/drm/drm_prime.c:461: warning: Function parameter or member 'page_num' not described in 'drm_gem_dmabuf_kmap'
   drivers/gpu/drm/drm_prime.c:473: warning: Function parameter or member 'dma_buf' not described in 'drm_gem_dmabuf_kunmap'
   drivers/gpu/drm/drm_prime.c:473: warning: Function parameter or member 'page_num' not described in 'drm_gem_dmabuf_kunmap'
   drivers/gpu/drm/drm_prime.c:473: warning: Function parameter or member 'addr' not described in 'drm_gem_dmabuf_kunmap'
   include/media/v4l2-dev.h:42: warning: Enum value 'VFL_TYPE_MAX' not described in enum 'vfl_devnode_type'
   include/linux/skbuff.h:850: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member '__unused' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'pfmemalloc' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:850: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
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
   include/net/sock.h:488: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:488: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:488: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:488: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:488: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:488: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:488: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:1955: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'

vim +143 include/linux/device.h

^1da177e Linus Torvalds 2005-04-16 @143  

:::::: The code at line 143 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--9jxsPFA5p3P2qPhR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9jxsPFA5p3P2qPhR--
