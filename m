Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeEWNLi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:11:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeEWNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:11:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54CCA601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org, robh@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/2] CPU scaling support for msm8996 DT
Date: Wed, 23 May 2018 16:11:29 +0300
Message-Id: <1527081091-13389-1-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v11]
 * Split the series into domains

The series adds OPP tables, thermal and CPU definitions in order to support
the CPU frequency scaling on msm8996 CPUs.

Ilia Lin (2):
  dt: qcom: Add opp and thermal to the msm8996
  dt: qcom: Add qcom-cpufreq-kryo driver configuration

 arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi       | 546 +++++++++++++++++++++++++++-
 2 files changed, 528 insertions(+), 20 deletions(-)

-- 
1.9.1
