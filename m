Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966288AbeCAF7s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:59:48 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50874 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966253AbeCAF7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:59:47 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37362731"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@kernel.org>, <ebiederm@xmission.com>,
        <bhe@redhat.com>, <andy.shevchenko@gmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v5 0/3] Make setup_local_APIC() clear
Date: Thu, 1 Mar 2018 13:59:27 +0800
Message-ID: <20180301055930.2396-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: C6B5249F19C3.A24EA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tiny cleanup patchset for setup_local_APIC().

Dou Liyang (3):
  x86/apic: Move pending intr check code into it's own function
  x86/apic: Replace common tools with new ones
  x86/apic: Drop the logical_smp_processor_id()

 arch/x86/include/asm/smp.h  |  10 -----
 arch/x86/kernel/apic/apic.c | 107 ++++++++++++++++++++++++--------------------
 2 files changed, 58 insertions(+), 59 deletions(-)

-- 
2.14.3
