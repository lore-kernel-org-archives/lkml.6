Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbeDBH6R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 03:58:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:10524 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754241AbeDBH6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 03:58:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,394,1517904000";
   d="gz'50?scan'50,208,50";a="43254096"
Date: Mon, 2 Apr 2018 15:57:07 +0800
From: kbuild test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/45] C++: Avoid using 'compl' and 'and' as names
Message-ID: <201804021422.o8wv5HLr%fengguang.wu@intel.com>
References: <152261540175.30503.3674118602569067854.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <152261540175.30503.3674118602569067854.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc7]
[cannot apply to linus/master tip/x86/core tip/locking/core v4.16 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Howells/C-Convert-the-kernel-to-C/20180402-120344
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/kernel.h:251: warning: cannot understand function prototype: 'template<typename T> static inline T abs(T v) '
   include/linux/kernel.h:251: warning: cannot understand function prototype: 'template<typename T> static inline T abs(T v) '
   arch/x86/include/asm/uaccess.h:177: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int get_user(VAL &x, TYPE '
   arch/x86/include/asm/uaccess.h:219: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int put_user(VAL x, TYPE '
   arch/x86/include/asm/uaccess.h:315: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int __get_user_unsafe_nozero(VAL &x, const TYPE int err=-EFAULT) '
   arch/x86/include/asm/uaccess.h:366: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int __get_user_unsafe(VAL &x, const TYPE int err=-EFAULT) '
   arch/x86/include/asm/uaccess.h:438: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int __get_user(VAL &x, const TYPE '
   arch/x86/include/asm/uaccess.h:452: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int __put_user_unsafe(VAL x, TYPE int err=-EFAULT) '
   arch/x86/include/asm/uaccess.h:521: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline int __put_user(VAL x, TYPE int err=-EFAULT) '
   arch/x86/include/asm/uaccess.h:540: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline void get_user_ex(VAL &x, const TYPE '
   arch/x86/include/asm/uaccess.h:587: warning: cannot understand function prototype: 'template <typename VAL, typename TYPE> static inline void put_user_ex(VAL x, TYPE '
   include/linux/rcupdate.h:424: warning: cannot understand function prototype: 'template <typename T> static inline void rcu_assign_pointer(T T '
   include/linux/rcupdate.h:503: warning: cannot understand function prototype: 'template <typename T> T bool c) '
   include/linux/rcupdate.h:844: warning: cannot understand function prototype: 'template <typename T> static inline void RCU_INIT_POINTER(T T '
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.ablkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.blkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.cipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.compress' not described in 'crypto_alg'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
>> include/linux/crypto.h:1038: warning: Function parameter or member 'c' not described in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
   include/linux/crypto.h:1038: warning: Excess function parameter 'compl' description in 'ablkcipher_request_set_callback'
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
   include/net/mac80211.h:2263: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2263: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
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
   include/linux/kernel.h:252: warning: cannot understand function prototype: 'template<typename T> static inline T abs(T v) '
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

vim +1038 include/linux/crypto.h

32e3983f Herbert Xu      2007-03-24  1009  
f13ec330 Stephan Mueller 2014-11-12  1010  /**
f13ec330 Stephan Mueller 2014-11-12  1011   * ablkcipher_request_set_callback() - set asynchronous callback function
f13ec330 Stephan Mueller 2014-11-12  1012   * @req: request handle
f13ec330 Stephan Mueller 2014-11-12  1013   * @flags: specify zero or an ORing of the flags
f13ec330 Stephan Mueller 2014-11-12  1014   *	   CRYPTO_TFM_REQ_MAY_BACKLOG the request queue may back log and
f13ec330 Stephan Mueller 2014-11-12  1015   *	   increase the wait queue beyond the initial maximum size;
f13ec330 Stephan Mueller 2014-11-12  1016   *	   CRYPTO_TFM_REQ_MAY_SLEEP the request processing may sleep
f13ec330 Stephan Mueller 2014-11-12  1017   * @compl: callback function pointer to be registered with the request handle
f13ec330 Stephan Mueller 2014-11-12  1018   * @data: The data pointer refers to memory that is not used by the kernel
f13ec330 Stephan Mueller 2014-11-12  1019   *	  crypto API, but provided to the callback function for it to use. Here,
f13ec330 Stephan Mueller 2014-11-12  1020   *	  the caller can provide a reference to memory the callback function can
f13ec330 Stephan Mueller 2014-11-12  1021   *	  operate on. As the callback function is invoked asynchronously to the
f13ec330 Stephan Mueller 2014-11-12  1022   *	  related functionality, it may need to access data structures of the
f13ec330 Stephan Mueller 2014-11-12  1023   *	  related functionality which can be referenced using this pointer. The
f13ec330 Stephan Mueller 2014-11-12  1024   *	  callback function can access the memory via the "data" field in the
f13ec330 Stephan Mueller 2014-11-12  1025   *	  crypto_async_request data structure provided to the callback function.
f13ec330 Stephan Mueller 2014-11-12  1026   *
f13ec330 Stephan Mueller 2014-11-12  1027   * This function allows setting the callback function that is triggered once the
f13ec330 Stephan Mueller 2014-11-12  1028   * cipher operation completes.
f13ec330 Stephan Mueller 2014-11-12  1029   *
f13ec330 Stephan Mueller 2014-11-12  1030   * The callback function is registered with the ablkcipher_request handle and
0184cfe7 Stephan Mueller 2016-10-21  1031   * must comply with the following template::
f13ec330 Stephan Mueller 2014-11-12  1032   *
f13ec330 Stephan Mueller 2014-11-12  1033   *	void callback_function(struct crypto_async_request *req, int error)
f13ec330 Stephan Mueller 2014-11-12  1034   */
32e3983f Herbert Xu      2007-03-24  1035  static inline void ablkcipher_request_set_callback(
32e3983f Herbert Xu      2007-03-24  1036  	struct ablkcipher_request *req,
72e380ca David Howells   2018-04-01  1037  	u32 flags, crypto_completion_t c, void *data)
32e3983f Herbert Xu      2007-03-24 @1038  {
72e380ca David Howells   2018-04-01  1039  	req->base.complete = c;
32e3983f Herbert Xu      2007-03-24  1040  	req->base.data = data;
32e3983f Herbert Xu      2007-03-24  1041  	req->base.flags = flags;
32e3983f Herbert Xu      2007-03-24  1042  }
32e3983f Herbert Xu      2007-03-24  1043  

:::::: The code at line 1038 was first introduced by commit
:::::: 32e3983fe590ac4cd70c7728eb330d43cef031a7 [CRYPTO] api: Add async block cipher interface

:::::: TO: Herbert Xu <herbert@gondor.apana.org.au>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZGiS0Q5IWpPtfppv--
