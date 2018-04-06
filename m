Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDFPXd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:23:33 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32817 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754113AbeDFN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:27:12 -0400
X-Google-Smtp-Source: AIpwx49Yq/bYv0on4hO3q4EmwtYNef0InurEgcXMd9+paGotZF/GIWv2SK4TnPsWMK1Y2YooWzOPtOGaI8MkLdtza5c=
MIME-Version: 1.0
In-Reply-To: <20180406131415.GA32103@sofia>
References: <20180406131415.GA32103@sofia>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Apr 2018 15:27:10 +0200
X-Google-Sender-Auth: 9PrWJVPJnILqsM7OoaC89f44NjI
Message-ID: <CAK8P3a2qYV01oHBmHDB0bRfx2DRB28JgRcbGDm0v2OOVDD2=hA@mail.gmail.com>
Subject: Re: [PATCH] dts: remove cris & metag dts hard link file
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 3:14 PM, Liu, Changcheng
<changcheng.liu@intel.com> wrote:
> arch cris & metag have been removed from supported archs.
> The dts hard link files should also be removed, or the ctags
> tool will give warning.
>
> execute"ctags -R", output:
> ctags: Warning: cannot open source file
> "scripts/dtc/include-prefixes/cris" : No such file or directory
> ctags: Warning: cannot open source file
> "scripts/dtc/include-prefixes/metag" : No such file or directory
>
> Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

Applied to my asm-generic tree, thanks!

      Arnd
