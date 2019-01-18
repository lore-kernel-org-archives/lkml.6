Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C552054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfAROoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:44:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:57816 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfAROoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:44:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 06:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="115697668"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 18 Jan 2019 06:44:25 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 18 Jan 2019 16:44:24 +0200
Date:   Fri, 18 Jan 2019 16:44:24 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        'Hans Verkuil' <hans.verkuil@cisco.com>
Subject: Re: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
Message-ID: <20190118144424.GL20097@intel.com>
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
 <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
 <20190117194722.GJ20097@intel.com>
 <b9cfbae1-b24e-96bf-f3b0-ff6d25cd16bb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9cfbae1-b24e-96bf-f3b0-ff6d25cd16bb@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:34:18PM +0100, Andrzej Hajda wrote:
> +CC: Hans
> 
> On 17.01.2019 20:47, Ville Syrjälä wrote:
> > On Fri, Dec 14, 2018 at 01:10:16PM +0100, Christoph Manszewski wrote:
> >> Range setting makes sense for YCbCr and RGB buffers. Current
> >> drm_color_range enum labels suggest use with YCbCr buffers.
> >> Create enum labels without colorspace specification.
> >>
> >> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> >> ---
> >>  include/drm/drm_color_mgmt.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> >> index 90ef9996d9a4..52f6d5221a0d 100644
> >> --- a/include/drm/drm_color_mgmt.h
> >> +++ b/include/drm/drm_color_mgmt.h
> >> @@ -62,6 +62,8 @@ enum drm_color_range {
> >>  	DRM_COLOR_YCBCR_LIMITED_RANGE,
> >>  	DRM_COLOR_YCBCR_FULL_RANGE,
> >>  	DRM_COLOR_RANGE_MAX,
> >> +	DRM_COLOR_LIMITED_RANGE = DRM_COLOR_YCBCR_LIMITED_RANGE,
> >> +	DRM_COLOR_FULL_RANGE = DRM_COLOR_YCBCR_FULL_RANGE,
> > These enum values don't mean anything really. The strings are what
> > matter for the uapi.
> >
> > The default for YCbCr needs to be limited range, the default for RGB
> > needs to be full range. So I think this would really require a separate
> > prop for each.
> >
> > But is there an actual usecase for this stuff?
> 
> 
> Yes, for example HDMI path (Display Controller and HDMI encoder) in
> Exynos5433 works on RGB buffers and do not perform any conversion if the
> output is also RGB, on the other side CEA861 specs says that in case of
> CEA modes output RGB should be in limited range, in case of non CEA
> modes it should be full range.
> 
> The idea was to allow userspace to check (atomic_check) which ranges are
> acceptable in given mode and to set desired one if possible.
> 
> Any better solution is welcome?

i915 has the "Broadcast RGB" property for the CEA-861 stuff.
You don't have a way to implement that?

-- 
Ville Syrjälä
Intel
