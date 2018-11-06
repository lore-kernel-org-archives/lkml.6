Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC10F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC10F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeKFRQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:16:51 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33261 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:16:50 -0500
Received: by mail-ot1-f51.google.com with SMTP id q1so10629149otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg2SahNm2lu2I4sKLh6P31dn6BJBlX6qZ0kLLCV+PIk=;
        b=ay7eSN/zshjrHjC/bPyWf1F1D/p+U+fO5Ze+f3Ged5+fdzEOm5QAbYwSDVW53QW93S
         N9xztazLFvbgG1/A5owL0mAHKz+JltHYvlquZyurUBnscqyU2OTEFPUSQ4rUxX5IoG+t
         4G9Xp5tBJ1Cyvu6A8oZo+LdW5v443PO/dpZCAeR7nY4klYyAzBGP9T3zcamc8WpC1l3c
         4cQggGm6R+9lhAimjedjtmssYrgrc9tDPpJxc6am4eA1mmPJcbVtLDuMWlEJbSDtOdwx
         kX7km74ViOVSMg3VUK7bpoJuEV28xPbLYQjSAJwyRTfLqI0xCG7Qi35rR727yt+S8A+a
         kp/w==
X-Gm-Message-State: AGRZ1gLkxo5FhQonVwa+sbpnoWsIYJtB2Gup+cM25kkJ8rKeKVb6GNYA
        tCq6/F7olF6eh7vM3Z2I41h5M6oNHlwln2lK3jw=
X-Google-Smtp-Source: AJdET5d5ylMKvDQ9dt89gG3+/GxrMWx1lIASntrXTzEDkryoeXh66tHwfZlxY0rVyyM7rdeYSVV1g/d/WMKltbTSndQ=
X-Received: by 2002:a9d:29f2:: with SMTP id g47mr14682473otd.200.1541490773294;
 Mon, 05 Nov 2018 23:52:53 -0800 (PST)
MIME-Version: 1.0
References: <bfd5f8f6-ff7d-cf85-239f-a9d4826fb2ab@infradead.org>
In-Reply-To: <bfd5f8f6-ff7d-cf85-239f-a9d4826fb2ab@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Nov 2018 08:52:42 +0100
Message-ID: <CAJZ5v0gHicDbshzv=WJP-sTLfj8Cmt2fyu3uyy+jaQ3OOOBUmA@mail.gmail.com>
Subject: Re: [PATCH] driver core: fix comments for device_block_probing()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Correct function name and spelling/typo for device_block_probing()
> in drivers/base/dd.c.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/dd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-420-rc1.orig/drivers/base/dd.c
> +++ lnx-420-rc1/drivers/base/dd.c
> @@ -179,7 +179,7 @@ static void driver_deferred_probe_trigge
>  }
>
>  /**
> - * device_block_probing() - Block/defere device's probes
> + * device_block_probing() - Block/defer device's probes
>   *
>   *     It will disable probing of devices and defer their probes instead.
>   */
> @@ -453,7 +453,7 @@ static int really_probe(struct device *d
>         if (defer_all_probes) {
>                 /*
>                  * Value of defer_all_probes can be set only by
> -                * device_defer_all_probes_enable() which, in turn, will call
> +                * device_block_probing() which, in turn, will call
>                  * wait_for_device_probe() right after that to avoid any races.
>                  */
>                 dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
>
>
