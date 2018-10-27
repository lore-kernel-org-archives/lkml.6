Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9FC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 05:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885242075D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 05:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885242075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeJ0Oeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 10:34:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:15854 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbeJ0Oeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 10:34:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 22:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,430,1534834800"; 
   d="gz'50?scan'50,208,50";a="84551079"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2018 22:50:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gGHUg-0004yN-0G; Sat, 27 Oct 2018 13:50:42 +0800
Date:   Sat, 27 Oct 2018 13:50:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     kbuild-all@01.org, intel-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2 3/3] drm/i915: Add short HPD IRQ storm
 detection for non-MST systems
Message-ID: <201810271354.kPdyHfOz%fengguang.wu@intel.com>
References: <20181026224910.10138-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20181026224910.10138-4-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lyude,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lyude-Paul/drm-i915-HPD-IRQ-storm-detection-fixes/20181027-085424
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

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
   drivers/usb/typec/bus.c:1: warning: no structured comments found
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:382: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:383: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:554: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:554: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:554: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:554: warning: Function parameter or member 'end' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:554: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:602: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:602: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:602: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:602: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:847: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1355: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1522: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3095: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:609: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_mode_config.h:869: warning: Function parameter or member 'quirk_addfb_prefer_xbgr_30bpp' not described in 'drm_mode_config'
   drivers/gpu/drm/drm_fourcc.c:112: warning: Function parameter or member 'dev' not described in 'drm_driver_legacy_fb_format'
   drivers/gpu/drm/drm_fourcc.c:112: warning: Excess function parameter 'native' description in 'drm_driver_legacy_fb_format'
>> drivers/gpu/drm/i915/intel_hotplug.c:147: warning: Function parameter or member 'long_hpd' not described in 'intel_hpd_irq_storm_detect'
   drivers/gpu/drm/i915/i915_vma.h:49: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:554: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
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

vim +147 drivers/gpu/drm/i915/intel_hotplug.c

77913b39 Jani Nikula 2015-06-18  115  
77913b39 Jani Nikula 2015-06-18  116  /**
beb5d089 Lyude Paul  2018-10-26  117   * intel_hpd_irq_storm_detect - gather stats and detect HPD IRQ storm on a pin
77913b39 Jani Nikula 2015-06-18  118   * @dev_priv: private driver data pointer
77913b39 Jani Nikula 2015-06-18  119   * @pin: the pin to gather stats on
77913b39 Jani Nikula 2015-06-18  120   *
beb5d089 Lyude Paul  2018-10-26  121   * Gather stats about HPD IRQs from the specified @pin, and detect IRQ
77913b39 Jani Nikula 2015-06-18  122   * storms. Only the pin specific stats and state are changed, the caller is
77913b39 Jani Nikula 2015-06-18  123   * responsible for further action.
77913b39 Jani Nikula 2015-06-18  124   *
beb5d089 Lyude Paul  2018-10-26  125   * The number of IRQs that are allowed within @HPD_STORM_DETECT_PERIOD is
317eaa95 Lyude       2017-02-03  126   * stored in @dev_priv->hotplug.hpd_storm_threshold which defaults to
beb5d089 Lyude Paul  2018-10-26  127   * @HPD_STORM_DEFAULT_THRESHOLD. Long IRQs count as +10 to this threshold, and
beb5d089 Lyude Paul  2018-10-26  128   * short IRQs count as +1. If this threshold is exceeded, it's considered an
beb5d089 Lyude Paul  2018-10-26  129   * IRQ storm and the IRQ state is set to @HPD_MARK_DISABLED.
beb5d089 Lyude Paul  2018-10-26  130   *
beb5d089 Lyude Paul  2018-10-26  131   * By default, most systems will only count long IRQs towards
beb5d089 Lyude Paul  2018-10-26  132   * &dev_priv->hotplug.hpd_storm_threshold. However, some older systems also
beb5d089 Lyude Paul  2018-10-26  133   * suffer from short IRQ storms and must also track these. Because short IRQ
beb5d089 Lyude Paul  2018-10-26  134   * storms are naturally caused by sideband interactions with DP MST devices,
beb5d089 Lyude Paul  2018-10-26  135   * short IRQ detection is only enabled for systems without DP MST support.
beb5d089 Lyude Paul  2018-10-26  136   * Systems which are new enough to support DP MST are far less likely to
beb5d089 Lyude Paul  2018-10-26  137   * suffer from IRQ storms at all, so this is fine.
317eaa95 Lyude       2017-02-03  138   *
317eaa95 Lyude       2017-02-03  139   * The HPD threshold can be controlled through i915_hpd_storm_ctl in debugfs,
317eaa95 Lyude       2017-02-03  140   * and should only be adjusted for automated hotplug testing.
77913b39 Jani Nikula 2015-06-18  141   *
beb5d089 Lyude Paul  2018-10-26  142   * Return true if an IRQ storm was detected on @pin.
77913b39 Jani Nikula 2015-06-18  143   */
77913b39 Jani Nikula 2015-06-18  144  static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
beb5d089 Lyude Paul  2018-10-26  145  				       enum hpd_pin pin, bool long_hpd)
77913b39 Jani Nikula 2015-06-18  146  {
77913b39 Jani Nikula 2015-06-18 @147  	unsigned long start = dev_priv->hotplug.stats[pin].last_jiffies;
77913b39 Jani Nikula 2015-06-18  148  	unsigned long end = start + msecs_to_jiffies(HPD_STORM_DETECT_PERIOD);
317eaa95 Lyude       2017-02-03  149  	const int threshold = dev_priv->hotplug.hpd_storm_threshold;
beb5d089 Lyude Paul  2018-10-26  150  	const int increment = long_hpd ? 10 : 1;
77913b39 Jani Nikula 2015-06-18  151  	bool storm = false;
77913b39 Jani Nikula 2015-06-18  152  
beb5d089 Lyude Paul  2018-10-26  153  	if (!long_hpd && !dev_priv->hotplug.hpd_short_storm_enabled)
beb5d089 Lyude Paul  2018-10-26  154  		return false;
beb5d089 Lyude Paul  2018-10-26  155  
77913b39 Jani Nikula 2015-06-18  156  	if (!time_in_range(jiffies, start, end)) {
77913b39 Jani Nikula 2015-06-18  157  		dev_priv->hotplug.stats[pin].last_jiffies = jiffies;
77913b39 Jani Nikula 2015-06-18  158  		dev_priv->hotplug.stats[pin].count = 0;
77913b39 Jani Nikula 2015-06-18  159  		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: 0\n", pin);
317eaa95 Lyude       2017-02-03  160  	} else if (dev_priv->hotplug.stats[pin].count > threshold &&
317eaa95 Lyude       2017-02-03  161  		   threshold) {
77913b39 Jani Nikula 2015-06-18  162  		dev_priv->hotplug.stats[pin].state = HPD_MARK_DISABLED;
77913b39 Jani Nikula 2015-06-18  163  		DRM_DEBUG_KMS("HPD interrupt storm detected on PIN %d\n", pin);
77913b39 Jani Nikula 2015-06-18  164  		storm = true;
77913b39 Jani Nikula 2015-06-18  165  	} else {
beb5d089 Lyude Paul  2018-10-26  166  		dev_priv->hotplug.stats[pin].count += increment;
77913b39 Jani Nikula 2015-06-18  167  		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: %d\n", pin,
77913b39 Jani Nikula 2015-06-18  168  			      dev_priv->hotplug.stats[pin].count);
77913b39 Jani Nikula 2015-06-18  169  	}
77913b39 Jani Nikula 2015-06-18  170  
77913b39 Jani Nikula 2015-06-18  171  	return storm;
77913b39 Jani Nikula 2015-06-18  172  }
77913b39 Jani Nikula 2015-06-18  173  

:::::: The code at line 147 was first introduced by commit
:::::: 77913b39addfaa836929815515ff55cea1142b66 drm/i915: move generic hotplug code into new intel_hotplug.c file

:::::: TO: Jani Nikula <jani.nikula@intel.com>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--yrj/dFKFPuw6o+aM--
