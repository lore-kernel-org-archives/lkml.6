Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4154C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9435220879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9435220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeI2UKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:10:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33703 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeI2UKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:10:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id m23-v6so8783518otf.0;
        Sat, 29 Sep 2018 06:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VxLSyNZsX/T+l0jOiPlj6YXAtmYCEZBiD3bJDO1XucY=;
        b=I7ubHV4DmGFuiaQ0orhLAl6ZoIS3pYELmtOzMLYYVawkZYc2UGsk9onItffa2bKZF5
         agdLx3ZBbXpWd/Rk3q/Tl37jcv3BAiP9lvqoEwiW/vYQ3XYFx69aM4+OHVWeMsZebKXr
         xZpGIIwFhA+6vTDhsqWETq9dYU98ib6YpYH1mtCv6esCRZanGntFc8cFDqc6rQSi0HLH
         xXYSoiWF5IzzCnpn4f+KHIAHt2QXESmkCLhvB2Z2uKpUQqp8uqAyqu5hDzhy5KvfWMCz
         uT3BgHMShSmhpQShRO10JW0j4E67paaqfjjmoJDZ4l/xzhCt0xwMtNBhonl4O3DLon95
         mEyA==
X-Gm-Message-State: ABuFfogIStnIGfk8UsQ4ZTdaUzlyWqwxRt2tJL/2TKuW5B3Z4yYJ2may
        NyZ+0gJF9nSn9MtPytuNSlaAqa+vQlpgb+mY844sNDNV
X-Google-Smtp-Source: ACcGV62mbAinAvBcv7/pWd66slmdtpx6kafaI/SyRPwzX7NhgewplMjHaKVP8hM89D6bfgwHwqQFMr63tBx3gPuhZNs=
X-Received: by 2002:a9d:2b4a:: with SMTP id f10-v6mr1903392otd.139.1538228493827;
 Sat, 29 Sep 2018 06:41:33 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 29 Sep 2018 15:41:23 +0200
Message-ID: <CAJZ5v0gwor9gvdgYrxQTL5E=mpVj8-2H2atg5ukFUmTnzopx+A@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.19-rc6
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc6

with top-most commit d51aea13dd6753186a2bea7619029c460bdf0c4c

 cpufreq: qcom-kryo: Fix section annotations

on top of commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84

 Linux 4.19-rc5

to receive a power management fix for 4.19-rc6.

This fixes incorrect __init and __exit annotations in the Qualcomm
Kryo cpufreq driver (Nathan Chancellor).

Thanks!


---------------

Nathan Chancellor (1):
      cpufreq: qcom-kryo: Fix section annotations

---------------

 drivers/cpufreq/qcom-cpufreq-kryo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
