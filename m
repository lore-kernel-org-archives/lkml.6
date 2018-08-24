Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E36C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AC621712
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AC621712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHXNMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:12:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39201 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeHXNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:12:01 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so14295877oig.6;
        Fri, 24 Aug 2018 02:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sdyzI8+0OBSDs1GL/ET9pqiqRmCg7LygUvQxd91347E=;
        b=AdvgvXHEpCtA9PZecQ3QSIPBVSjGbDmth0RkNtiApRyOcSrcVrOf5tgC/iURsHntvS
         /HXIxPjZUP50YS9nGsny9Mpv66cFRu7BXmD6R2eAo1skcouX9fESmurNwaqo1KoJzdHA
         myYyaPQD4GM8zULYTfIrgpSmOIiBvExcYC3JMDeWmt7CFXx0x5ob0PCKmtuXyMcmyDeb
         gYaHd9lM0oIkPHubnR5ByHjA+RZTvsMkFstDHfsa9TNtWoPfTkCjV2UY62Gqf2WUJatF
         ZCK/6Hw4B+V7T50H0eDzbpJGOHXcOAM8GUbY4qDQP2Dryn+5TzXk7gDdEL2sGR6lx8Bh
         OktQ==
X-Gm-Message-State: APzg51AbK+8yALVk7kUAbbMpCfVAHV21UWgEpVr5ibRyTqx61fRSAg6Y
        aSyWkXkYvIsmX4hVqWTGDmhEKM9GPNiA3ecxXCC3ZrEh
X-Google-Smtp-Source: ANB0VdbzqSGyMXykp8aN0CyEm15oBq7BT/fHet7PdwRbXMxFPCLn8WxiRHQgF2SJl9JyQ9pjOPKt+5Oo7qbsVCmtBSY=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr783381oii.138.1535103490790;
 Fri, 24 Aug 2018 02:38:10 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Aug 2018 11:37:59 +0200
Message-ID: <CAJZ5v0iwVRX+MJ0O2yTDo-mjVaZqv0HzEF0o=TqYKKXr2+p4KA@mail.gmail.com>
Subject: [GIT PULL] Urgent ACPI Kconfig fix for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.19-rc1-3

with top-most commit f5d707ede37a962bc3cb9b3f8531a870dae29e46

 ACPI: fix menuconfig presentation of ACPI submenu

on top of commit df2def49c57b4146520a1f4ca37bc3f494e2cd67

 Merge tag 'acpi-4.19-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an urgent ACPI Kconfig fix for 4.19-rc1.

This fixes recent menuconfig breakage causing it to present
ACPI-specific options incorrectly (Arnd Bergmann).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI: fix menuconfig presentation of ACPI submenu

---------------

 drivers/acpi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
