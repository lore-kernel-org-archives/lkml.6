Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeBDUjr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 15:39:47 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34544 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBDUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:39:28 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] pcmcia: odd fixes for v4.16-rc1
Date: Sun,  4 Feb 2018 21:12:03 +0100
Message-Id: <20180204201206.2300-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past couple of years, the linux-pcmcia mailing list had a pretty bad
signal-to-noise ratio. Therefore, it was shut down for good. This means an
update to MAINTAINERS is in order. If no-one else steps in, I will try to
route the few odd fixes for pcmcia upstream. Also, throw in two odd fixes
to this patch set.

Arvind Yadav (1):
  pcmcia: soc_common: Handle return value of clk_prepare_enable

Dominik Brodowski (2):
  pcmcia: remove mailing list, update MAINTAINERS
  pcmcia: use proper printk format for resource

 MAINTAINERS                     | 6 ++----
 drivers/pcmcia/rsrc_nonstatic.c | 2 +-
 drivers/pcmcia/soc_common.c     | 8 ++++++--
 3 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.16.1
