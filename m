Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeESNSA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 09:18:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:61056 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751994AbeESNR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 09:17:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,419,1520924400";
   d="scan'208";a="47989823"
Date: Sat, 19 May 2018 21:16:55 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: kbuild-all@01.org, jic23@kernel.org, benjamin.gaignard@st.com,
        fabrice.gasnier@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC PATCH] counter: 104-quad-8: quad8_ops can be static
Message-ID: <20180519131655.GA57734@ivb43>
References: <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: b3822048aa0b ("counter: 104-quad-8: Add Generic Counter interface support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 104-quad-8.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 7c72fb7..8696a512 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -800,7 +800,7 @@ static int quad8_action_get(struct counter_device *counter,
 	return 0;
 }
 
-const struct counter_ops quad8_ops = {
+static const struct counter_ops quad8_ops = {
 	.signal_read = quad8_signal_read,
 	.count_read = quad8_count_read,
 	.count_write = quad8_count_write,
