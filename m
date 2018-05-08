Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755180AbeEHNq7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbeEHNq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:46:58 -0400
Date: Tue, 8 May 2018 15:46:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Rich Felker <dalias@libc.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [GIT PULL] softirq: Consolidate and optimize softirq mask v4
Message-ID: <20180508134654.GA22228@lerouge>
References: <1525786706-22846-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525786706-22846-1-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual subject is "softirq: Consolidate and optimize softirq mask v4" :-)

Sorry...
