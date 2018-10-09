Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA49C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F112086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F112086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJIMMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:12:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:62529 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeJIMMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:12:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 21:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,359,1534834800"; 
   d="gz'50?scan'50,208,50";a="239686162"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Oct 2018 21:56:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g9k4k-0005hh-Je; Tue, 09 Oct 2018 12:56:54 +0800
Date:   Tue, 9 Oct 2018 12:56:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/4] gpio: Assign gpio_irq_chip::parents to non-stack
 pointer
Message-ID: <201810091251.jzXVZxHH%fengguang.wu@intel.com>
References: <20181008163216.97436-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20181008163216.97436-2-swboyd@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on gpio/for-next]
[also build test WARNING on v4.19-rc7 next-20181008]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/gpio-chip-cascade-fixes/20181009-041639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/mac80211.h:2328: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2328: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:977: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
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
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:105: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source private: For use by gpiochip_set_cascaded_irqchip()
>> include/linux/gpio/driver.h:167: warning: Function parameter or member 'parent_irq' not described in 'gpio_irq_chip'
   Error: Cannot open file drivers/gpio/devres.c
   Error: Cannot open file drivers/gpio/devres.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -export drivers/gpio/devres.c' failed with return code 2
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3011: warning: Excess function parameter 'dev' description in 'amdgpu_vm_get_task_info'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3012: warning: Function parameter or member 'adev' not described in 'amdgpu_vm_get_task_info'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3012: warning: Excess function parameter 'dev' description in 'amdgpu_vm_get_task_info'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_panel.h:98: warning: Function parameter or member 'link' not described in 'drm_panel'
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

vim +167 include/linux/gpio/driver.h

bb1e88cc Alexandre Courbot 2014-02-09   22  
c44eafd7 Thierry Reding    2017-11-07   23  #ifdef CONFIG_GPIOLIB_IRQCHIP
c44eafd7 Thierry Reding    2017-11-07   24  /**
c44eafd7 Thierry Reding    2017-11-07   25   * struct gpio_irq_chip - GPIO interrupt controller
c44eafd7 Thierry Reding    2017-11-07   26   */
c44eafd7 Thierry Reding    2017-11-07   27  struct gpio_irq_chip {
c44eafd7 Thierry Reding    2017-11-07   28  	/**
da80ff81 Thierry Reding    2017-11-07   29  	 * @chip:
da80ff81 Thierry Reding    2017-11-07   30  	 *
da80ff81 Thierry Reding    2017-11-07   31  	 * GPIO IRQ chip implementation, provided by GPIO driver.
da80ff81 Thierry Reding    2017-11-07   32  	 */
da80ff81 Thierry Reding    2017-11-07   33  	struct irq_chip *chip;
da80ff81 Thierry Reding    2017-11-07   34  
da80ff81 Thierry Reding    2017-11-07   35  	/**
f0fbe7bc Thierry Reding    2017-11-07   36  	 * @domain:
f0fbe7bc Thierry Reding    2017-11-07   37  	 *
f0fbe7bc Thierry Reding    2017-11-07   38  	 * Interrupt translation domain; responsible for mapping between GPIO
f0fbe7bc Thierry Reding    2017-11-07   39  	 * hwirq number and Linux IRQ number.
f0fbe7bc Thierry Reding    2017-11-07   40  	 */
f0fbe7bc Thierry Reding    2017-11-07   41  	struct irq_domain *domain;
f0fbe7bc Thierry Reding    2017-11-07   42  
f0fbe7bc Thierry Reding    2017-11-07   43  	/**
c44eafd7 Thierry Reding    2017-11-07   44  	 * @domain_ops:
c44eafd7 Thierry Reding    2017-11-07   45  	 *
c44eafd7 Thierry Reding    2017-11-07   46  	 * Table of interrupt domain operations for this IRQ chip.
c44eafd7 Thierry Reding    2017-11-07   47  	 */
c44eafd7 Thierry Reding    2017-11-07   48  	const struct irq_domain_ops *domain_ops;
c44eafd7 Thierry Reding    2017-11-07   49  
c44eafd7 Thierry Reding    2017-11-07   50  	/**
c7a0aa59 Thierry Reding    2017-11-07   51  	 * @handler:
c7a0aa59 Thierry Reding    2017-11-07   52  	 *
c7a0aa59 Thierry Reding    2017-11-07   53  	 * The IRQ handler to use (often a predefined IRQ core function) for
c7a0aa59 Thierry Reding    2017-11-07   54  	 * GPIO IRQs, provided by GPIO driver.
c7a0aa59 Thierry Reding    2017-11-07   55  	 */
c7a0aa59 Thierry Reding    2017-11-07   56  	irq_flow_handler_t handler;
c7a0aa59 Thierry Reding    2017-11-07   57  
c7a0aa59 Thierry Reding    2017-11-07   58  	/**
3634eeb0 Thierry Reding    2017-11-07   59  	 * @default_type:
3634eeb0 Thierry Reding    2017-11-07   60  	 *
3634eeb0 Thierry Reding    2017-11-07   61  	 * Default IRQ triggering type applied during GPIO driver
3634eeb0 Thierry Reding    2017-11-07   62  	 * initialization, provided by GPIO driver.
3634eeb0 Thierry Reding    2017-11-07   63  	 */
3634eeb0 Thierry Reding    2017-11-07   64  	unsigned int default_type;
3634eeb0 Thierry Reding    2017-11-07   65  
3634eeb0 Thierry Reding    2017-11-07   66  	/**
ca9df053 Thierry Reding    2017-11-07   67  	 * @lock_key:
ca9df053 Thierry Reding    2017-11-07   68  	 *
02ad0437 Randy Dunlap      2018-09-03   69  	 * Per GPIO IRQ chip lockdep class for IRQ lock.
ca9df053 Thierry Reding    2017-11-07   70  	 */
ca9df053 Thierry Reding    2017-11-07   71  	struct lock_class_key *lock_key;
02ad0437 Randy Dunlap      2018-09-03   72  
02ad0437 Randy Dunlap      2018-09-03   73  	/**
02ad0437 Randy Dunlap      2018-09-03   74  	 * @request_key:
02ad0437 Randy Dunlap      2018-09-03   75  	 *
02ad0437 Randy Dunlap      2018-09-03   76  	 * Per GPIO IRQ chip lockdep class for IRQ request.
02ad0437 Randy Dunlap      2018-09-03   77  	 */
39c3fd58 Andrew Lunn       2017-12-02   78  	struct lock_class_key *request_key;
ca9df053 Thierry Reding    2017-11-07   79  
ca9df053 Thierry Reding    2017-11-07   80  	/**
c44eafd7 Thierry Reding    2017-11-07   81  	 * @parent_handler:
c44eafd7 Thierry Reding    2017-11-07   82  	 *
c44eafd7 Thierry Reding    2017-11-07   83  	 * The interrupt handler for the GPIO chip's parent interrupts, may be
c44eafd7 Thierry Reding    2017-11-07   84  	 * NULL if the parent interrupts are nested rather than cascaded.
c44eafd7 Thierry Reding    2017-11-07   85  	 */
c44eafd7 Thierry Reding    2017-11-07   86  	irq_flow_handler_t parent_handler;
c44eafd7 Thierry Reding    2017-11-07   87  
c44eafd7 Thierry Reding    2017-11-07   88  	/**
c44eafd7 Thierry Reding    2017-11-07   89  	 * @parent_handler_data:
c44eafd7 Thierry Reding    2017-11-07   90  	 *
c44eafd7 Thierry Reding    2017-11-07   91  	 * Data associated, and passed to, the handler for the parent
c44eafd7 Thierry Reding    2017-11-07   92  	 * interrupt.
c44eafd7 Thierry Reding    2017-11-07   93  	 */
c44eafd7 Thierry Reding    2017-11-07   94  	void *parent_handler_data;
39e5f096 Thierry Reding    2017-11-07   95  
39e5f096 Thierry Reding    2017-11-07   96  	/**
39e5f096 Thierry Reding    2017-11-07   97  	 * @num_parents:
39e5f096 Thierry Reding    2017-11-07   98  	 *
39e5f096 Thierry Reding    2017-11-07   99  	 * The number of interrupt parents of a GPIO chip.
39e5f096 Thierry Reding    2017-11-07  100  	 */
39e5f096 Thierry Reding    2017-11-07  101  	unsigned int num_parents;
39e5f096 Thierry Reding    2017-11-07  102  
39e5f096 Thierry Reding    2017-11-07  103  	/**
7f91778d Stephen Boyd      2018-10-08  104  	 * private: For use by gpiochip_set_cascaded_irqchip()
7f91778d Stephen Boyd      2018-10-08 @105  	 */
7f91778d Stephen Boyd      2018-10-08  106  	unsigned int parent_irq;
7f91778d Stephen Boyd      2018-10-08  107  
7f91778d Stephen Boyd      2018-10-08  108  	/**
39e5f096 Thierry Reding    2017-11-07  109  	 * @parents:
39e5f096 Thierry Reding    2017-11-07  110  	 *
39e5f096 Thierry Reding    2017-11-07  111  	 * A list of interrupt parents of a GPIO chip. This is owned by the
39e5f096 Thierry Reding    2017-11-07  112  	 * driver, so the core will only reference this list, not modify it.
39e5f096 Thierry Reding    2017-11-07  113  	 */
39e5f096 Thierry Reding    2017-11-07  114  	unsigned int *parents;
dc6bafee Thierry Reding    2017-11-07  115  
dc6bafee Thierry Reding    2017-11-07  116  	/**
e0d89728 Thierry Reding    2017-11-07  117  	 * @map:
e0d89728 Thierry Reding    2017-11-07  118  	 *
e0d89728 Thierry Reding    2017-11-07  119  	 * A list of interrupt parents for each line of a GPIO chip.
e0d89728 Thierry Reding    2017-11-07  120  	 */
e0d89728 Thierry Reding    2017-11-07  121  	unsigned int *map;
e0d89728 Thierry Reding    2017-11-07  122  
e0d89728 Thierry Reding    2017-11-07  123  	/**
60ed54ca Thierry Reding    2017-11-07  124  	 * @threaded:
dc6bafee Thierry Reding    2017-11-07  125  	 *
60ed54ca Thierry Reding    2017-11-07  126  	 * True if set the interrupt handling uses nested threads.
dc6bafee Thierry Reding    2017-11-07  127  	 */
60ed54ca Thierry Reding    2017-11-07  128  	bool threaded;
dc7b0387 Thierry Reding    2017-11-07  129  
dc7b0387 Thierry Reding    2017-11-07  130  	/**
dc7b0387 Thierry Reding    2017-11-07  131  	 * @need_valid_mask:
dc7b0387 Thierry Reding    2017-11-07  132  	 *
dc7b0387 Thierry Reding    2017-11-07  133  	 * If set core allocates @valid_mask with all bits set to one.
dc7b0387 Thierry Reding    2017-11-07  134  	 */
dc7b0387 Thierry Reding    2017-11-07  135  	bool need_valid_mask;
dc7b0387 Thierry Reding    2017-11-07  136  
dc7b0387 Thierry Reding    2017-11-07  137  	/**
dc7b0387 Thierry Reding    2017-11-07  138  	 * @valid_mask:
dc7b0387 Thierry Reding    2017-11-07  139  	 *
dc7b0387 Thierry Reding    2017-11-07  140  	 * If not %NULL holds bitmask of GPIOs which are valid to be included
dc7b0387 Thierry Reding    2017-11-07  141  	 * in IRQ domain of the chip.
dc7b0387 Thierry Reding    2017-11-07  142  	 */
dc7b0387 Thierry Reding    2017-11-07  143  	unsigned long *valid_mask;
8302cf58 Thierry Reding    2017-11-07  144  
8302cf58 Thierry Reding    2017-11-07  145  	/**
8302cf58 Thierry Reding    2017-11-07  146  	 * @first:
8302cf58 Thierry Reding    2017-11-07  147  	 *
8302cf58 Thierry Reding    2017-11-07  148  	 * Required for static IRQ allocation. If set, irq_domain_add_simple()
8302cf58 Thierry Reding    2017-11-07  149  	 * will allocate and map all IRQs during initialization.
8302cf58 Thierry Reding    2017-11-07  150  	 */
8302cf58 Thierry Reding    2017-11-07  151  	unsigned int first;
461c1a7d Hans Verkuil      2018-09-08  152  
461c1a7d Hans Verkuil      2018-09-08  153  	/**
461c1a7d Hans Verkuil      2018-09-08  154  	 * @irq_enable:
461c1a7d Hans Verkuil      2018-09-08  155  	 *
461c1a7d Hans Verkuil      2018-09-08  156  	 * Store old irq_chip irq_enable callback
461c1a7d Hans Verkuil      2018-09-08  157  	 */
461c1a7d Hans Verkuil      2018-09-08  158  	void		(*irq_enable)(struct irq_data *data);
461c1a7d Hans Verkuil      2018-09-08  159  
461c1a7d Hans Verkuil      2018-09-08  160  	/**
461c1a7d Hans Verkuil      2018-09-08  161  	 * @irq_disable:
461c1a7d Hans Verkuil      2018-09-08  162  	 *
461c1a7d Hans Verkuil      2018-09-08  163  	 * Store old irq_chip irq_disable callback
461c1a7d Hans Verkuil      2018-09-08  164  	 */
461c1a7d Hans Verkuil      2018-09-08  165  	void		(*irq_disable)(struct irq_data *data);
c44eafd7 Thierry Reding    2017-11-07  166  };
da80ff81 Thierry Reding    2017-11-07 @167  

:::::: The code at line 167 was first introduced by commit
:::::: da80ff81a8f54611b834d73149f8ac0d59151c87 gpio: Move irqchip into struct gpio_irq_chip

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi--
