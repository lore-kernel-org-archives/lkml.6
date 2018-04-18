Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDRQFP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:05:15 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:48136 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeDRQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:05:13 -0400
X-Authority-Analysis: v=2.3 cv=Tai4SyYh c=1 sm=1 tr=0
 a=IfKG9KDHjPrX0SZ8gMoyrg==:117 a=IfKG9KDHjPrX0SZ8gMoyrg==:17
 a=Kd1tUaAdevIA:10 a=Q-fNiiVtAAAA:8 a=fr2UWt6uMMg7Tx45QH4A:9
 a=Fp8MccfUoT0GBdDC_Lng:22
From: Markus Mayer <code@mmayer.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] brcmstb-avs-cpufreq changes
Date: Wed, 18 Apr 2018 08:56:41 -0700
Message-Id: <20180418155643.36464-1-code@mmayer.net>
X-Mailer: git-send-email 2.14.1
X-CMAE-Envelope: MS4wfDR2pbn3KI2jlJmtcT/4mybYHlgHV4ts4Zpi/oNP41H67KRAmgtpGkPgZjHwUGAKUFthxuOyMr+eRXLM0Ky3Jd1tNjtc7ksOS9AhO1cQvZRU2rzrCKt3
 j7kQ1zv9ApOZdUoVPmI/SdXFcg0f7hsd0ehiUV7r7atsoW4lH6EqdIEUbyyb3ibTNBOLHzcInzrZGQhOXO5TLDD5yqOiPGyiL96n0qX/WPJ/KKQ2aoJqfcIz
 uBH/oWFQbDN26/ACtbXecneTLCruFT2QMbkTd3ZPeO6cneib2j+GkK/7apKKHPZUouQFWjxQyPU4OzDhI3yWphygPch6bFCaplE1n27J7rfFLqYioBMnKIjU
 5YgZqm1s+lspY5LcWbsC2ldpOcsqlaaPvlah+gmXt0VDwI72h0KFmfkEc6iRKUrlXW3SMB9XY3go8jbI0txB/CBeKn5Fu0rQUeetk25S8Kg44n8zP+5T4ojv
 JMYHWfqB+nNCMnulwOsJY5A7sQ5ORHuqT9CP3i9J2JjXMjX0xm/kTWbusps=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

These changes are based on v4.17-rc1. The two patches are unrelated.

Patch 1/2 removes unused code that was only useful during driver
development and that has been disabled by default for a long time.

Patch 2/2 allows the driver to detect if the system supports SCMI cpufreq

Jim Quinlan (1):
  cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if supported

Markus Mayer (1):
  cpufreq: brcmstb-avs-cpufreq: remove development debug support

 drivers/cpufreq/Kconfig.arm           |  10 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 339 ++--------------------------------
 2 files changed, 17 insertions(+), 332 deletions(-)

-- 
2.7.4
