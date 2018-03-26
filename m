Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeCZPXm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:23:42 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:28130 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:23:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2QFNPsJ026974
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: AG47ELu0kvT+DciGiXI4t3++do1sUidHgYNJ5E+N+y7qTs7qvsX8htVHbR/23kp+4VuOUrZl3qnvTprHrs9SuBuXIjc=
MIME-Version: 1.0
In-Reply-To: <20180323175936.GA18412@ziepe.ca>
References: <20180323175936.GA18412@ziepe.ca>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Mar 2018 00:22:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR--43op1wQsHaBP6egbusQoEB0AcH15sjbRxAbJR=rwQ@mail.gmail.com>
Message-ID: <CAK7LNAR--43op1wQsHaBP6egbusQoEB0AcH15sjbRxAbJR=rwQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: Support GNU tar >= 1.29
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Pressler <danielpr@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-24 2:59 GMT+09:00 Jason Gunthorpe <jgg@mellanox.com>:
> There is a change in how command line parsing is done in this version.
> Excludes and includes are now ordered with the file list. Since
> the spec file puts the file list before the exclude list it means newer
> tar ignores the excludes and packs all the build output into the
> kernel-devel RPM resulting in a huge package.
>
> Simple argument re-ordering fixes the problem.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---

Applied to linux-kbuild/fixes. Thanks!






-- 
Best Regards
Masahiro Yamada
