Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeFAJ2g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:28:36 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41539 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeFAJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:28:32 -0400
X-Google-Smtp-Source: ADUXVKLXE9GI8e8zoquWFD1eXAIfXlLFj8ez3wvnBRe2vLY6e2Kj/uVRx1m/JmHNuhuSg09F36ab6wvNrdQ7M+QqwEM=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180601092441.GA8687@stefanha-x1.localdomain>
References: <20180524202004.7813-1-stefanha@redhat.com> <20180601092441.GA8687@stefanha-x1.localdomain>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Jun 2018 11:28:31 +0200
Message-ID: <CAJfpegsWRY6be5vwtJycAc+GUvveEcdm7Zwvvx0upSA-dwCa9g@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix NULL dereference when new_inode() fails
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 11:24 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Ping?
>
> Archive link in case I broke email threading:
> https://marc.info/?l=linux-fsdevel&m=152719324102009&w=2

Thanks for the patch.  Should already be fixed in:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next

Miklos
