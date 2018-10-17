Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C42214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C42214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQScE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:32:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39009 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeJQScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:32:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id y81-v6so20646751oia.6;
        Wed, 17 Oct 2018 03:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qFiedoxrkhxqEF/1z2mlyHKJWlbMv4+3NU70UTmsiw=;
        b=dOGwAcYcdCURCLYoRO8i8sfOKLWwLMLJ6GqxX93z7vpSPkrylWW+xNp2GD4GyGUwyW
         QCbwZidXMn9TtcJqc566JCO/dkei+JXBD1EMAQw1j1nkkuUdD7V/M1R9N32XxGdvLHGk
         tvmxcoZqVdmpk7ko//Hd9eHmQPgPHkvkD7K1YxS1AzAdeacg2GJ4/3jvOO9DB0xvq8Zd
         jtxZZQJFvdClR/CEcCx7tBq2uyZXGRFP4y2yAEhC0Jqg3gVkMYrkc9jQrTpp9a1nLEyE
         VBmFECewg7cqEvwYhaIInAsodgfZDTfzEcxwQLTneYVDru4gEjpZ1dxmL+dlNMqieR++
         CbJQ==
X-Gm-Message-State: ABuFfojvttKTJgBt6F/b6eWty1AFfqmW8HXuoV+u60lV9HXOsCfws9EV
        KUhItjzEPu37GnAf7r1/MzGJoeGgyBtLZoC57P0=
X-Google-Smtp-Source: ACcGV61zuEP2BfRejkgIOZvCnjYfvNySKhhJBtw/N8eCo5Modmz6GFt/ThKI2fzblgFn6K2FrN51olZ9ZlYD6AZazZc=
X-Received: by 2002:aca:b655:: with SMTP id g82-v6mr12844987oif.195.1539772619281;
 Wed, 17 Oct 2018 03:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <9077862.OKK49htnqA@aspire.rjw.lan>
In-Reply-To: <9077862.OKK49htnqA@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Oct 2018 12:36:48 +0200
Message-ID: <CAJZ5v0hzn2XiH0-3VmHxzprFdAtijqmWjw528fiOpf9Jj6FkLA@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpuidle: menu: Two more refinements
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 1:57 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> The following patches are two more refinements of the menu governor (on top
> of the recent changes in linux-next now).  The are not expected to change the
> overall behavior of it.
>
> Please refer to the patch changelogs for details.

Any objections or concerns regarding the two patches?

If not, I will queue them up.

Thanks,
Rafael
