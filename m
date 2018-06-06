Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GQRuBclSGFvJZgAAmS7hNA
	; Wed, 06 Jun 2018 21:32:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F034D608B8; Wed,  6 Jun 2018 21:32:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7305D60290;
	Wed,  6 Jun 2018 21:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7305D60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeFFVce (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:32:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:11662 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeFFVcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:32:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 14:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="47331239"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2018 14:32:31 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 0/2] mei; updates for 4.18-rc2
Date: Thu,  7 Jun 2018 00:31:46 +0300
Message-Id: <20180606213148.9469-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bug for long lasting regression and trivial cleanup.
Hope this can make its way to 4.18.

Alexander Usyskin (2):
  mei: remove unused MEI_IAMTHIF_STALL_TIMER define
  mei: discard messages from not connected client during power down.

 drivers/misc/mei/hw.h        | 2 --
 drivers/misc/mei/interrupt.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.14.4
