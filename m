Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980320856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C980320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeH1Xme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:42:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:39708 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1Xme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:42:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 12:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="gz'50?scan'50,208,50";a="257982158"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2018 12:49:22 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fujz6-000HdI-9w; Wed, 29 Aug 2018 03:49:04 +0800
Date:   Wed, 29 Aug 2018 03:48:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     kbuild-all@01.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 3/4] drm/dp_mst: Add dp_mst_status debugfs node for all
 drivers
Message-ID: <201808290345.ljcv2UTC%fengguang.wu@intel.com>
References: <20180828003635.8200-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20180828003635.8200-4-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lyude,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc1 next-20180828]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lyude-Paul/drm-dp_mst-Add-DP-MST-debugfs-nodes-for-all-drivers/20180828-083742
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/net/mac80211.h:977: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
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
   include/linux/mod_devicetable.h:763: warning: Function parameter or member 'driver_data' not described in 'typec_device_id'
   kernel/sched/fair.c:3371: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'i' description in 'arch_atomic_sub_and_test'
   arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'v' description in 'arch_atomic_sub_and_test'
   arch/x86/include/asm/atomic.h:96: warning: Excess function parameter 'v' description in 'arch_atomic_inc'
   arch/x86/include/asm/atomic.h:109: warning: Excess function parameter 'v' description in 'arch_atomic_dec'
   arch/x86/include/asm/atomic.h:124: warning: Excess function parameter 'v' description in 'arch_atomic_dec_and_test'
   arch/x86/include/asm/atomic.h:138: warning: Excess function parameter 'v' description in 'arch_atomic_inc_and_test'
   arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'i' description in 'arch_atomic_add_negative'
   arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'v' description in 'arch_atomic_add_negative'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   drivers/pci/pci.c:218: warning: Excess function parameter 'p' description in 'pci_dev_str_match_path'
   include/linux/regulator/driver.h:227: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   drivers/regulator/core.c:4479: warning: Excess function parameter 'state' description in 'regulator_suspend'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/slimbus/stream.c:1: warning: no structured comments found
   drivers/target/target_core_device.c:1: warning: no structured comments found
   drivers/usb/dwc3/gadget.c:510: warning: Excess function parameter 'dwc' description in 'dwc3_gadget_start_config'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/bus.c:1: warning: no structured comments found
   drivers/usb/typec/bus.c:268: warning: Function parameter or member 'mode' not described in 'typec_match_altmode'
   drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
   drivers/usb/typec/class.c:1: warning: no structured comments found
   include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/direct-io.c:257: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/file_table.c:1: warning: no structured comments found
   fs/libfs.c:477: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:254: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_invalidate_range_start_gfx'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:302: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2986: warning: Excess function parameter 'dev' description in 'amdgpu_vm_get_task_info'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2987: warning: Function parameter or member 'adev' not described in 'amdgpu_vm_get_task_info'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2987: warning: Excess function parameter 'dev' description in 'amdgpu_vm_get_task_info'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_panel.h:98: warning: Function parameter or member 'link' not described in 'drm_panel'
   drivers/gpu/drm/drm_dp_mst_topology.c:3273: warning: Excess function parameter 'conn_base_id' description in 'drm_dp_mst_topology_mgr_init'
>> include/drm/drm_dp_mst_helper.h:586: warning: Function parameter or member 'debugfs' not described in 'drm_dp_mst_topology_mgr'
   drivers/gpu/drm/drm_dp_mst_topology.c:3274: warning: Function parameter or member 'connector' not described in 'drm_dp_mst_topology_mgr_init'
   drivers/gpu/drm/drm_dp_mst_topology.c:3274: warning: Excess function parameter 'conn_base_id' description in 'drm_dp_mst_topology_mgr_init'
   drivers/gpu/drm/i915/i915_vma.h:49: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:553: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   include/linux/skbuff.h:860: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:860: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:509: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2018: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   sound/soc/soc-core.c:2918: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'
   Documentation/admin-guide/cgroup-v2.rst:1485: WARNING: Block quote ends without a blank line; unexpected unindent.
   Documentation/admin-guide/cgroup-v2.rst:1487: WARNING: Block quote ends without a blank line; unexpected unindent.
   Documentation/admin-guide/cgroup-v2.rst:1488: WARNING: Block quote ends without a blank line; unexpected unindent.
   Documentation/core-api/boot-time-mm.rst:78: ERROR: Error in "kernel-doc" directive:
   unknown option: "nodocs".

vim +586 include/drm/drm_dp_mst_helper.h

ad7f8a1f Dave Airlie 2014-06-05 @586  

:::::: The code at line 586 was first introduced by commit
:::::: ad7f8a1f9ced7f049f9b66d588723f243a7034cd drm/helper: add Displayport multi-stream helper (v0.6)

:::::: TO: Dave Airlie <airlied@redhat.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
