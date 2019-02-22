Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF80DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA337206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBVW7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:59:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45312 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVW7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:59:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so4387848qtg.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef2AjZ1q6Kd3Xb1MbrH/SxRpY6H7RFQJEgFL0o5tOyM=;
        b=ROpk4ZTKzdcGwjWf0uWOSH/2Iqc6eKECEvBw8FZvUmz3pH4XbBdc5VWi5v9R27EU5g
         RFG7HmRlS5n+oBuV9cF4G2ALj/6sYcYopJ2K5QUJhkqiXVpZWHK8SwWb6vU3rOasx/QX
         3oKpNYN+AAx1SBxQHBKmgdmI7EWMt+IE/y1blFDGad2ks9/JJnb8TwcXEAnyauM31qBN
         nEy/XldxgkAG+EcqoXuv1i3zx+pVh33FQ2zpfKSo3387x/8YKWCtdy7odVokT/qCEypU
         3ROTUQUDsCOzFLyTsrV1ZI34oRxp8rj77gpDg/GvyzbOlfkGf1dpU6Z6jKYKuQlo3aAK
         uHuA==
X-Gm-Message-State: AHQUAuadwlmX19QmVfIETXB27YFio/kbjSXZvkbVT8MfsQcBTdWFGfec
        t/nAC3lvDlvcVP6oFABknaVC82hg66GKgr8E6KmE2w==
X-Google-Smtp-Source: AHgI3IbFszIB+iE0lXDaRcs/TVcY9LYdIS/XgHddkULm1e2QO59NflXeD5LNRLEpgSyi0JO62yY6NrT6ZCYVpt0wYpE=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr4971861qve.180.1550876357561;
 Fri, 22 Feb 2019 14:59:17 -0800 (PST)
MIME-Version: 1.0
References: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com> <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
In-Reply-To: <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Feb 2019 23:59:00 +0100
Message-ID: <CAK8P3a1V4zgtC64yo-8wn5UCtDpT0B7nCr_XCWQ5X56k5ZSvmQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Ampere email address
To:     Khuong Dinh <khuong@os.amperecomputing.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Open Source Submission <patches@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:43 PM Khuong Dinh
<khuong@os.amperecomputing.com> wrote:
>
> Hi,
>
>    Do you have any feedback for this?
>
> Best regards,

I've picked it up for the SoC tree now.

       Arnd
