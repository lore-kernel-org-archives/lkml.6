Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937062AbeBUPFs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:05:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:30248 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932826AbeBUPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:05:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29603251"
Date: Wed, 21 Feb 2018 23:05:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [RFC PATCH] drm/panel: lhr050h41_init[] can be static
Message-ID: <20180221150529.GA934@lkp-wsm-ep2>
References: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: dcfac3b68dfb ("drm/panel: Add Huarui LHR050H41 panel driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 panel-huarui-lhr050h41.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c b/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
index f73d484..f71030e 100644
--- a/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
+++ b/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
@@ -66,7 +66,7 @@ struct lhr050h41_instr {
 		},					\
 	}
 
-struct lhr050h41_instr lhr050h41_init[] = {
+static struct lhr050h41_instr lhr050h41_init[] = {
 	LHR050H41_SWITCH_PAGE_INSTR(3),
 	LHR050H41_COMMAND_INSTR(0x01, 0x00),
 	LHR050H41_COMMAND_INSTR(0x02, 0x00),
