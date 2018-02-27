Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeB0P4K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:56:10 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44626 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932174AbeB0P4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:56:08 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="668545261"
From: Amit Shah <aams@amazon.com>
To: <xen-devel@lists.xenproject.org>
CC: <linux-kernel@vger.kernel.org>, Amit Shah <aams@amazon.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Eduardo Valentin <eduval@amazon.com>,
        "Juergen Gross" <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Liu Shuo <shuo.a.liu@intel.com>, Anoob Soman <anoob.soman@citrix.com>
Subject: [PATCH v2 0/2] xen: fix bugs in error conditions
Date: Tue, 27 Feb 2018 15:55:56 +0000
Message-ID: <1519746958-52077-1-git-send-email-aams@amazon.com>
X-Mailer: git-send-email 2.7.3.AMZN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RFuHJt026970

Hello,

These bugs were found during code review.  Details in the commits.

Please review and apply.

v2:
 - fix up patch 2 properly (Roger Pau Monné)

CC: Roger Pau Monné <roger.pau@citrix.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Eduardo Valentin <eduval@amazon.com>
CC: Juergen Gross <jgross@suse.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Liu Shuo <shuo.a.liu@intel.com>
CC: Anoob Soman <anoob.soman@citrix.com>

Amit Shah (2):
  xen: fix out-of-bounds irq unbind for MSI message groups
  xen: events: free irqs in error condition

 drivers/xen/events/events_base.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.3.AMZN

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
