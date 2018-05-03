Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeECV00 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:26:26 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41123 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeECV0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:26:23 -0400
X-Google-Smtp-Source: AB8JxZrPNj/9V2zj7Y0sOiw0YqbPv0ZTEyyYaF8Bj/sBXmDZiFkfPeuIcAgsjyZmIMpysyV483hfD6IDfYkioI23CxA=
MIME-Version: 1.0
In-Reply-To: <5768c009-d659-c5d7-ae63-ea041362762d@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <25f6b309-9346-7e28-beeb-a37e69a91ce8@infradead.org>
 <ac506aa3-e5f6-9bfa-a18b-441e04b21d97@infradead.org> <CAFkk2KTE+h+UY83vvbFDgG9zcyNy4jZYg+-O3p1yOBmLH-K9Xw@mail.gmail.com>
 <5768c009-d659-c5d7-ae63-ea041362762d@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 3 May 2018 23:26:22 +0200
Message-ID: <CAFkk2KQXiWXjLjO_uOOLCDMW5-RJKT7NZ_-AT=Xm+kj5qDr4oQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 10:31 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> One minor nit (bikeshed?):  I'm not crazy about "make scriptconfig".  :)
>
> thanks,
> --
> ~Randy

To be honest, I just do

    ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
        Kconfiglib/menuconfig.py

Should probably add a target to the makefile patch. Need to pick up
environment variables somehow.

Cheers,
Ulf
