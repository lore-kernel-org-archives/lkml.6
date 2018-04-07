Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeDGSEN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 14:04:13 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34450 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeDGSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 14:04:12 -0400
X-Google-Smtp-Source: AIpwx4+tQKCjXOb6tluvJ2rNf8bZPJPqgoknuAO9HeRXHgBvf50QT12dlN0eUpJxz15D8o4hSM1eiCSvSnEPWf0tFuQ=
MIME-Version: 1.0
In-Reply-To: <20180407171906.GB30522@ZenIV.linux.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
 <CA+55aFxtS1jyefWXG+H6UjfC5KaqPOgTf3imHxL1iS1avJP5Lw@mail.gmail.com> <20180407171906.GB30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 11:04:10 -0700
X-Google-Sender-Auth: V_wReTMJNZKT3PBQMSXh_GBfQw0
Message-ID: <CA+55aFzVpZC1S2EbkZn81b7_NVrbTk7FUpcfw4NrUiPr-QFZ2Q@mail.gmail.com>
Subject: Re: [PATCH 00/20] afs: Fixes and development
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 7, 2018 at 10:19 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That, of course, can be dealt with after merge, but since that commit
> has to be at least rebased to avoid bisection hazard... might as well
> get rid of dget_parent() there at the same time.

Ok, I will skip the afs updates for now, but am open to pulling a
fixed version the second week of the merge window.

Thanks,
             Linus
