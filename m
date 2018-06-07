Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9PA+O3UzGVt5SwAAmS7hNA
	; Thu, 07 Jun 2018 13:30:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A2AAD608BA; Thu,  7 Jun 2018 13:30:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 46B6E601D2;
	Thu,  7 Jun 2018 13:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46B6E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbeFGNa3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:30:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbeFGNa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:30:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7264AACD2;
        Thu,  7 Jun 2018 13:30:26 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: PCI: Move OF-related PCI functions into PCI core
References: <20180206193546.52AFA21D4F@pdx-korg-gitolite-1.ci.codeaurora.org>
        <mvmlgbrj7tz.fsf@suse.de>
        <CAErSpo6_BTHJgAhFJxQiVFenqns5rP98TRtSguL21h9HdZAxpA@mail.gmail.com>
X-Yow: ..  Now KEN and BARBIE are PERMANENTLY ADDICTED to MIND-ALTERING DRUGS..
Date: Thu, 07 Jun 2018 15:30:26 +0200
In-Reply-To: <CAErSpo6_BTHJgAhFJxQiVFenqns5rP98TRtSguL21h9HdZAxpA@mail.gmail.com>
        (Bjorn Helgaas's message of "Thu, 7 Jun 2018 08:25:57 -0500")
Message-ID: <mvm36xyk9l9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 07 2018, Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Thu, Jun 7, 2018 at 3:53 AM Andreas Schwab <schwab@suse.de> wrote:
>>
>> OF_PCI is still referenced by drivers/pci/host/Kconfig.
>
> Do you have a SHA1 for the file you're looking at?

I'm lookig at 4.17.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
