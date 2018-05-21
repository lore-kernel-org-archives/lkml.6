Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeEUTAS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:00:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeEUTAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:00:17 -0400
Date: Mon, 21 May 2018 20:59:49 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1804311797.71726.1526929189594@email.1und1.de>
In-Reply-To: <20180521183907.27563-1-eric@anholt.net>
References: <20180521183907.27563-1-eric@anholt.net>
Subject: Re: [PATCH v2] arm: bcm2835: Add the PMU to the devicetree.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:rVt9mfHmr8J68qYMxMGCYkHNfu3wggKENRVYxJqX+MSbCagMggH
 5pRYcQc6idExQqLcVw/s6L2EhYH5fjQiiVnSFGJPSDPJRiNxUnrMrD42foL0gGLpOvg+M+u
 K+/NDB3FPAdV9a3LP0L+imRr3aGKwJwTLwB25u68PccNGFVj5VXdbQqvZCfnXnTHN7T/5gs
 NnZCcjkhRYcjDPQ7oD8zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pgIOFyJ8a6E=:79etD1ErzZVasSfMzxE85Q
 qbMkwxuPaMh+b4ReHxOUOhZ6lcxOHO6Dd5Hd63Jvxszbi+WmqlMdKfKGznOs1tAt7ircYf1/9
 HJgwkM+oXL2Bgh1tPWJCI00lZ0IzmQi3bWzRiLedqE0dbm25QY+fCdUJUSN3ym/rf/bn92jEE
 ZKC7v4xCMFcRgOKQVEPqMn+kxON2xP9wW83k2BwfxOr7kyhEA34hPqz23BoQd3ple6xYSvW46
 IN2ErCjJ0Al/lILrCjxPHsXi20MDONzLK3/jueYrLEsYHUdTQIESeWfOYtDwvrZ8VkJPUMAX+
 o/sd8WmOQoW+8OoT0hlbYZNG6K41Rcv+JTmP4Bjj5FXkym04fsy2huSlNsl3i4rv5LVNfwOfn
 JSpr0HbEpwX1cEQV29ZwwYBkxKyFjav0zivUiQTd5Zi7KEMXOdATy4ylXoV5T6b6cJFK2mkd/
 j9EsO/iZiMNe+JmF3S4e51rhL1beT2/D590O+FVTFB8+7+6LFqEF6Y2t5IfI2QYIV4tOFnKj2
 SLU1aJDRuHqAhmn1KvFhzEq9rDtwgfJ34B+ww/EKmXJSD6Bpm4ON9esM3W72NLw46vRxVfsoV
 F4PNEQaOHaCsTLT/kFR6dwk/qL1zDEDkwgImJfKGhH8s078kwc7BB+zQ+/OLACY6DyzT4K5Jt
 5Ly0v75KN2ZnjLQmD8BT5A2Leh8TdpAAzPV+0j/yrvp/Sxofh10BNHpHT8/1GIGiEWRe2lb6N
 gvnIQmXdGjQsHXgZ
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 21. Mai 2018 um 20:39 geschrieben:
> 
> 
> This only probes on arm64 so far, but hopefully that driver will be
> generalized soon.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
