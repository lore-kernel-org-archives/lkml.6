Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeDZV2C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:28:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:47057 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDZV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:27:49 -0400
X-Google-Smtp-Source: AB8JxZrhzK0suczMftUFgjnNDodn6r4YL/NvRK6hNZMi/uNfFN8tYNs+zbX1fnANV2YstAPu9ZPpEA==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/4] dt-bindings: exynos: move ADC binding to iio/adc/ directory
Date: Thu, 26 Apr 2018 16:27:44 -0500
Message-Id: <20180426212744.28688-4-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180426212744.28688-1-robh@kernel.org>
References: <20180426212744.28688-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings are supposed to be organized by device class/function. Move the
binding for Exynos ADC to the iio/adc/ binding directory.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../{arm/samsung/exynos-adc.txt => iio/adc/samsung,exynos-adc.txt}        | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/samsung/exynos-adc.txt => iio/adc/samsung,exynos-adc.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
rename to Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
-- 
2.14.1
