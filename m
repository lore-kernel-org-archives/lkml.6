Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66712C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322A1214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322A1214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeKUXMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:12:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38236 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbeKUXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:12:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so487340otl.5;
        Wed, 21 Nov 2018 04:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRQr3O2Ggn1hmq3YWJFmpt3YUu/ctQVnm2DUGj3Vq8U=;
        b=BQnHs0/mSKg2qQ8S/w4Fhoe55sELbR3A/wZu+Tc8L6x4pgB7RdHNs2oaAhya55UQU6
         FjFE3pEB1i13lOcpv9ypbMyalibmBTBdwf35LTa/P3+4pSW6CJcWDBbZfxMY84ccR2j7
         5J/qAkShyPZroXrI63zU5FFucejkVvbiQU6In44NMS65NUkMScFbYoyTBhYxIwM/f6wN
         j5axngMR0zRaSd1m+yMP3GAs8Jl7V/3I2Nie8hI5BsG/UgJYLH0AaaKkuHjLUX4Xf5JK
         dxwNuSdGl7ycrPnXyCwgyawNlJE5RDWlXA73VjkJbUgVfeT9d0Gwp6WKr9YeomS5dPBg
         SF/g==
X-Gm-Message-State: AA+aEWZZh84j/PFX3q7/IBPBhe9namFW1HGNxFSvKy24gXtZxHDFPewk
        AtCeUj/nSnVmIzzCJFAUh0Lr5qtQxeYEkhdwljI=
X-Google-Smtp-Source: AFSGD/WhYdNpVe8CaAEIQQeaj9sKsgEoCfBaRy30/+SCwcddfeN79aDiTgf/B/gc7WfXP60rG+3SPjQaeKIyGTxEqLs=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr3451846ota.244.1542803891448;
 Wed, 21 Nov 2018 04:38:11 -0800 (PST)
MIME-Version: 1.0
References: <31b25f3d-f727-a94f-83cc-3258444abf11@kernel.org>
In-Reply-To: <31b25f3d-f727-a94f-83cc-3258444abf11@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Nov 2018 13:37:59 +0100
Message-ID: <CAJZ5v0jwmw2k2B68qj4A09FajDaEArv8b9GBLfthiKJ53vA31w@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 4.20-rc4
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Renninger <trenn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:16 PM shuah <shuah@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull the following update for Linux 4.20-rc4 or rc5 depending on
> your pm pull schedule to Linus.
>
> This cpupower update for Linux 4.20-rc4 consists of compile fixes to
> allow use of outside build flags and override of CFLAGS from Jiri Olsa,
> and fix to compilation with STATIC=true from Konstantin Khlebnikov.
>
> diff is attached.

Pulled, thanks!
