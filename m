Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeERBpJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:45:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:57419 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeERBpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:45:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="gz'50?scan'50,208,50";a="47521718"
Date: Fri, 18 May 2018 09:44:26 +0800
From: kbuild test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: htmldocs: kernel/sched/fair.c:3704: warning: Function parameter or
 member 'flags' not described in 'attach_entity_load_avg'
Message-ID: <201805180923.W7ogR8Ak%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3acf4e395260e3bd30a6fa29ba7eada4bf7566ca
commit: ea14b57e8a181ac0561eba7a787e088f8c89f822 sched/cpufreq: Provide migration hint
date:   2 months ago
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.ablkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.blkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.cipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.compress' not described in 'crypto_alg'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.prev_bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2259: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2259: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:950: warning: Function parameter or member 'rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
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
>> kernel/sched/fair.c:3704: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
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
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.left' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.right' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.top' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.bottom' not described in 'drm_tv_connector_state'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.base' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.vbl' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.seq' not described in 'drm_pending_vblank_event'
   include/linux/skbuff.h:846: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__unused' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'pfmemalloc' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
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
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'

vim +3704 kernel/sched/fair.c

21e96f887 Steve Muckle   2016-03-21  3693  
3d30544f0 Peter Zijlstra 2016-06-21  3694  /**
3d30544f0 Peter Zijlstra 2016-06-21  3695   * attach_entity_load_avg - attach this entity to its cfs_rq load avg
3d30544f0 Peter Zijlstra 2016-06-21  3696   * @cfs_rq: cfs_rq to attach to
3d30544f0 Peter Zijlstra 2016-06-21  3697   * @se: sched_entity to attach
3d30544f0 Peter Zijlstra 2016-06-21  3698   *
3d30544f0 Peter Zijlstra 2016-06-21  3699   * Must call update_cfs_rq_load_avg() before this, since we rely on
3d30544f0 Peter Zijlstra 2016-06-21  3700   * cfs_rq->avg.last_update_time being current.
3d30544f0 Peter Zijlstra 2016-06-21  3701   */
ea14b57e8 Peter Zijlstra 2018-02-02  3702  static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
a05e8c51f Byungchul Park 2015-08-20  3703  {
f207934fb Peter Zijlstra 2017-05-12 @3704  	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
f207934fb Peter Zijlstra 2017-05-12  3705  
f207934fb Peter Zijlstra 2017-05-12  3706  	/*
f207934fb Peter Zijlstra 2017-05-12  3707  	 * When we attach the @se to the @cfs_rq, we must align the decay
f207934fb Peter Zijlstra 2017-05-12  3708  	 * window because without that, really weird and wonderful things can
f207934fb Peter Zijlstra 2017-05-12  3709  	 * happen.
f207934fb Peter Zijlstra 2017-05-12  3710  	 *
f207934fb Peter Zijlstra 2017-05-12  3711  	 * XXX illustrate
f207934fb Peter Zijlstra 2017-05-12  3712  	 */
a05e8c51f Byungchul Park 2015-08-20  3713  	se->avg.last_update_time = cfs_rq->avg.last_update_time;
f207934fb Peter Zijlstra 2017-05-12  3714  	se->avg.period_contrib = cfs_rq->avg.period_contrib;
f207934fb Peter Zijlstra 2017-05-12  3715  
f207934fb Peter Zijlstra 2017-05-12  3716  	/*
f207934fb Peter Zijlstra 2017-05-12  3717  	 * Hell(o) Nasty stuff.. we need to recompute _sum based on the new
f207934fb Peter Zijlstra 2017-05-12  3718  	 * period_contrib. This isn't strictly correct, but since we're
f207934fb Peter Zijlstra 2017-05-12  3719  	 * entirely outside of the PELT hierarchy, nobody cares if we truncate
f207934fb Peter Zijlstra 2017-05-12  3720  	 * _sum a little.
f207934fb Peter Zijlstra 2017-05-12  3721  	 */
f207934fb Peter Zijlstra 2017-05-12  3722  	se->avg.util_sum = se->avg.util_avg * divider;
f207934fb Peter Zijlstra 2017-05-12  3723  
f207934fb Peter Zijlstra 2017-05-12  3724  	se->avg.load_sum = divider;
f207934fb Peter Zijlstra 2017-05-12  3725  	if (se_weight(se)) {
f207934fb Peter Zijlstra 2017-05-12  3726  		se->avg.load_sum =
f207934fb Peter Zijlstra 2017-05-12  3727  			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
f207934fb Peter Zijlstra 2017-05-12  3728  	}
f207934fb Peter Zijlstra 2017-05-12  3729  
f207934fb Peter Zijlstra 2017-05-12  3730  	se->avg.runnable_load_sum = se->avg.load_sum;
f207934fb Peter Zijlstra 2017-05-12  3731  
8d5b9025f Peter Zijlstra 2017-08-24  3732  	enqueue_load_avg(cfs_rq, se);
a05e8c51f Byungchul Park 2015-08-20  3733  	cfs_rq->avg.util_avg += se->avg.util_avg;
a05e8c51f Byungchul Park 2015-08-20  3734  	cfs_rq->avg.util_sum += se->avg.util_sum;
0e2d2aaaa Peter Zijlstra 2017-05-08  3735  
0e2d2aaaa Peter Zijlstra 2017-05-08  3736  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
a2c6c91f9 Steve Muckle   2016-03-24  3737  
ea14b57e8 Peter Zijlstra 2018-02-02  3738  	cfs_rq_util_change(cfs_rq, flags);
a05e8c51f Byungchul Park 2015-08-20  3739  }
a05e8c51f Byungchul Park 2015-08-20  3740  

:::::: The code at line 3704 was first introduced by commit
:::::: f207934fb79d1af1de1a62b09d56a3a1914172c4 sched/fair: Align PELT windows between cfs_rq and its se

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGon/loAAy5jb25maWcAjFxbc+M2sn7Pr2AlVacmD5nxbRynTvkBAkEJEUEyBCjJfmEp
sjyjGlvySnIy8+9PN0CKt4b2bFU2EboB4tKXrxsN//LTLwF7P+5el8fNavny8iP4st6u98vj
+il43rys/zcI0yBJTSBCaT4Cc7zZvn//tLm+uw1uPl7efrz4bb+6Cabr/Xb9EvDd9nnz5R26
b3bbn34Bdp4mkRyXtzcjaYLNIdjujsFhffypal/c3ZbXV/c/Wr+bHzLRJi+4kWlShoKnocgb
YlqYrDBllOaKmfuf1y/P11e/4bR+rjlYzifQL3I/739e7ldfP32/u/20srM82EWUT+tn9/vU
L075NBRZqYssS3PTfFIbxqcmZ1wMaUoVzQ/7ZaVYVuZJWMLKdalkcn93js4W95e3NANPVcbM
fx2nw9YZLhEiLPW4DBUrY5GMzaSZ61gkIpe8lJohfUiYzIUcT0x/deyhnLCZKDNeRiFvqPlc
C1Uu+GTMwrBk8TjNpZmo4bicxXKUMyPgjGL20Bt/wnTJs6LMgbagaIxPRBnLBM5CPoqGw05K
C1NkZSZyOwbLRWtddjNqklAj+BXJXJuST4pk6uHL2FjQbG5GciTyhFlJzVKt5SgWPRZd6EzA
KXnIc5aYclLAVzIFZzWBOVMcdvNYbDlNPBp8w0qlLtPMSAXbEoIOwR7JZOzjDMWoGNvlsRgE
38dWZHk6ErohR3JRCpbHD/C7VKJ1vtnYMFgfCNpMxPr+6qTN+V/lPM1bWzcqZBzCREUpFq6P
7uiUmcDB4RKiFP6vNExjZ2tWxtZIvaApeX+DlnrEPJ2KpIQpaZW1DYk0pUhmsChQb9gZc399
mhfP4USs8kg4lZ9/boxW1VYaoSnbBdvF4pnINZx6p1+bULLCpERnK6ZTEBoRl+NHmfUEuKKM
gHJFk+LHtrK2KYtHX4/UR7hpCN05ndbUnlB7OX0GnNY5+uLxfO/0PPmG2Eow8ayIQXtSbRKm
4Aw/bHfb9a+tE9EPeiYzTo7tzh9EOM0fSmbAxk9IvkILMFi+o7TqwgpwkvAtOP64llQQ++Dw
/vfhx+G4fm0k9WR2QSusbhEWGUh6ks5pSi60yGfO5ChwjS1pByq4RQ7a7zSoo/46Y7kWyNS0
cXR5Oi2gD5gZwydh2jcYbZaQGUZ3noFND9Gkxwwt5QOPiXVZjZ8129T3Czge2I7E6LNEdIUl
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

--nFreZHaLTZJo0R7j--
