Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDKOhU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:37:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753129AbeDKOhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:37:18 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFxtS1jyefWXG+H6UjfC5KaqPOgTf3imHxL1iS1avJP5Lw@mail.gmail.com>
References: <CA+55aFxtS1jyefWXG+H6UjfC5KaqPOgTf3imHxL1iS1avJP5Lw@mail.gmail.com> <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/20] afs: Fixes and development
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4443.1523457435.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 15:37:15 +0100
Message-ID: <4444.1523457435@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Now, the conflicts really do look entirely trivial, and that's not the
> problem, but the fact that you *didn't* re-send the AFS pull request
> makes me wonder if you perhaps didn't want me to pull it after all?

Al's pulled it into his tree.  I'm hoping he's going to send you a pull
request for it.

David
