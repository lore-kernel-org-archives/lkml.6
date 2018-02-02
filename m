Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBBNge (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:36:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33048 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751416AbeBBNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:36:24 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Feb 2018 14:36:49 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [git pull] FireWire (IEEE 1394) updates post v4.15
Message-ID: <20180202143649.4f5cc982@kant>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from the tag "firewire-updates" at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git firewire-updates

to receive the following
IEEE 1394 subsystem patches:

  - make JMicron JMB38x controllers work with IOMMU-equipped systems
  - IP-over-1394: allow user-configured MTU of up to 4096 bytes

Hector Martin (1):
      firewire-ohci: work around oversized DMA reads on JMicron controllers

Stefan Richter (1):
      firewire: net: max MTU off by one

 drivers/firewire/net.c  | 7 ++++++-
 drivers/firewire/ohci.c | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

Thanks,
-- 
Stefan Richter
-======---=- --=- ---=-
http://arcgraph.de/sr/
