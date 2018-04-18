Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeDRITM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:19:12 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:41471 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbeDRITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:19:08 -0400
X-Google-Smtp-Source: AIpwx483us8dRmS1QdCkS+Tr2j0wQDUWQ2fXd6rHzbpKuxwUwWgLyITfGx8KjHsRUZOJpf3GdrHlVAgcreQGDa69BUo=
MIME-Version: 1.0
In-Reply-To: <20180412150826.20988-32-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-32-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Apr 2018 11:19:07 +0300
Message-ID: <CAOQ4uxgdWCWvwWgjUu06H=BeMxh-BVAjxVE5Ckj-poKRGgwvMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 31/35] Revert "vfs: add d_real_inode() helper"
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 6:08 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> This reverts commit a118084432d642eeccb961c7c8cc61525a941fcb.
>
> No user of d_real_inode() remains, so it can be removed.
>

FYI, there is a new user in v4.17-rc1 added by commit
f0a2aa5a2a40 tracing/uprobe: Add support for overlayfs

Seems like this patch got merged without any CC to overlayfs
mailing list nor maintainer?

Not sure yet if overlayfs-rorw patches would allow reverting this
change.

Thanks,
Amir.
