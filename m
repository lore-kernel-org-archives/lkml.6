Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeFDGZr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:25:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43314 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeFDGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:25:45 -0400
X-Google-Smtp-Source: ADUXVKIpmsREgFeEAEc//37ZoltO+6IoYKogcT3jM/bJDADane56d5UUf3gmrterm/p7Zku37/xsUxsXqnAIwVDdKhI=
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180603124941.GA29497@rapoport-lnx>
 <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
 <CAHCio2in8NXZRanE9MS0VsSZxKaSvTy96TF59hODoNCxuQTz5A@mail.gmail.com> <20180604045812.GA15196@rapoport-lnx>
In-Reply-To: <20180604045812.GA15196@rapoport-lnx>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Mon, 4 Jun 2018 14:25:31 +0800
Message-ID: <CAHCio2i+HeB+LjqzjmQaqu7EnKOmSd4i4k73Kz2mt7bLqzw46A@mail.gmail.com>
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
> My question was why do you call to alloc_constrained in the dump_header()
>function rather than pass the constraint that was detected a bit earlier to
>that function?

Ok, I will add a  new parameter in the dump_header.

Thank you.
