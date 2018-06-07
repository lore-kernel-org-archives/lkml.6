Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /g9HDfOzGVtgbAAAmS7hNA
	; Thu, 07 Jun 2018 22:38:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20AE9606FA; Thu,  7 Jun 2018 22:38:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6C1BC60290;
	Thu,  7 Jun 2018 22:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C1BC60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeFGWij (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:38:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:42538 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeFGWih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:38:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 15:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,488,1520924400";
   d="scan'208";a="235625769"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2018 15:38:35 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fR3YA-000Cyw-Jb; Fri, 08 Jun 2018 06:38:34 +0800
Date: Fri, 8 Jun 2018 06:37:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Jayant Chowdhary <jchowdhary@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jayant Chowdhary <jchowdhary@google.com>,
        akpm@linux-foundation.org, kernel-team@android.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] uapi: Make generic uapi headers compile standalone.
Message-ID: <201806080652.8WjxQoFE%fengguang.wu@intel.com>
References: <20180606231602.231326-1-jchowdhary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606231602.231326-1-jchowdhary@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayant,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17 next-20180607]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jayant-Chowdhary/uapi-Make-generic-uapi-headers-compile-standalone/20180608-014548
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/radeon/cik.c:6721:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6721:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6721:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6722:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6722:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6722:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6724:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6724:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6724:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6725:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6725:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6725:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6726:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6726:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6726:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6731:49: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6731:49:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6731:49:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6733:49: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6733:49:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6733:49:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6735:57: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6735:57:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6735:57:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6742:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6742:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6742:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6743:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6743:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6743:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6746:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6746:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6746:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6747:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6747:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6747:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6750:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6750:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6750:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6751:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6751:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6751:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6755:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6755:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6755:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6756:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6756:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6756:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6759:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6759:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6759:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6760:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6760:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6760:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6763:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6763:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6763:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6764:33: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6764:33:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6764:33:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6768:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6768:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6768:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6769:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6769:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6769:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6771:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6771:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6771:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6772:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned int volatile [unsigned] [usertype] <noident> @@    got latile [unsigned] [usertype] <noident> @@
   drivers/gpu/drm/radeon/cik.c:6772:25:    expected unsigned int volatile [unsigned] [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:6772:25:    got restricted __le32 [usertype] <noident>
   drivers/gpu/drm/radeon/cik.c:7497:24: sparse: cast to restricted __le32
   drivers/gpu/drm/radeon/cik.c:7587:27: sparse: cast to restricted __le32
   drivers/gpu/drm/radeon/cik.c:7588:28: sparse: cast to restricted __le32
   drivers/gpu/drm/radeon/cik.c:7589:27: sparse: cast to restricted __le32
   drivers/gpu/drm/radeon/cik.c:7497:24: sparse: cast to restricted __le32
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9065:16: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9142:15: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9142:15: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9144:22: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9144:22: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9262:29: sparse: expression using sizeof(void)
   drivers/gpu/drm/radeon/cik.c:9293:39: sparse: expression using sizeof(void)
>> drivers/gpu/drm/radeon/cik.c:9333:39: sparse: too many warnings

vim +9333 drivers/gpu/drm/radeon/cik.c

cd84a27d Alex Deucher  2012-07-20  9234  
cd84a27d Alex Deucher  2012-07-20  9235  /**
cd84a27d Alex Deucher  2012-07-20  9236   * dce8_program_watermarks - program display watermarks
cd84a27d Alex Deucher  2012-07-20  9237   *
cd84a27d Alex Deucher  2012-07-20  9238   * @rdev: radeon_device pointer
cd84a27d Alex Deucher  2012-07-20  9239   * @radeon_crtc: the selected display controller
cd84a27d Alex Deucher  2012-07-20  9240   * @lb_size: line buffer size
cd84a27d Alex Deucher  2012-07-20  9241   * @num_heads: number of display controllers in use
cd84a27d Alex Deucher  2012-07-20  9242   *
cd84a27d Alex Deucher  2012-07-20  9243   * Calculate and program the display watermarks for the
cd84a27d Alex Deucher  2012-07-20  9244   * selected display controller (CIK).
cd84a27d Alex Deucher  2012-07-20  9245   */
cd84a27d Alex Deucher  2012-07-20  9246  static void dce8_program_watermarks(struct radeon_device *rdev,
cd84a27d Alex Deucher  2012-07-20  9247  				    struct radeon_crtc *radeon_crtc,
cd84a27d Alex Deucher  2012-07-20  9248  				    u32 lb_size, u32 num_heads)
cd84a27d Alex Deucher  2012-07-20  9249  {
cd84a27d Alex Deucher  2012-07-20  9250  	struct drm_display_mode *mode = &radeon_crtc->base.mode;
58ea2dea Alex Deucher  2013-01-24  9251  	struct dce8_wm_params wm_low, wm_high;
e6b9a6c8 Mario Kleiner 2017-04-24  9252  	u32 active_time;
cd84a27d Alex Deucher  2012-07-20  9253  	u32 line_time = 0;
cd84a27d Alex Deucher  2012-07-20  9254  	u32 latency_watermark_a = 0, latency_watermark_b = 0;
cd84a27d Alex Deucher  2012-07-20  9255  	u32 tmp, wm_mask;
cd84a27d Alex Deucher  2012-07-20  9256  
cd84a27d Alex Deucher  2012-07-20  9257  	if (radeon_crtc->base.enabled && num_heads && mode) {
55f61a04 Mario Kleiner 2017-06-13  9258  		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
55f61a04 Mario Kleiner 2017-06-13  9259  					    (u32)mode->clock);
55f61a04 Mario Kleiner 2017-06-13  9260  		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
55f61a04 Mario Kleiner 2017-06-13  9261  					  (u32)mode->clock);
55f61a04 Mario Kleiner 2017-06-13  9262  		line_time = min(line_time, (u32)65535);
cd84a27d Alex Deucher  2012-07-20  9263  
58ea2dea Alex Deucher  2013-01-24  9264  		/* watermark for high clocks */
58ea2dea Alex Deucher  2013-01-24  9265  		if ((rdev->pm.pm_method == PM_METHOD_DPM) &&
58ea2dea Alex Deucher  2013-01-24  9266  		    rdev->pm.dpm_enabled) {
58ea2dea Alex Deucher  2013-01-24  9267  			wm_high.yclk =
58ea2dea Alex Deucher  2013-01-24  9268  				radeon_dpm_get_mclk(rdev, false) * 10;
58ea2dea Alex Deucher  2013-01-24  9269  			wm_high.sclk =
58ea2dea Alex Deucher  2013-01-24  9270  				radeon_dpm_get_sclk(rdev, false) * 10;
58ea2dea Alex Deucher  2013-01-24  9271  		} else {
58ea2dea Alex Deucher  2013-01-24  9272  			wm_high.yclk = rdev->pm.current_mclk * 10;
58ea2dea Alex Deucher  2013-01-24  9273  			wm_high.sclk = rdev->pm.current_sclk * 10;
58ea2dea Alex Deucher  2013-01-24  9274  		}
58ea2dea Alex Deucher  2013-01-24  9275  
58ea2dea Alex Deucher  2013-01-24  9276  		wm_high.disp_clk = mode->clock;
58ea2dea Alex Deucher  2013-01-24  9277  		wm_high.src_width = mode->crtc_hdisplay;
e6b9a6c8 Mario Kleiner 2017-04-24  9278  		wm_high.active_time = active_time;
58ea2dea Alex Deucher  2013-01-24  9279  		wm_high.blank_time = line_time - wm_high.active_time;
58ea2dea Alex Deucher  2013-01-24  9280  		wm_high.interlaced = false;
cd84a27d Alex Deucher  2012-07-20  9281  		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
58ea2dea Alex Deucher  2013-01-24  9282  			wm_high.interlaced = true;
58ea2dea Alex Deucher  2013-01-24  9283  		wm_high.vsc = radeon_crtc->vsc;
58ea2dea Alex Deucher  2013-01-24  9284  		wm_high.vtaps = 1;
cd84a27d Alex Deucher  2012-07-20  9285  		if (radeon_crtc->rmx_type != RMX_OFF)
58ea2dea Alex Deucher  2013-01-24  9286  			wm_high.vtaps = 2;
58ea2dea Alex Deucher  2013-01-24  9287  		wm_high.bytes_per_pixel = 4; /* XXX: get this from fb config */
58ea2dea Alex Deucher  2013-01-24  9288  		wm_high.lb_size = lb_size;
58ea2dea Alex Deucher  2013-01-24  9289  		wm_high.dram_channels = cik_get_number_of_dram_channels(rdev);
58ea2dea Alex Deucher  2013-01-24  9290  		wm_high.num_heads = num_heads;
cd84a27d Alex Deucher  2012-07-20  9291  
cd84a27d Alex Deucher  2012-07-20  9292  		/* set for high clocks */
58ea2dea Alex Deucher  2013-01-24  9293  		latency_watermark_a = min(dce8_latency_watermark(&wm_high), (u32)65535);
58ea2dea Alex Deucher  2013-01-24  9294  
58ea2dea Alex Deucher  2013-01-24  9295  		/* possibly force display priority to high */
58ea2dea Alex Deucher  2013-01-24  9296  		/* should really do this at mode validation time... */
58ea2dea Alex Deucher  2013-01-24  9297  		if (!dce8_average_bandwidth_vs_dram_bandwidth_for_display(&wm_high) ||
58ea2dea Alex Deucher  2013-01-24  9298  		    !dce8_average_bandwidth_vs_available_bandwidth(&wm_high) ||
58ea2dea Alex Deucher  2013-01-24  9299  		    !dce8_check_latency_hiding(&wm_high) ||
58ea2dea Alex Deucher  2013-01-24  9300  		    (rdev->disp_priority == 2)) {
58ea2dea Alex Deucher  2013-01-24  9301  			DRM_DEBUG_KMS("force priority to high\n");
58ea2dea Alex Deucher  2013-01-24  9302  		}
58ea2dea Alex Deucher  2013-01-24  9303  
58ea2dea Alex Deucher  2013-01-24  9304  		/* watermark for low clocks */
58ea2dea Alex Deucher  2013-01-24  9305  		if ((rdev->pm.pm_method == PM_METHOD_DPM) &&
58ea2dea Alex Deucher  2013-01-24  9306  		    rdev->pm.dpm_enabled) {
58ea2dea Alex Deucher  2013-01-24  9307  			wm_low.yclk =
58ea2dea Alex Deucher  2013-01-24  9308  				radeon_dpm_get_mclk(rdev, true) * 10;
58ea2dea Alex Deucher  2013-01-24  9309  			wm_low.sclk =
58ea2dea Alex Deucher  2013-01-24  9310  				radeon_dpm_get_sclk(rdev, true) * 10;
58ea2dea Alex Deucher  2013-01-24  9311  		} else {
58ea2dea Alex Deucher  2013-01-24  9312  			wm_low.yclk = rdev->pm.current_mclk * 10;
58ea2dea Alex Deucher  2013-01-24  9313  			wm_low.sclk = rdev->pm.current_sclk * 10;
58ea2dea Alex Deucher  2013-01-24  9314  		}
58ea2dea Alex Deucher  2013-01-24  9315  
58ea2dea Alex Deucher  2013-01-24  9316  		wm_low.disp_clk = mode->clock;
58ea2dea Alex Deucher  2013-01-24  9317  		wm_low.src_width = mode->crtc_hdisplay;
e6b9a6c8 Mario Kleiner 2017-04-24  9318  		wm_low.active_time = active_time;
58ea2dea Alex Deucher  2013-01-24  9319  		wm_low.blank_time = line_time - wm_low.active_time;
58ea2dea Alex Deucher  2013-01-24  9320  		wm_low.interlaced = false;
58ea2dea Alex Deucher  2013-01-24  9321  		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
58ea2dea Alex Deucher  2013-01-24  9322  			wm_low.interlaced = true;
58ea2dea Alex Deucher  2013-01-24  9323  		wm_low.vsc = radeon_crtc->vsc;
58ea2dea Alex Deucher  2013-01-24  9324  		wm_low.vtaps = 1;
58ea2dea Alex Deucher  2013-01-24  9325  		if (radeon_crtc->rmx_type != RMX_OFF)
58ea2dea Alex Deucher  2013-01-24  9326  			wm_low.vtaps = 2;
58ea2dea Alex Deucher  2013-01-24  9327  		wm_low.bytes_per_pixel = 4; /* XXX: get this from fb config */
58ea2dea Alex Deucher  2013-01-24  9328  		wm_low.lb_size = lb_size;
58ea2dea Alex Deucher  2013-01-24  9329  		wm_low.dram_channels = cik_get_number_of_dram_channels(rdev);
58ea2dea Alex Deucher  2013-01-24  9330  		wm_low.num_heads = num_heads;
58ea2dea Alex Deucher  2013-01-24  9331  
cd84a27d Alex Deucher  2012-07-20  9332  		/* set for low clocks */
58ea2dea Alex Deucher  2013-01-24 @9333  		latency_watermark_b = min(dce8_latency_watermark(&wm_low), (u32)65535);
cd84a27d Alex Deucher  2012-07-20  9334  
cd84a27d Alex Deucher  2012-07-20  9335  		/* possibly force display priority to high */
cd84a27d Alex Deucher  2012-07-20  9336  		/* should really do this at mode validation time... */
58ea2dea Alex Deucher  2013-01-24  9337  		if (!dce8_average_bandwidth_vs_dram_bandwidth_for_display(&wm_low) ||
58ea2dea Alex Deucher  2013-01-24  9338  		    !dce8_average_bandwidth_vs_available_bandwidth(&wm_low) ||
58ea2dea Alex Deucher  2013-01-24  9339  		    !dce8_check_latency_hiding(&wm_low) ||
cd84a27d Alex Deucher  2012-07-20  9340  		    (rdev->disp_priority == 2)) {
cd84a27d Alex Deucher  2012-07-20  9341  			DRM_DEBUG_KMS("force priority to high\n");
cd84a27d Alex Deucher  2012-07-20  9342  		}
5b5561b3 Mario Kleiner 2015-11-25  9343  
5b5561b3 Mario Kleiner 2015-11-25  9344  		/* Save number of lines the linebuffer leads before the scanout */
5b5561b3 Mario Kleiner 2015-11-25  9345  		radeon_crtc->lb_vblank_lead_lines = DIV_ROUND_UP(lb_size, mode->crtc_hdisplay);
cd84a27d Alex Deucher  2012-07-20  9346  	}
cd84a27d Alex Deucher  2012-07-20  9347  
cd84a27d Alex Deucher  2012-07-20  9348  	/* select wm A */
cd84a27d Alex Deucher  2012-07-20  9349  	wm_mask = RREG32(DPG_WATERMARK_MASK_CONTROL + radeon_crtc->crtc_offset);
cd84a27d Alex Deucher  2012-07-20  9350  	tmp = wm_mask;
cd84a27d Alex Deucher  2012-07-20  9351  	tmp &= ~LATENCY_WATERMARK_MASK(3);
cd84a27d Alex Deucher  2012-07-20  9352  	tmp |= LATENCY_WATERMARK_MASK(1);
cd84a27d Alex Deucher  2012-07-20  9353  	WREG32(DPG_WATERMARK_MASK_CONTROL + radeon_crtc->crtc_offset, tmp);
cd84a27d Alex Deucher  2012-07-20  9354  	WREG32(DPG_PIPE_LATENCY_CONTROL + radeon_crtc->crtc_offset,
cd84a27d Alex Deucher  2012-07-20  9355  	       (LATENCY_LOW_WATERMARK(latency_watermark_a) |
cd84a27d Alex Deucher  2012-07-20  9356  		LATENCY_HIGH_WATERMARK(line_time)));
cd84a27d Alex Deucher  2012-07-20  9357  	/* select wm B */
cd84a27d Alex Deucher  2012-07-20  9358  	tmp = RREG32(DPG_WATERMARK_MASK_CONTROL + radeon_crtc->crtc_offset);
cd84a27d Alex Deucher  2012-07-20  9359  	tmp &= ~LATENCY_WATERMARK_MASK(3);
cd84a27d Alex Deucher  2012-07-20  9360  	tmp |= LATENCY_WATERMARK_MASK(2);
cd84a27d Alex Deucher  2012-07-20  9361  	WREG32(DPG_WATERMARK_MASK_CONTROL + radeon_crtc->crtc_offset, tmp);
cd84a27d Alex Deucher  2012-07-20  9362  	WREG32(DPG_PIPE_LATENCY_CONTROL + radeon_crtc->crtc_offset,
cd84a27d Alex Deucher  2012-07-20  9363  	       (LATENCY_LOW_WATERMARK(latency_watermark_b) |
cd84a27d Alex Deucher  2012-07-20  9364  		LATENCY_HIGH_WATERMARK(line_time)));
cd84a27d Alex Deucher  2012-07-20  9365  	/* restore original selection */
cd84a27d Alex Deucher  2012-07-20  9366  	WREG32(DPG_WATERMARK_MASK_CONTROL + radeon_crtc->crtc_offset, wm_mask);
58ea2dea Alex Deucher  2013-01-24  9367  
58ea2dea Alex Deucher  2013-01-24  9368  	/* save values for DPM */
58ea2dea Alex Deucher  2013-01-24  9369  	radeon_crtc->line_time = line_time;
58ea2dea Alex Deucher  2013-01-24  9370  	radeon_crtc->wm_high = latency_watermark_a;
58ea2dea Alex Deucher  2013-01-24  9371  	radeon_crtc->wm_low = latency_watermark_b;
cd84a27d Alex Deucher  2012-07-20  9372  }
cd84a27d Alex Deucher  2012-07-20  9373  

:::::: The code at line 9333 was first introduced by commit
:::::: 58ea2deab36ecf0b416d3486442cc6df693dcc79 drm/radeon/kms: fix up dce8 display watermark calc for dpm

:::::: TO: Alex Deucher <alexander.deucher@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
