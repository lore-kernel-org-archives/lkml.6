Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeEWEiJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:38:09 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41813 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753866AbeEWEhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:37:46 -0400
X-Google-Smtp-Source: AB8JxZpwcgtUEhKBL0O59/RqIbZt7AENDmgN34VlBP6cLQct5SSQpYbHRRL2UkYLrV1cqgruEEC9UQ==
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.18
Date: Tue, 22 May 2018 23:37:41 -0500
Message-Id: <1527050261-19887-3-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
References: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.18

for you to fetch changes up to 90ce62659994b87723ec6ba26815f9634c18e449:

  ARM: dts: qcom-apq8064: use correct pci address for address translation (2018-05-14 15:22:28 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.18

* APQ8064 fixes for irq translations and pci address translation
* Fix RPM clock controller compatible on MSM8660
* Add TZ and SMEM reserved regions on IPQ4019
* Add vadc nodes for PM8941
* Disable i2c by default at top level APQ8064 dtsi

----------------------------------------------------------------
Craig Tatlor (1):
      ARM: dts: qcom: pm8941: Add vadc nodes needed to estimate an ocv

Linus Walleij (1):
      ARM: dts: Fix the RPM clock controller compatible string

Niklas Cassel (1):
      ARM: dts: qcom-apq8064: use correct pci address for address translation

Srinivas Kandagatla (1):
      ARM: dts: qcom-apq8064: disable i2c by default at soc dtsi

Sven Eckelmann (1):
      ARM: dts: ipq4019: Add TZ and SMEM reserved regions

Thierry Escande (1):
      ARM: dts: qcom-apq8064: fix gic_irq_domain_translate warnings

 arch/arm/boot/dts/qcom-apq8064.dtsi | 58 ++++++++++++++++++++-----------------
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 16 ++++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi |  2 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi  |  6 ++++
 4 files changed, 54 insertions(+), 28 deletions(-)
