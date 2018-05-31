Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeEaEge (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:36:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43426 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751937AbeEaEga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:36:30 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <mark.rutland@arm.com>, <dave.martin@arm.com>,
        <ard.biesheuvel@linaro.org>, <james.morse@arm.com>,
        <gengdongjiu@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 0/2] Add NOTIFY_SEI notification type support
Date: Thu, 31 May 2018 20:41:44 +0800
Message-ID: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html

1. CPI 6.1 adds support for NOTIFY_SEI as a GHES notification mechanism, so this patch supports this
   notification in software

Dongjiu Geng (2):
  ACPI / APEI: Add SEI notification type support for ARMv8
  arm64: handle NOTIFY_SEI notification by the APEI driver

 arch/arm64/kernel/traps.c | 15 ++++++++++++++
 drivers/acpi/apei/Kconfig | 15 ++++++++++++++
 drivers/acpi/apei/ghes.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h       |  1 +
 4 files changed, 84 insertions(+)

-- 
1.9.1
