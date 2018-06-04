Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeFDISt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:18:49 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:39375 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeFDISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:18:47 -0400
X-Google-Smtp-Source: ADUXVKIaEZzb790Ppa2niInX9/Um9/YSTQksRSs1ClK8u61BFmzCV8VltwOkeGKPYphNWFNb9CBYo9Ab5J13+Wo9EbQ=
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180604065238.GE19202@dhcp22.suse.cz>
In-Reply-To: <20180604065238.GE19202@dhcp22.suse.cz>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Mon, 4 Jun 2018 16:18:34 +0800
Message-ID: <CAHCio2iCdBU=xqEGqUrmc-ere-BhiS1AU052L4GfphbDPvOPqQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
To: mhocko@kernel.org
Cc: akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo
I know what you mean. Actully I refer to the code for kernel version:
3.10.0-514.  I think I can just use an array of type char, rather than
static char. Is it right?

Thanks
