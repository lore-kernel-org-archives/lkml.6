Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeFBGIu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:08:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:28526 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbeFBGIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:08:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,468,1520924400";
   d="scan'208";a="229311112"
Date: Sat, 2 Jun 2018 14:07:58 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH] gnss: ubx_gserial_ops can be static
Message-ID: <20180602060757.GA24149@lkp-ne02>
References: <20180530103242.20773-6-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530103242.20773-6-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 45cad4b6d339 ("gnss: add driver for u-blox receivers")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ubx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index ecddfb3..c7dcfdc 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -59,7 +59,7 @@ static int ubx_set_power(struct gnss_serial *gserial,
 	return -EINVAL;
 }
 
-const struct gnss_serial_ops ubx_gserial_ops = {
+static const struct gnss_serial_ops ubx_gserial_ops = {
 	.set_power = ubx_set_power,
 };
 
