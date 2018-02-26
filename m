Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBZRgt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:36:49 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5484 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBZRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:36:48 -0500
X-IronPort-AV: E=Sophos;i="5.47,397,1515456000";
   d="scan'208";a="721670928"
From: Amit Shah <aams@amazon.com>
To: <xen-devel@lists.xenproject.org>
CC: <linux-kernel@vger.kernel.org>, Amit Shah <aams@amazon.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Eduardo Valentin <eduval@amazon.com>, Juergen Gross <jgross@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Liu Shuo" <shuo.a.liu@intel.com>,
        Anoob Soman <anoob.soman@citrix.com>
Subject: [PATCH 0/2] xen: fix bugs in error conditions
Date: Mon, 26 Feb 2018 17:36:33 +0000
Message-ID: <1519666595-41362-1-git-send-email-aams@amazon.com>
X-Mailer: git-send-email 2.7.3.AMZN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QHauVr002989

Hello,

These bugs were found during code review.  Details in the commits.

Please review and apply.

CC: Roger Pau Monné <roger.pau@citrix.com>
CC: David Vrabel <david.vrabel@citrix.com>
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

 drivers/xen/events/events_base.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.7.3.AMZN

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
