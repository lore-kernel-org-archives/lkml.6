Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeFDMN6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:13:58 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:42363 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:13:57 -0400
X-Google-Smtp-Source: ADUXVKIbSyZPS3oCGkYlDgYqcSc9ntGwPMGRtNdP+mZxx76VsV9D35/SB8SQ/rUr4nL2TbF+IQhD0awuPqcsxF7bHmI=
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180604065238.GE19202@dhcp22.suse.cz>
 <CAHCio2iCdBU=xqEGqUrmc-ere-BhiS1AU052L4GfphbDPvOPqQ@mail.gmail.com>
 <CAHCio2jufEO7D4AT89URi+QWYJRMXyUo0-PwobcJzm0iLUnEzQ@mail.gmail.com> <20180604095212.GH19202@dhcp22.suse.cz>
In-Reply-To: <20180604095212.GH19202@dhcp22.suse.cz>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Mon, 4 Jun 2018 20:13:44 +0800
Message-ID: <CAHCio2gQBZDi1oOh8QYbKFbB5E3eSain0soeqE3wAn=zQZeZ5A@mail.gmail.com>
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

Hi Michal
I will add the missing information in the cover-letter.

> That being said, I am ready to ack a patch which adds the memcg of the
> oom victim. I will not ack (nor nack) the patch which turns it into a
> single print because I am not sure the benefit is really worth it. Maybe
> others will though.

OK, I will use the pr_cont_cgroup_name() to print origin and kill
memcg's name. I hope David will not have other opinions :)

Thanks
