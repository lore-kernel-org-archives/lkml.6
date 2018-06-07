Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +ws/B6DyGFvuJwAAmS7hNA
	; Thu, 07 Jun 2018 08:53:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C7B7607E7; Thu,  7 Jun 2018 08:53:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8D4B9602FC;
	Thu,  7 Jun 2018 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D4B9602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeFGIxt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753004AbeFGIxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:53:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BFC54ADF4;
        Thu,  7 Jun 2018 08:53:44 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: PCI: Move OF-related PCI functions into PCI core
References: <20180206193546.52AFA21D4F@pdx-korg-gitolite-1.ci.codeaurora.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Yow: I demand IMPUNITY!
Date: Thu, 07 Jun 2018 10:53:44 +0200
In-Reply-To: <20180206193546.52AFA21D4F@pdx-korg-gitolite-1.ci.codeaurora.org>
        (Linux Kernel Mailing List's message of "Tue, 6 Feb 2018 19:35:46
        +0000 (UTC)")
Message-ID: <mvmlgbrj7tz.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OF_PCI is still referenced by drivers/pci/host/Kconfig.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
