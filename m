Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeEaWV6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:21:58 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:31842 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeEaWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:21:49 -0400
From: Suman Anna <s-anna@ti.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 0/2] ti-cpufreq: minor fixes/cleanups
Date: Thu, 31 May 2018 17:21:42 -0500
Message-ID: <20180531222144.26739-1-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

This is a repost of the v2 patches Ccing the proper linux-pm list.
There are no code changes, I have picked up Viresh's acks and
also added the stable kernel versions the first patch needs to be
applied to.

regards
Suman

v2: https://marc.info/?l=linux-omap&m=152268780921259&w=2
v1: https://patchwork.kernel.org/patch/10308925/

Suman Anna (2):
  cpufreq: ti-cpufreq: Fix an incorrect error return value
  cpufreq: ti-cpufreq: Use devres managed API in probe()

 drivers/cpufreq/ti-cpufreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.17.0
