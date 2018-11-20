Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8CAC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BB12087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BB12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbeKUB4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:56:02 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40583 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeKUB4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:56:02 -0500
Received: by mail-oi1-f176.google.com with SMTP id t204so1791144oie.7;
        Tue, 20 Nov 2018 07:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RV4jpejzcCqpczwJOehT7Z4PvwgjLeWGEDEIYNZuxs=;
        b=mQBaPtQgB0idSnfohWN4NsMSGTYjio0mQFoI4/NtpBXmHx0C9eEAp0moYoxLLK1mAA
         iJ18BiP9gGQ8Bdd47XyuH0CLtqYWqesagudRcUugu7bt3sR0PM8a6fw3/scQLXo2twII
         P5ZDQ7x0v+7djWxf4x399kcEHHSyUDEq59BuZ4KFgKwUEyXzguXb4pY6UfAwuNDQxebp
         0h4zsIzOim1+EnBjortfVsVjs7qfIKMxDy4SoZuQq7DuU/dasegLF+wgUUjm1hsLR7m3
         U5pvbqSnqOffI3fj9zA6J6kjJ17k8x9P1DVqm4ueRCQaq+KM1CbnL0bw6xYqxMQDCOae
         9Q+Q==
X-Gm-Message-State: AGRZ1gIsPblYiqWdhjw4CU+NHWVPoU8q6s7IOi4y9ywpuTNqjRGYrsb+
        Oi6n/P2iEuPWEmA2qfO4nwL/yaEWAG7cx5/Vox0=
X-Google-Smtp-Source: AJdET5ejeza/oNT/McC597SElVwDwwxHaPJoDmw05WLgs6PCmjZd5FPWe3O4k3z4zX2SxAawmseejBAx/CPK8dQdUo0=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr1360967oia.95.1542727582020;
 Tue, 20 Nov 2018 07:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20181120125731.19368-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120125731.19368-1-tiny.windzz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Nov 2018 16:26:09 +0100
Message-ID: <CAJZ5v0gY7kO-iZBLFSYHi57hsRUbsetJa0evjfmh2KCgkHLSRA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: add of_node_put()
To:     tiny.windzz@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux PM <linux-pm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> use of_node_put() to release the refcount.

Again, this changelog is as good as no changelog at all.

If you are adding a missing of_node_put(), please say that and explain
why it is necessary.

Thanks,
Rafael
