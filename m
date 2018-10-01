Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242A120C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242A120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJAW2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:28:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42503 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeJAW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:28:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id g20-v6so7266970qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13B8LdcDMTiZH0Uhv6Bik92/dfF/e9L2F+9xk5/GUZQ=;
        b=RM2oTsUg7c0amcjRn+22jhRhxTqG+cw7rt0fvPOSdMrD6rHCUNxVT9gr/8E2sWXde4
         yIQZhuKsAtTpnCXIKn/GDMVJcjpP6SmRCuKkXaQHLeFHqh5yahk27qfVqxpDchNZEBNX
         ZObcFGm6UVha+eFdKIkCF8XsC8ngJN+mDJve76F1qDVq+A5i+vo+p+jZEGNgcm0QaRSE
         DOqsNz55lC6baceXc2A0Wv8ye0tUGSiPhOcRjxhFYe/NRxSVOiUm5aklaTGGdNwOC6Cx
         E/QfTclTq3K6ufR1TW+D9pIDJ+EgmVy2KNssUSVqJCcUSedov0u3NxKTKlqXF+iob0XN
         fEvw==
X-Gm-Message-State: ABuFfohb69oxAWL79NRHL3TFUx/eXEwHrMdlCNsL97YqqmsXB1X/nABX
        E4UJVBfHlcssz3MVbjb14FgY9gjrKSgwt6nLhwI=
X-Google-Smtp-Source: ACcGV60q8wIkmDcVLzmGXth+KfWYHarwQ6pakVDcpMmlRB3lb3KuDJSuf3Uoyfb0Z+zgSqWP15QLxKPGvriblmTa9ig=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr8727332qkc.107.1538409005148;
 Mon, 01 Oct 2018 08:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <1517836201-19362-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <a90ca2a5-5d64-bb3a-babc-dc654725a062@canonical.com> <a51e8b29-9aec-a5cf-8e33-46ae5eac1fd9@canonical.com>
In-Reply-To: <a51e8b29-9aec-a5cf-8e33-46ae5eac1fd9@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 17:49:48 +0200
Message-ID: <CAK8P3a17Yb+DS8vPC3kgzL6j5SvhqOsJa3w=XOf_NDL7H40d_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Change maintainer of genwqe
To:     gpiccoli@canonical.com
Cc:     maurosr@linux.vnet.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>, haver@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com, brking@linux.ibm.com,
        haver@linux.ibm.com, maurosr@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 5:11 PM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> On 05/02/2018 11:13, Guilherme G. Piccoli wrote:
> > On 05/02/2018 11:10, Mauro S. M. Rodrigues wrote:
> >> Guilherme is no longer available to maintain the driver. I'll assume his
> >> position for now on.
> >>
> >> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> >
> > Thanks a lot Mauro!
> >
> > Acked-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> >
> >
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index b59a8cd..21ab6b9 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -5968,7 +5968,7 @@ F:     drivers/uio/uio_pci_generic.c
> >>
> >>  GENWQE (IBM Generic Workqueue Card)
> >>  M:  Frank Haverkamp <haver@linux.vnet.ibm.com>
> >> -M:  Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> >> +M:  Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> >>  S:  Supported
> >>  F:  drivers/misc/genwqe/
> >>
>
>
> Hi, I'd like to understand what is the status of this patch. Never got
> merged it seems...why?
>
> My old email wasn't valid anymore, so it's important to change it/remove
> it from the MAINTAINERS file.

Hi Guilherme,

I think what happened is that nobody felt responsible for picking
it up. The patch was sent 'to: linux-kernel@vger.kernel.org'
with a number of people in Cc but nobody listed as a recipient
personally.

I'd suggest that one of you sends it again 'To: gregkh@linuxfoundation.org'
with the subject changed to 'char: genwqe: change maintainer', so
that Greg can add it to his char-misc tree.

Please also add

Acked-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
