Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCNUcJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:32:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33590 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCNUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:32:07 -0400
X-Google-Smtp-Source: AG47ELuU2iDP5N/SqRefMFZxzq+8DrPcoCFATjiDloz4SX0OdWfMnMcXB+AVJk0zgv4Y7pNtcVSj14q2P8XlUOCwZdM=
MIME-Version: 1.0
In-Reply-To: <20180315072716.7e9a8e25@canb.auug.org.au>
References: <20180315072716.7e9a8e25@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:32:06 +0100
X-Google-Sender-Auth: tF2nd8Yi53rdRU9w5Nipeg1cbNs
Message-ID: <CAK8P3a2wMzJx11KQ5W-EkMFf3mTdvGUp9spCQywNwJFyGJcd5g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the asm-generic tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:27 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Arnd,
>
> Commit
>
>   77b0b77f7812 ("CRIS: Drop support for the CRIS port")
>
> is missing a Signed-off-by from its committer.

Ah, I know what happened there, sorry about that and thanks a lot for
the report.
Uploading the fixed version (also including a number of new Acks) now.

        Arnd
