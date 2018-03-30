Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeC3Dvm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:51:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:46785 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbeC3Dvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:51:40 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] add thermal monitor support for UniPhier PXs3 SoC
Date: Fri, 30 Mar 2018 12:51:18 +0900
Message-Id: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for thermal monitor implemented on UniPhier PXs3 SoC.

Kunihiko Hayashi (2):
  dt-bindings: thermal: uniphier: add a compatible string for PXs3
  thermal: uniphier: add UniPhier PXs3 support

 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt | 1 +
 drivers/thermal/uniphier_thermal.c                             | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.7.4
