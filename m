Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeC3Jyj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:54:39 -0400
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:58734 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751053AbeC3Jyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:54:37 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 0/2] MCA support on Centaur CPU
Date: Fri, 30 Mar 2018 17:53:40 +0800
Message-ID: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
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

The first patch is used to tell the kernel that newer Centaur CPU support 
MCE broadcasting.

The second patch is used to tell the kernel that newer Centaur CPU support 
CMCI. 

David Wang (2):
  x86/mce: new centaur CPUs support MCE broadcasting
  x86/mce: add CMCI support for centaur CPUs

 arch/x86/kernel/cpu/mcheck/mce.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
1.9.1
