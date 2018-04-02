Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeDBDeI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:34:08 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:33920 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754048AbeDBDeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:34:06 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v2 0/2] MCA support on Centaur CPU
Date: Mon, 2 Apr 2018 11:33:50 +0800
Message-ID: <1522640032-3357-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to provide MCA support on new Centaur CPU.

The first patch is used to tell the kernel that newer Centaur CPU
support MCE broadcasting.

The second patch is used to tell the kernel that newer Centaur
CPU support CMCI.

Changes from v1 to v2:
* Capatilize 'Centaur' in the comments

David Wang (2):
  x86/mce: new Centaur CPUs support MCE broadcasting
  x86/mce: add CMCI support for centaur CPUs

 arch/x86/kernel/cpu/mcheck/mce.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
1.9.1
