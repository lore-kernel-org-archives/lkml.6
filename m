Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBHSso (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:48:44 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:52094 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:48:43 -0500
Date: Thu, 8 Feb 2018 19:48:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia: odd fixes for v4.16
Message-ID: <20180208184834.GA12330@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 0c5b9b5d9adbad4b60491f9ba0d2af38904bb4b9:

  Linux 4.15-rc9 (2018-01-21 13:51:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia.git pcmcia

for you to fetch changes up to d3fdd701248290b511683ff8d348073295f07833:

  pcmcia: soc_common: Handle return value of clk_prepare_enable (2018-01-24 19:24:39 +0100)

----------------------------------------------------------------

The linux-pcmcia mailing list was shut down, so offer an alternative path
for patches in MAINTAINERS. Also, throw in two odd fixes for the pcmcia
subsystem.

An RFC sent to lkml a few ago did not raise any comments/issues, see
http://lkml.kernel.org/r/20180204201206.2300-1-linux@dominikbrodowski.net

----------------------------------------------------------------

Thanks,
	Dominik

----------------------------------------------------------------

Arvind Yadav (1):
      pcmcia: soc_common: Handle return value of clk_prepare_enable

Dominik Brodowski (2):
      pcmcia: remove mailing list, update MAINTAINERS
      pcmcia: use proper printk format for resource

 MAINTAINERS                     | 6 ++----
 drivers/pcmcia/rsrc_nonstatic.c | 2 +-
 drivers/pcmcia/soc_common.c     | 8 ++++++--
 3 files changed, 9 insertions(+), 7 deletions(-)
