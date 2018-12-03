Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86328C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4720F20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4720F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLCKMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:12:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39026 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:12:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so7181844otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtNh8ae8VWZCW9TlIIuNdXe1TGb/PguqSO4vKeT7MEE=;
        b=SLqOqKOnTyaG2Etpy2tnGf81iT2eV4KBnR0J2xyy/KH4gHzjlDoZvDRy1Ma2O6xdtv
         CyHyIBqXlErFTBm+hEIZnW7dY0EhgiakJqX9yhHnk2xFvEdVeJUo9Q3IHacjplz55XW8
         LUa4kPl9KnmcM3+4a5skLaW4MVJsspG+9qK/ym8yAXsWMNVsOFVgTPGD6R2ZaSI0eIlR
         sV2QJthav3tb4pztXYOVNZaJTP/ERPFY4vnOJs5LL3UDhdksBQDxB2Oe+b8IfzHH0d/S
         gVN3KugKCtQ2KNZKZlPf+OhioqrRtNDZ8rmWvykPauO43jg2q4fS+lfgm+/Qzl4Tpe4+
         FEmQ==
X-Gm-Message-State: AA+aEWYOMksqZTbO6838y8TX1xMRW/jfAuo1KqOnakPmXsKivudRuj7A
        q9dJIo3rxLRFhrSGxr+dmnfA7SoZSnqgTkDJXB0=
X-Google-Smtp-Source: AFSGD/U9G3mgCOrjakMk1yNvnGXow6IYIwE0dPl200svldig6Sa3IF1UuI0BuQ1K5jLoM0dEQib4v1T5PEQFftpf5/0=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr9381079otn.200.1543831949022;
 Mon, 03 Dec 2018 02:12:29 -0800 (PST)
MIME-Version: 1.0
References: <1539892534-16917-1-git-send-email-daniel.lezcano@linaro.org> <e21423b4-ec9c-ae6e-0b1f-c33e659b3cb0@linaro.org>
In-Reply-To: <e21423b4-ec9c-ae6e-0b1f-c33e659b3cb0@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Dec 2018 11:12:16 +0100
Message-ID: <CAJZ5v0gHDzY9W0UG9QUDGTZGDD74ovRCj4dDFbksH0b4AoMvjg@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Add the SPDX tags
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 11:07 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 18/10/2018 21:55, Daniel Lezcano wrote:
> > The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.
> >
> > Add them and remove the license descriptions
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Hi Rafael,
>
> I think this patch passed between the cracks.

Well, please resend. :-)
