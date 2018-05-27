Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032572AbeE0C2W (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 22:28:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:35692 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032474AbeE0C2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 22:28:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,446,1520924400";
   d="scan'208";a="50636453"
Date: Sun, 27 May 2018 10:27:39 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: kbuild-all@01.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH] regulator: bd71837: buck_7_volts[] can be static
Message-ID: <20180527022739.GA21367@lkp-wsm-ep1>
References: <20180524060114.GJ4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524060114.GJ4249@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 9ebaeaf21446 ("regulator: bd71837: Build BD71837 regulator driver")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 bd71837-regulator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index e6c3fa7..d48b71c 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -207,7 +207,7 @@ static const struct regulator_linear_range bd71837_buck6_voltage_ranges[] = {
  * 110 = 1.95V
  * 111 = 1.995V
  */
-const unsigned int buck_7_volts[] = {
+static const unsigned int buck_7_volts[] = {
 	1605000, 1695000, 1755000, 1800000, 1845000, 1905000, 1950000, 1995000
 };
 
@@ -232,7 +232,7 @@ static const struct regulator_linear_range bd71837_ldo1_voltage_ranges[] = {
  * LDO2
  * 0.8 or 0.9V
  */
-const unsigned int ldo_2_volts[] = {
+static const unsigned int ldo_2_volts[] = {
 	900000, 800000
 };
 
