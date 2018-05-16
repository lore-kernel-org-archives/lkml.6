Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeEPIvK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:51:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:2554 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeEPIvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:51:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="gz'50?scan'50,208,50";a="229005943"
Date: Wed, 16 May 2018 16:50:30 +0800
From: kbuild test robot <lkp@intel.com>
To: Florian Schmaus <flo@geekplace.eu>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] driver-core: record error on bus registration
Message-ID: <201805161657.Vg6hRyk0%fengguang.wu@intel.com>
References: <20180515135114.31939-3-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20180515135114.31939-3-flo@geekplace.eu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.17-rc5 next-20180515]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Schmaus/return-EINVAL-error-instead-of-BUG_ON/20180516-141149
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
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
   kernel/sched/fair.c:3731: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
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
>> include/linux/device.h:143: warning: Function parameter or member 'bus_register_error' not described in 'bus_type'
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
