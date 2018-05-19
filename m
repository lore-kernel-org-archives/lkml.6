Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeESPbm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:31:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:44305 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752344AbeESPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:31:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,419,1520924400";
   d="gz'50?scan'50,208,50";a="41223183"
Date: Sat, 19 May 2018 23:30:59 +0800
From: kbuild test robot <lkp@intel.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: kbuild-all@01.org, jic23@kernel.org, benjamin.gaignard@st.com,
        fabrice.gasnier@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v6 3/9] docs: Add Generic Counter interface documentation
Message-ID: <201805192014.VlonzXzA%fengguang.wu@intel.com>
References: <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc5 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introduce-the-Counter-subsystem/20180519-151353
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
>> include/linux/counter.h:330: warning: Function parameter or member 'groups_list' not described in 'counter_device_state'
>> include/linux/counter.h:330: warning: Function parameter or member 'num_groups' not described in 'counter_device_state'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
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
   include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1313: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
   include/linux/mtd/rawnand.h:1313: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
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

vim +330 include/linux/counter.h

624995ae William Breathitt Gray 2018-05-16 @330  

:::::: The code at line 330 was first introduced by commit
:::::: 624995aed3646d19eb4ce4cd7f527fe95a165a92 counter: Introduce the Generic Counter interface

:::::: TO: William Breathitt Gray <vilhelm.gray@gmail.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J2SCkAp4GZ/dPZZf--
