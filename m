Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53277C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0592C20644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0592C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJCPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:42:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:48078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeJCPms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:42:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE0C5AD7D;
        Wed,  3 Oct 2018 08:55:20 +0000 (UTC)
Date:   Wed, 3 Oct 2018 10:55:19 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1810031051410.14430@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive HID subsystem fixes

=====
- hantick touchpad fix from Anisse Astier
- device ID addition for Ice Lake mobile from Srinivas Pandruvada
- touchscreen resume fix for certain i2c-hid driven devices from Hans de 
  Goede
=====

Thanks.

----------------------------------------------------------------
Anisse Astier (1):
      HID: i2c-hid: disable runtime PM operations on hantick touchpad

Hans de Goede (1):
      HID: i2c-hid: Remove RESEND_REPORT_DESCR quirk and its handling

Srinivas Pandruvada (1):
      HID: intel-ish-hid: Enable Ice Lake mobile

 drivers/hid/hid-ids.h                   |  1 -
 drivers/hid/i2c-hid/i2c-hid.c           | 27 ++++++++++-----------------
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |  1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  1 +
 4 files changed, 12 insertions(+), 18 deletions(-)

-- 
Jiri Kosina
SUSE Labs

