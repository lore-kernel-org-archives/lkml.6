Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeBTFJr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:09:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:46990 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeBTFJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:09:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="205450924"
Date: Tue, 20 Feb 2018 13:22:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: kbuild-all@01.org, laurent.pinchart@ideasonboard.com,
        magnus.damm@gmail.com, geert@glider.be, hverkuil@xs4all.nl,
        mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi,
        robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] media: i2c: ov772x: ov772x_frame_intervals[] can be
 static
Message-ID: <20180220052223.GA27152@lkp-sb04>
References: <1519059584-30844-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519059584-30844-8-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 42b7d5be5f1f ("media: i2c: ov772x: Support frame interval handling")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ov772x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
index eba71d97..0d8ce2a 100644
--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -532,7 +532,7 @@ static const struct ov772x_win_size ov772x_win_sizes[] = {
 /*
  * frame rate settings lists
  */
-unsigned int ov772x_frame_intervals[] = { 5, 10, 15, 20, 30, 60 };
+static unsigned int ov772x_frame_intervals[] = { 5, 10, 15, 20, 30, 60 };
 #define OV772X_N_FRAME_INTERVALS ARRAY_SIZE(ov772x_frame_intervals)
 
 /*
