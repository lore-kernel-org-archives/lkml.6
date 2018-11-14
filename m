Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4802251C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4802251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeKOGWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:22:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42025 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOGWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:22:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id n46so15938639otb.9;
        Wed, 14 Nov 2018 12:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GtqFAv9KwHcyoOivYmIHnDy60NW6SOY69yVS28aIyzU=;
        b=gqIWApnqtlRmTA0n4ovK3WLlEGin6RBbKGAxLaDCHVLD40t0r/BzulgE4c7sESkKWn
         gCsoaNPPlSTATHOybhEXNWviB+XAdKWfHYH3HMUQm21JVMSAm2n1vx0Tn26G/zyWH0Ha
         eY/qejjxpywF0otMdnQ6R2YOdhPGwfn+7b8zf/0JFKrL5O1CBXAywIoBH3jRFtnAlLUw
         7ii+QPb1o9i9yQs/feVk8lEaGYmTQHrpGfzZ4N8bSRkO8QT7fmNf8HZEcCfIplPicm1z
         3l4DoWJ1uzN/TZKzlcLt31Msk7nbh50Z/ZKFPmG3Qu4Dem34f/KTz1Mb4M9TcGDk0nx+
         8SYw==
X-Gm-Message-State: AGRZ1gKhGzwJKS+RP3pj7Lvy+sllO2q8f5fhLbuwHoA3l00RRfEDxfIs
        wKbQBml9mNejz0wnAuSD5XJyV6zDR962E0dzmGTLRESC
X-Google-Smtp-Source: AJdET5c1uNEqrJl7gf2kxHOVM2MuliQAxeGRZzaWO+7ne+4W1X1lL9glO6ujoATNa8ZaI7rsR037+ERCd40KWmkzhI0=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr1856569otf.124.1542226659672;
 Wed, 14 Nov 2018 12:17:39 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Nov 2018 21:17:37 +0100
Message-ID: <CAJZ5v0h04bhHbvL3gZ2L5JpnwjGVoFWc_A5YMm4Z5Eid+WQ4oQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.20-rc3
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
 acpi-4.20-rc3

with top-most commit 017ce359a7187192df5222a00fa3c9055eb3736d

 ACPI / PMIC: xpower: fix IOSF_MBI dependency

on top of commit 651022382c7f8da46cb4872a545ee1da6d097d2a

 Linux 4.20-rc1

to receive an ACPI fix for 4.20-rc3.

This fixes a recently introduced build issue in the xpower PMIC
driver (Arnd Bergmann).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI / PMIC: xpower: fix IOSF_MBI dependency

---------------

 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
