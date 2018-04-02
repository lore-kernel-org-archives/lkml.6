Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDBQuH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:50:07 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:50960 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbeDBQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:50:06 -0400
From: Suman Anna <s-anna@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 0/2] ti-cpufreq: minor fixes/cleanups
Date: Mon, 2 Apr 2018 11:49:56 -0500
Message-ID: <20180402164958.20057-1-s-anna@ti.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Please find the updated series replacing the previous patch [1] fixing
couple of issues in the TI CPUFreq driver. I have split up the patches
as per your comments on v1. Final code diff remains the same as before.

regards
Suman

[1] https://patchwork.kernel.org/patch/10308925/

Suman Anna (2):
  cpufreq: ti-cpufreq: Fix an incorrect error return value
  cpufreq: ti-cpufreq: Use devres managed API in probe()

 drivers/cpufreq/ti-cpufreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.2
