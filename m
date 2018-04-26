Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756798AbeDZV2g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:28:36 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40070 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754348AbeDZV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:27:48 -0400
X-Google-Smtp-Source: AB8JxZp0MXWtaXS9dH3iMoUBW/ENXUNwqmFUhIxzRxoSQwETZR5SZQ9AkuIOrrw1K1knQTWTmQM+pQ==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] dt-bindings: powerpc/4xx: move 4xx NDFC and EMAC bindings to subsystem directories
Date: Thu, 26 Apr 2018 16:27:43 -0500
Message-Id: <20180426212744.28688-3-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180426212744.28688-1-robh@kernel.org>
References: <20180426212744.28688-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings are supposed to be organized by device class/function. Move a
couple of powerpc 4xx bindings to the correct binding directory.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/{powerpc/4xx/ndfc.txt => mtd/ibm,ndfc.txt}        | 0
 .../devicetree/bindings/{powerpc/4xx/emac.txt => net/ibm,emac.txt}        | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/4xx/ndfc.txt => mtd/ibm,ndfc.txt} (100%)
 rename Documentation/devicetree/bindings/{powerpc/4xx/emac.txt => net/ibm,emac.txt} (100%)

diff --git a/Documentation/devicetree/bindings/powerpc/4xx/ndfc.txt b/Documentation/devicetree/bindings/mtd/ibm,ndfc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/4xx/ndfc.txt
rename to Documentation/devicetree/bindings/mtd/ibm,ndfc.txt
diff --git a/Documentation/devicetree/bindings/powerpc/4xx/emac.txt b/Documentation/devicetree/bindings/net/ibm,emac.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/4xx/emac.txt
rename to Documentation/devicetree/bindings/net/ibm,emac.txt
-- 
2.14.1
