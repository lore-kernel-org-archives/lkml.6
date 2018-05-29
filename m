Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965636AbeE2R4H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965391AbeE2R4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:56:04 -0400
From: Alan Tull <atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: [PATCH] Documentation: fpga: cleanup
Date: Tue, 29 May 2018 12:55:59 -0500
Message-Id: <20180529175600.3672-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This patch fixes the minor spelling/typos/etc that Randy Dunlap
pointed out in his review.

This patch applies cleanly on char-misc-next; kernel-doc builds
with no warnings for fpga docs.

Thanks,
Alan

Alan Tull (1):
  Documentation: fpga: cleanup

 Documentation/driver-api/fpga/fpga-mgr.rst    | 12 ++++++------
 Documentation/driver-api/fpga/fpga-region.rst | 12 ++++++------
 Documentation/driver-api/fpga/intro.rst       | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.7.4
