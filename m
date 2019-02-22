Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82910206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfBVUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:54:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41623 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:54:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id y15so1965969qki.8;
        Fri, 22 Feb 2019 12:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mu8Et2pBzPGLREHvAT15/2tE1UvblEOiYeL+lALEl+E=;
        b=jnJ3rdpKNfAZIZURBjhtaANeDRJgepzDk8rMm9Gnw0CmOMbocs8n/flwcQUnY8bMwk
         K+szLDVec4Hh1QnXOOqqFtJt6MNyTXcDYgFSi6kiWyFLNv8ZEBvODpS8gzM7FUcLoFTM
         aK1MawYWsLh8naZ5AWtuGa3VhYbjO7nETrp9TVQq6V6ZR9tnaSSdhVaP3bdgausWUlgq
         G/FOrflvyD0K+hsgB5JlDjzPiuGH2RHXLRFayE85mJUe6v0RNUTe4cZZIY8lI7Ffm0Et
         hkkuwGG/pRIe+xsMAYVFG/m2CEcMQHXbjKHTLQ8aYaMUUT7xEQvXPpgOGPocp5/02qvV
         RSCQ==
X-Gm-Message-State: AHQUAuZQF6PkiQF4DL0hfuXVk2RM9uETLNyBMttmmGCfr33yhE7H6WJQ
        iDSWEv/ry08Zk+VfsbqVCU4wfVit4k34Em9UsoRA8w==
X-Google-Smtp-Source: AHgI3Iagm/26r5Swva/bm7vP95XuErXJ29HQ902kwogyoil1gSOfvZ6sO+P9TazbAXD55HyOCI2Q3rfi3g0bCx5t3X8=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr4452000qkh.173.1550868841913;
 Fri, 22 Feb 2019 12:54:01 -0800 (PST)
MIME-Version: 1.0
References: <1550748991-14362-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1550748991-14362-1-git-send-email-rppt@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Feb 2019 21:53:44 +0100
Message-ID: <CAK8P3a03ACXyehHTxtefinwEsNbA9F4Ap28SGAFqeA2W_9pq6A@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/page.h: fix typo in #error text requiring a
 real asm/page.h
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:36 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Replace "need to prove a real asm/page.h" with "need to provide a real
> asm/page.h"
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Applied, thanks!

      Arnd
