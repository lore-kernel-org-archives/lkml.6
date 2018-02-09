Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBIMIO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:08:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:42143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbeBIMH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v3 3/4] powerpc: wii.dts: Add ngpios property
Date: Fri,  9 Feb 2018 13:07:30 +0100
Message-Id: <20180209120732.17863-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209120732.17863-1-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ixqf/7HPx5HCiYsBS5gEttEt9wNgrCyAqpiYnEK40r0u9DVTR2g
 p1Cw5w4i8FhaYBLZ8cjkfIxJEPX3Edu/MBzOK9xmCzWP43N1+kZs6vApe/KAgoczlCZJgLB
 vHeI0X2LjrLPVIXgFtCBG4uB+fICh50/OQEIKrtFYcn6IHK6S2COIO/A5fhnaikCUdcjXkH
 D91ZlzeFYF95DbR45QsHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dE/fAj/pryA=:gExQYzFy4cbXK30JIs3s/9
 B8n3RaCJ+xo/JVKegQ2EJiqsYdxTyORceMz8hiiK72IUy8GQAwjdvw/UIrUWhTNBd4ZFdSxNv
 JqvzV0XXwmLslhYegMn4J00vKVZRLt7Nn6afqgHA8G0QLeC25o9baH+4VY2MCn4q03NWBIHFP
 Ywdkvlv9Jb135z5mD8tjjHNNZCiZ85OFXhi4IOT6frF1bfIZY1l2bw5jGQxFNq0H2B9p93t0O
 uL3DOsmtefJ7xltSJoYe+5czwxda86DE2MDMK89rEzN8Ko1037PdZawRxkGeF37yFKgajS3gi
 IO3Gxm0Q/tnSstI/B+gqyIFEqwqQfhhxFnVo5uMqLe+fT0VN8HGQx8smxfACkCe20OzPSlLD2
 E3aN3psrdYgvg6f0aOeRC/y8pur411b7FEfd4++wUYuYV5j8soPHwHOwVCI849wUKm5Ao5z/0
 wcV2Dp5qHvp1QSVJk116PfAFLk5zpfWETZrdsGGk9Nv8KlkI9ivAln0JVYXscUKiZBU60Cse0
 YwRArbcpZPhIBIvG2jOsGTavYuZPPGSgVVnx591Woh79rkQKL3hiQrANxRw9B6QdHrYI3Ew2D
 xvlHoRbGrhCJUFrMZSfO5G/gca+LIy4v//lAAUky9R6InKiKkWwFSGOq2XDAJaQzSDCA03/SB
 MextsJSK/5xxLPSovNy+ZtlbHx4imHI6QE5ZCUdRj7C12HFcDAUxGiH4s+FU+AgapktZRT8yO
 F56U33BokchS+Xrz6kk1ltz4k/fyQJ39AYoCoxCwN4kphLJnMwhTylFt9RkWflPXMkORu4vJu
 6kUBMT9LVtxwKcL69FCNRAdfo1PM/WQAPojtbZfv2xGw0g/41I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hollywood GPIO controller supports 32 GPIOs, but on the Wii, only 24
are used.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2, v3:
- no change
---
 arch/powerpc/boot/dts/wii.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 40b324b6391e..7235e375919c 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -176,6 +176,7 @@
 			compatible = "nintendo,hollywood-gpio";
 			reg = <0x0d8000c0 0x40>;
 			gpio-controller;
+			ngpios = <24>;
 
 			/*
 			 * This is commented out while a standard binding
-- 
2.15.1
