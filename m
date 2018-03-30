Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeC3M6b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:58:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeC3M63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:58:29 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 0/2] Motorola Droid 4 Audio Support
Date: Fri, 30 Mar 2018 14:58:22 +0200
Message-Id: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds audio support to Motorola Droid 4. I dropped
all patches, that have been applied and collected all
Reviewed-by & Acked-by for the remaining ones. Also I
changed the binding to use relative paths.

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: mfd: motorola-cpcap: document audio-codec
  mfd: motorola-cpcap: Add audio-codec support

 .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++
 drivers/mfd/motorola-cpcap.c                       | 51 +++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.16.2
