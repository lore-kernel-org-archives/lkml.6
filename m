Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeEPKRC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:17:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36566 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbeEPKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:57 -0400
X-Google-Smtp-Source: AB8JxZopJzXNjtQ6xiCxw4wjhXgPl3RyMtaPTW/rVXixCK9Adh1Nonwzcx9Inf1kp2efyTNHBlkMeQ==
Date: Wed, 16 May 2018 11:16:53 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>, thierry.reding@gmail.com
Cc: alexandre.torgue@st.com, benjamin.gaignard@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [GIT PULL ++] Immutable branch between MFD and PWM due for the v4.18
 merge window (v2)
Message-ID: <20180516101653.GI5130@dell>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
 <20180516081910.GF5130@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180516081910.GF5130@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent pull-request containing additional bindings patch.

Enjoy!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-v4.18-1

for you to fetch changes up to acc8e22f5d41558c90519aadc011b6d2839aedfe:

  dt-bindings: mfd: stm32-timers: Add support for dmas (2018-05-16 11:13:13 +0100)

----------------------------------------------------------------
Immutable branch between MFD and PWM due for the v4.18 merge window (v2)

----------------------------------------------------------------
Fabrice Gasnier (5):
      mfd: stm32-timers: Add support for DMAs
      pwm: stm32: Add capture support
      pwm: stm32: Improve capture by tuning counter prescaler
      pwm: stm32: Use input prescaler to improve period capture
      dt-bindings: mfd: stm32-timers: Add support for dmas

 Documentation/devicetree/bindings/mfd/stm32-timers.txt |  20 ++++
 drivers/mfd/stm32-timers.c                             | 201 +++++++++++++++++++++++++++++++-
 drivers/pwm/pwm-stm32.c                                | 257 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                       |  58 ++++++++++
 4 files changed, 534 insertions(+), 2 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
