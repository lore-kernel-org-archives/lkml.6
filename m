Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325FCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CEA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CEA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJ2Xyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:54:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36586 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJ2Xyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:54:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id o125so1858348qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hrhTZ1uVj1FO+0xIx4Ncs29jQEoBrRPDAfcIfGt5aU=;
        b=jc/HbXHA9+m5d2nus0tib4Sq7pZFShLlv7m02P+16WWVkfkse9jgRXzmdj1uGjymsA
         g1B7PhmH8qQa22bbZRLdHbUNavEjQ/+Is07mQVPbLmZg1HNWGBE214qf8RXxln7egnZI
         KZDIEEpRnKKfhpCLIfDu49fFUywtysE2U00DkOUoyyFH77RsPlOOnKAwBB30EjKgkiB3
         lrAGmqt2wWE8dzYu0SrEt//ZkVA/mMnSxjTu4yMZ/A50+o2OYn4tJHTc3LhlAT0fUhhF
         A6yJ9IOmzJcmwiXEvrS/8zgTpsjBSocdLQQL1tsXpIBO53CVWJaJXf4ZKZpHDpJQIg0w
         VeRA==
X-Gm-Message-State: AGRZ1gINU73whzV0hoKbZXSkoRYv7lcPAIe5fZ+2ecwJwAiU3FBIFTcj
        Qy/ro9S7q8UKeCG1Hd6J/XHIuRGcP/npVuNoRlkW8w==
X-Google-Smtp-Source: AJdET5eSpPdxvlhV71arE/NGRckJylXk3OlEzrZiDviPOkUebgT5dIs140Txjdlf8ZYNQvBcQjVAOfmMnuYGe5MEP2c=
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr2729766qkf.194.1540825549072;
 Mon, 29 Oct 2018 08:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm> <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Oct 2018 16:05:37 +0100
Message-ID: <CAO-hwJLVY25VXyMKWD6u22gWV3mqgu1iXT3chL3rJ8zXbVbwag@mail.gmail.com>
Subject: Re: [PATCH v2] HID: moving to group maintainership model
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 2:25 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
> Date: Sat, 27 Oct 2018 14:16:13 +0200
> Subject: [PATCH] HID: moving to group maintainership model
>
> Benjamin and myself will from now on be sharing maintainership
> responsibilities for hid.git.
>
> Update maintainers to reflect that change, and also move a git
> repository to shared space at kernel.org.
>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

I guess I can answer this with:
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Jiri, would this need to go through the HID tree or some other? (I guess HID).

> ---
>
> Stephen, could you please update the hid.git URL for linux-next as below?

And thanks Stephen for updating linux-next (and yes, I have read the
linux-next inclusion topic :-P )

Cheers,
Benjamin

> Thanks.
>
> v1->v2: Update all occurences in MAINTAINERS
>
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0c4c5003998..4715cb8d9584 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6588,9 +6588,9 @@ F:        arch/*/include/asm/suspend*.h
>
>  HID CORE LAYER
>  M:     Jiri Kosina <jikos@kernel.org>
> -R:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +M:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
>  L:     linux-input@vger.kernel.org
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>  S:     Maintained
>  F:     drivers/hid/
>  F:     include/linux/hid*
> @@ -15254,9 +15254,9 @@ F:      include/linux/usb/gadget*
>
>  USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
>  M:     Jiri Kosina <jikos@kernel.org>
> -R:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +M:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
>  L:     linux-usb@vger.kernel.org
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>  S:     Maintained
>  F:     Documentation/hid/hiddev.txt
>  F:     drivers/hid/usbhid/
>
>
> --
> Jiri Kosina
> SUSE Labs
>
