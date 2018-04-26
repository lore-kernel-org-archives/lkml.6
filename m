Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754824AbeDZV1u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:27:50 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34721 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeDZV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:27:47 -0400
X-Google-Smtp-Source: AB8JxZoPFwxCTkZErecf3ZvpxH/H7NOWFaAsZpCpLtl59zvuBDtaS+Hxs1gem5e/JdX0HKxCedyV9w==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/4] dt-bindings: move various RNG bindings to rng/ directory
Date: Thu, 26 Apr 2018 16:27:42 -0500
Message-Id: <20180426212744.28688-2-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180426212744.28688-1-robh@kernel.org>
References: <20180426212744.28688-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings are supposed to be organized by device class/function. Move
bindings for various RNGs to rng/ binding directory.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../{crypto/samsung,exynos-rng4.txt => rng/samsung,exynos4-rng.txt}       | 0
 Documentation/devicetree/bindings/{ => rng}/sparc_sun_oracle_rng.txt      | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{crypto/samsung,exynos-rng4.txt => rng/samsung,exynos4-rng.txt} (100%)
 rename Documentation/devicetree/bindings/{ => rng}/sparc_sun_oracle_rng.txt (100%)

diff --git a/Documentation/devicetree/bindings/crypto/samsung,exynos-rng4.txt b/Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
similarity index 100%
rename from Documentation/devicetree/bindings/crypto/samsung,exynos-rng4.txt
rename to Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
diff --git a/Documentation/devicetree/bindings/sparc_sun_oracle_rng.txt b/Documentation/devicetree/bindings/rng/sparc_sun_oracle_rng.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sparc_sun_oracle_rng.txt
rename to Documentation/devicetree/bindings/rng/sparc_sun_oracle_rng.txt
-- 
2.14.1
