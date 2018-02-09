Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBIMIP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:08:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:38089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbeBIMH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:07:56 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 4/4] powerpc: wii.dts: Add GPIO line names
Date: Fri,  9 Feb 2018 13:07:31 +0100
Message-Id: <20180209120732.17863-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209120732.17863-1-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GdN6gCGntLjNjNtSDUSDKHoBON++iQDfa39DHkAAWXZH2ABkvwq
 piOgwHUI0LzIypl2uUNWYrumf2rbi30H9yXIKI5o7qXUSQNnee3c6duLiDYT9sHDzlZZDbi
 xHtZK1iL+BkCdgMXfgJnCO/Gtj8/aEOjlz86mv/c29W+Gxac8QT5ubWtVDSRMwec9ZS8/YT
 sZzlHW1B+XYVl+OsCRlRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Nm8T9rH/s0=:YwZBEPsDlplU7WmJ0edupv
 ehUNJ0tWkH/z4KsGYBNVRxtnMGLYNb6n0ij7P0IW8hiO+bF0LXE9kVmRvQzN09bJL/H5GjsNs
 TkCsnQ+O+u2/JW2frCAaeDB9oPmE0A/58b9Lov+JjS5sF0p6MLywv37IgWoEEvX3BmaFfl+Kk
 4nmDf4NMxCmC77uJOKjhmffVoAbkuQn7lVibOyTurpRWQZ7qz+0/l8+XgoE/gbiV87oljw4Ot
 tjiXbbCf204L5eK4ZFQbfRMh0q3i2DahWdiokbLQsS/qyL08YINaSn1ncUryE3nU0SUV/4kFj
 FxNzxXppDxByuHLDSgFx9wL7hLWCO/Lt1hUBqGLNw0SMjIXTS8AaOsE+QbgGHK4sDqB+odUrm
 3wsPB0fzQF1U3rwyZ1Qq8WlEoKjP4yQmk88Bk0iQ59jbKlxjV3AOmHRhgssZKAGxcIVUrGF87
 9bPN5vnq0d98bbiVr8pJ+3sEqaDwyodE6AS9TWwi4qkygmdFy5olYbMLMhUzYXz1E5KVanx0T
 QFR1j+3APGXBiE6yo6MfCBgbKDOF2YnIsT8Yf9e/qRMe+fbhJFWQWUOiNIMOMaHHUda1DTPpj
 xV1LDLD4/ux+ZvQonQteB2SQjhuuV2A9iTy0Qexp5viYAzHG1TeYSHZ3qcbzvzhVOx+Y3q0qB
 liVS4XoQPmjX0PL6U5UmtmoQd9XiPdtUEb9s7cwDLMd9Oc8Uc3t+vGXOow89Q/c+Vj3eDcygR
 IMQ1hmWHcN7iYAWnz8qxx3siKbtjoy/S1iJrgHln4YFdWlXZL4GhoU/+9VvkKh3Tk94uLTWJa
 Kia4NTC1/pgfYHYauCuVKdhU6Y9e9/F0B+7W3MoruYiAlTwUxw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the GPIO line names on a Nintendo Wii, as documented in:
https://wiibrew.org/wiki/Hardware/Hollywood_GPIOs

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2, v3:
- no change
---
 arch/powerpc/boot/dts/wii.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 7235e375919c..07d5e84e98b1 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -178,6 +178,14 @@
 			gpio-controller;
 			ngpios = <24>;
 
+			gpio-line-names =
+				"POWER", "SHUTDOWN", "FAN", "DC_DC",
+				"DI_SPIN", "SLOT_LED", "EJECT_BTN", "SLOT_IN",
+				"SENSOR_BAR", "DO_EJECT", "EEP_CS", "EEP_CLK",
+				"EEP_MOSI", "EEP_MISO", "AVE_SCL", "AVE_SDA",
+				"DEBUG0", "DEBUG1", "DEBUG2", "DEBUG3",
+				"DEBUG4", "DEBUG5", "DEBUG6", "DEBUG7";
+
 			/*
 			 * This is commented out while a standard binding
 			 * for i2c over gpio is defined.
-- 
2.15.1
