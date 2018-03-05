Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCEOLO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:11:14 -0500
Received: from mail-yb0-f169.google.com ([209.85.213.169]:38109 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeCEOLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:11:11 -0500
X-Google-Smtp-Source: AG47ELtpAn7hk3eiTYsdP0nSiikxyjEaN5HWWlbYIEIz+51yHuhLG0czAAq4VgBcOcLLK8x9f0wGWGySk9ElkzAi5lg=
MIME-Version: 1.0
In-Reply-To: <20180303154414.695b814c@canb.auug.org.au>
References: <20180303154414.695b814c@canb.auug.org.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Mar 2018 08:10:49 -0600
Message-ID: <CAErSpo7HNXEEYcVAeOOEf7Xk27ZzOHz5SsCP25KOyS6U=Vc6Ng@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:44 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Bjorn,
>
> Commit
>
>   a1a9f434c900 ("PCI: Rename pci_flr_wait() to pci_dev_wait() and make it generic")
>
> is missing a Signed-off-by from its committer.

Fixed, thanks!
