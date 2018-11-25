Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C885C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0E2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC0E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeKZHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:48:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40760 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:48:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so11138328qki.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgJNJ5xCMjPr7DzOu5P7KqL4wBwZn+OM2cBRDvXf0+E=;
        b=IKHomDcDcZN5vfa6sKRc91KuLQA4Li/QRPSxa8h6AMsETMc7L6INTetpfxKNgOSrxM
         Q1gRFoc3fCybCbQ6XPGV3skVznvTHtfG/qSkEfSl0U/xrIiLdrFTz0kVtRxknQdzs50E
         iVucnU6I4t5o9OYZCqhb4pSWplSA6+BkQ7Mfpo4ZcJ+itdc1JPwQ/PH6jJ2OGQ9QWNMu
         HiD8u3QlA4GhHICRA5/fEqEQ9UFxFKuAFFoizdbs3qSgzZ1gEarbxFr/5bNy6BPtv+zT
         Ta/wEH6wC7PTo9EUqg87rPLZkvUsUA7RTd80RCsCEsNuo9fsPKYXQYD904l0dRz8bmxS
         EZ2A==
X-Gm-Message-State: AA+aEWaV5/+d0SFJ3G30CA9FeubXPIcKeUCDdODe1Ok3kZe0UIj41+nC
        2r8wNRx5SzQLUlJZ3kpmvp90wnmxICuEPFb41fI=
X-Google-Smtp-Source: AFSGD/WQC0jByn3icrj46VpXUvuF+hxMsjlIMfAyU0DaUc+EI1Nc8fidG8f6x8KS93CXV1pJz+NmeMvw3g6qpNbU2Sg=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr21957797qkf.330.1543179380475;
 Sun, 25 Nov 2018 12:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Nov 2018 21:56:04 +0100
Message-ID: <CAK8P3a29-vYa67yGoAM=c4HGnz6AJvuzD+qSUQHXmykmdTz40w@mail.gmail.com>
Subject: Re: [PATCH 1/6] char: lp: remove trailing whitespace
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 8:47 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Fix checkpatch error for trailing whitespace.
>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

All six patches
Acked-by: Arnd Bergmann <arnd@arndb.de>

They only touch whitespace and related coding style, so that's all fine.
