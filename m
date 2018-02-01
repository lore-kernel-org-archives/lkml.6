Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeBAL1v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:27:51 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:48954 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBAL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:27:37 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511827200";
   d="scan'208";a="706271325"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org
Subject: [PATCH 0/2] Spectre v2 tweaks
Date: Thu,  1 Feb 2018 11:27:19 +0000
Message-Id: <1517484441-1420-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of things that have been lurking in the "shall we do this?" area
of my git tree for a while, and I think we probably should...

David Woodhouse (1):
  x86/retpoline: No retpolines for built-in __init functions

KarimAllah Ahmed (1):
  x86: Simplify spectre_v2 command line parsing

 arch/x86/kernel/cpu/bugs.c | 86 ++++++++++++++++++++++++++++++----------------
 include/linux/init.h       |  9 ++++-
 2 files changed, 64 insertions(+), 31 deletions(-)

-- 
2.7.4
