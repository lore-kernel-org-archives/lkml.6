Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965613AbeBMT0e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:26:34 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:39011 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965315AbeBMT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:26:32 -0500
X-Google-Smtp-Source: AH8x224a5PdnSdEseZMS/gNf9uVfxQAJ6Ii1Cqp9Ld0+ngHnBnEOjXOrATBoqCp4FzR9R1yp8wNxzS6rI8pFi1sxFew=
MIME-Version: 1.0
In-Reply-To: <20180213130550.Horde.JMezTfF5lIykmPMB49PKEwG@gator4166.hostgator.com>
References: <20180213165948.GA14035@embeddedor.com> <CAHp75VfdDUooc=zy2rk8ep0PdsEsD1TGbaD9nm8DBB1NmYYTTw@mail.gmail.com>
 <20180213130550.Horde.JMezTfF5lIykmPMB49PKEwG@gator4166.hostgator.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 21:26:30 +0200
Message-ID: <CAHp75Vf2MF0cxyi+g99WUMViWGGq6B_S6nKPPfpaYWL5SvizKw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Use 64-bit arithmetic instead of 32-bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 9:05 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:

> It seems to me that it makes no sense for threshold_ns to be of type u64,
> because the expression threshold_us * 1000 will never exceed the 32-bit
> limits. So if you agree I can send a patch to change its type to u32
> instead.

Whatever Bjorn prefers.

-- 
With Best Regards,
Andy Shevchenko
