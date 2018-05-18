Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeERKYG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:24:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:37882 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752467AbeERKYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:24:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="gz'50?scan'50,208,50";a="225305269"
Date: Fri, 18 May 2018 18:23:35 +0800
From: kbuild test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: htmldocs: include/net/sock.h:488: warning: Function parameter or
 member 'sk_route_forced_caps' not described in 'sock'
Message-ID: <201805181826.BBionexX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3acf4e395260e3bd30a6fa29ba7eada4bf7566ca
commit: 0a6b2a1dc2a2105f178255fe495eb914b09cb37a tcp: switch to GSO being always on
date:   3 months ago
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu' not described in 'sta_info'
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
   include/linux/device.h:294: warning: Function parameter or member 'coredump' not described in 'device_driver'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/mtd/rawnand.h:709: warning: Function parameter or member 'timings.sdr' not described in 'nand_data_interface'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf.in' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf.out' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.cmd' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.data' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.waitrdy' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1281: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
   include/linux/mtd/rawnand.h:1281: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
   include/linux/regulator/driver.h:221: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4299: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.left' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.right' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.top' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.bottom' not described in 'drm_tv_connector_state'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.base' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.vbl' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.seq' not described in 'drm_pending_vblank_event'
   drivers/gpu/drm/tve200/tve200_drv.c:1: warning: no structured comments found
   include/linux/skbuff.h:849: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member '__unused' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'pfmemalloc' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:849: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
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
>> include/net/sock.h:488: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:1946: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/linux/rcupdate.h:570: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:574: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:578: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:580: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:580: WARNING: Inline literal start-string without end-string.
   kernel/time/timer.c:1259: ERROR: Unexpected indentation.
   kernel/time/timer.c:1261: ERROR: Unexpected indentation.
   kernel/time/timer.c:1262: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1113: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:327: WARNING: Inline literal start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   include/linux/iio/iio.h:191: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:192: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:198: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/ata/libata-core.c:5920: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5052: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1901: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/mtd/rawnand.h:805: ERROR: Unexpected indentation.
   include/linux/mtd/rawnand.h:1391: WARNING: Inline strong start-string without end-string.
   include/linux/mtd/rawnand.h:1393: WARNING: Inline strong start-string without end-string.
   include/linux/regulator/driver.h:273: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   Documentation/driver-api/slimbus.rst:93: WARNING: Title underline too short.

vim +488 include/net/sock.h

^1da177e Linus Torvalds 2005-04-16 @488  

:::::: The code at line 488 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7AUc2qLy4jB3hD7Z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
piaMoYSxOTsqLDIBZRG6RbsV1+cfPa5KW+lhAAA=

--7AUc2qLy4jB3hD7Z--
