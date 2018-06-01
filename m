Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeFAXM5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:12:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeFAXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:12:56 -0400
Date: Fri, 1 Jun 2018 16:12:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ian Kent <raven@themaw.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs: make autofs4 and autofs mutually exclusive
Message-Id: <20180601161254.eae8ea2b234ce620709a365c@linux-foundation.org>
In-Reply-To: <1527842556.2706.37.camel@themaw.net>
References: <20180529094702.4092022-1-arnd@arndb.de>
        <1527641284.2735.12.camel@themaw.net>
        <CAK8P3a3wMJoquq+3MN69Wd1EaDBgzPnzbD1a_e4cgLHq5j0b9g@mail.gmail.com>
        <1527671935.2939.15.camel@themaw.net>
        <20180531171335.6e8272916501f8b9505bc9f2@linux-foundation.org>
        <1527816954.2807.19.camel@themaw.net>
        <1527842556.2706.37.camel@themaw.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2018 16:42:36 +0800 Ian Kent <raven@themaw.net> wrote:

> The resulting "autofs-create-autofs-kconfig-and-makefile.patch" should
> now look like

Got it, thanks ;)
