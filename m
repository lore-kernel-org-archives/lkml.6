Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZpV9Ljo8bBhlvmobMQma3E/inbmZD3TUl+smjZE5XvZ/dZpMTaCI5GxL2cXXODLCoqOGN1/
ARC-Seal: i=1; a=rsa-sha256; t=1526517554; cv=none;
        d=google.com; s=arc-20160816;
        b=as/1Wiz5zbZA9w1VXk2JVOUAdBpkA5KA44du20t7IaRe/29RUmTelBUg0hIl5ZWkn1
         GdJ/ULd4rZZsyqFtHoBpy6pn8EJ/zFuZddLv+aASPD4DiO9c92pn9/thTJQrXNkwNIbf
         KlvSPvbAbR71SYQBrMrO/dMBUV/CdfqiEc+dTZNjcsIvJQ9Hy8HT/34zYcBUEyje5rvG
         piYEqEtdQ5aoFZxcGiwXWTQlQSRrIqyD2p8KcpUO1aDUiIVT6Qdt8S655NUQzvGNnR3P
         NLJ2PhqaiIgxaSoaszWR9WHYxkZyUW8hTuM3R4Rra2gNLuMR6MZwpNBit49RxR53z9r2
         qGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WuSGR4kClvNd3pfqLJLi4GrSIIBwTIFhXc8n2V7ndXA=;
        b=c+i0k8dA/2o4dxlsE17EUuHIZC0d+1kGi5EfJUB+pkampCo47OglmIfp4PGNRSbRaS
         lP4ErznmLW/RcjunLBEeFx5TYs3YdBF40szIWJaCOEJWQMd2BXTRlo9Bl5V0u1noFrdI
         qkSTVEovvmaql2UQlvRRQNeujGQQ0QX8UtVKmfKU3x06Ho8nl56ZqAQLSS8ORm4Gx0vv
         h38bCGFOFqacOqUSQy2vDBZrnc/wc0e0nlK6P3A3jNjxAtqIixz1kaAGZBt3o0zcU1WN
         YUXIxdB59ogdEYH47N1vJ1or2vyhgq9IhGUwuak4YNbsBtvHtmM4Z6mKd/l7X7hgVXWD
         BIjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,408,1520924400";
   d="gz'50?scan'50,208,50";a="229246653"
Date: Thu, 17 May 2018 08:38:36 +0800
From: kbuild test robot <lkp@intel.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kbuild-all@01.org, gregkh@linuxfoundation.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 3/7] slimbus: core: add need_tid flag to
 slim_msg_txn
Message-ID: <201805170802.wUlcM2EI%fengguang.wu@intel.com>
References: <20180516113642.28136-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20180516113642.28136-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620594608427719?=
X-GMAIL-MSGID: =?utf-8?q?1600669671074645481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srinivas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc5 next-20180516]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/slimbus-fixes-and-some-helpers/20180517-061143
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
>> drivers/slimbus/slimbus.h:118: warning: Function parameter or member 'need_tid' not described in 'slim_msg_txn'
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
   include/linux/rcupdate.h:572: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:576: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:580: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:582: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:582: WARNING: Inline literal start-string without end-string.
   Documentation/crypto/crypto_engine.rst:13: ERROR: Unexpected indentation.
   Documentation/crypto/crypto_engine.rst:15: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/timer.c:1259: ERROR: Unexpected indentation.
   kernel/time/timer.c:1261: ERROR: Unexpected indentation.
   kernel/time/timer.c:1262: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1129: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:327: WARNING: Inline literal start-string without end-string.
   Documentation/driver-api/device_connection.rst:42: ERROR: Error in "kernel-doc" directive:
   maximum 4 argument(s) allowed, 7 supplied.

vim +118 drivers/slimbus/slimbus.h

afbdcc7c Sagar Dharia 2017-12-11 @118  

:::::: The code at line 118 was first introduced by commit
:::::: afbdcc7c384b0d446da08b1e0901dc176b41b9e0 slimbus: Add messaging APIs to slimbus framework

:::::: TO: Sagar Dharia <sdharia@codeaurora.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--82I3+IH0IqGh5yIs--
