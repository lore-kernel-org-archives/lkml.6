Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758950AbeBPRox (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:44:53 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36079 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756533AbeBPRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:44:52 -0500
X-Google-Smtp-Source: AH8x227dxIYGJYKf6Xeo3a03y1ka69AHpqJJDlkdJuPderFb1rWqbe9n3KxNi1IgAyqPgRAuHtvGN0VakAiDzFOVjxo=
MIME-Version: 1.0
In-Reply-To: <1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com> <1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 19:44:50 +0200
Message-ID: <CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
Subject: Re: [PATCH v21 1/5] xbitmap: Introduce xbitmap
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, mhocko@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, david@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cornelia.huck@de.ibm.com, mgorman@techsingularity.net,
        aarcange@redhat.com, amit.shah@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 9, 2018 at 1:10 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster. It supports up to
> 'unsigned long' worth of bits.

>  lib/xbitmap.c                            | 444 +++++++++++++++++++++++++++++++

Please, split tests to a separate module.

-- 
With Best Regards,
Andy Shevchenko
