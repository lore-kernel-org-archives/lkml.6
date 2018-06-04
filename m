Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeFDB7J (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:59:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39693 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeFDB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:59:08 -0400
X-Google-Smtp-Source: ADUXVKKugRhaWIuoW994jmHXgDr7TPjWDrRIZXznQXT6FZ4FmbgPDSZAM3LkQULHAYg8IdWBoP0jPRpHapMCtAIhBcY=
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180603124941.GA29497@rapoport-lnx>
In-Reply-To: <20180603124941.GA29497@rapoport-lnx>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Mon, 4 Jun 2018 09:58:55 +0800
Message-ID: <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
To: rppt@linux.vnet.ibm.com
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike
> Please keep the brief description of the function actually brief and move the detailed explanation after the parameters description.
Thanks for your advice.

> The allocation constraint is detected by the dump_header() callers, why not just use it here?
David suggest that constraint need to be printed in the oom report, so
I add the enum variable in this function.

Thanks
Wind
