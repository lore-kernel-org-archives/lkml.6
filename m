Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D0B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D0B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeIYVCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:02:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYVCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:02:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E7D0F06;
        Tue, 25 Sep 2018 14:54:13 +0000 (UTC)
Date:   Tue, 25 Sep 2018 16:54:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver fixes for 4.19-rc6
Message-ID: <20180925145410.GA2747@kroah.com>
References: <20180925142344.GA26980@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925142344.GA26980@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:23:44PM +0200, Greg KH wrote:
> [Yes, the oddity of sending a pull request to myself is not lost on me...]

And, I totally messed this up.  Ugh, what kind of idiot does something
like this!  It's not like I haven't been doing this for years!  I should
know better...

Here's the real pull request text that I should have sent out the first
time:

-----------

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.19-rc6

for you to fetch changes up to 59d08d00d43c644ee2011d7ff1807bdd69f31fe0:

  intel_th: pci: Add Ice Lake PCH support (2018-09-18 16:08:38 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 4.19-rc6

Here are some soundwire and intel_th (tracing) driver fixes for some
reported issues.

Full details are in the shortlog.

All of these have been in linux-next for a week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (3):
      intel_th: Fix device removal logic
      intel_th: Fix resource handling for ACPI glue layer
      intel_th: pci: Add Ice Lake PCH support

Greg Kroah-Hartman (1):
      Merge tag 'soundwire-4.19-fixes' of git://git.kernel.org/.../vkoul/soundwire into char-misc-linus

Sanyog Kale (1):
      soundwire: Fix acquiring bus lock twice during master release

Shreyas NC (2):
      soundwire: Fix duplicate stream state assignment
      soundwire: Fix incorrect exit after configuring stream

 drivers/hwtracing/intel_th/core.c | 16 +++++++++++++---
 drivers/hwtracing/intel_th/pci.c  |  5 +++++
 drivers/soundwire/stream.c        | 23 +++++++++++++++++------
 3 files changed, 35 insertions(+), 9 deletions(-)
