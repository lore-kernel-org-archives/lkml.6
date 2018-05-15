Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeEONjU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:39:20 -0400
Received: from verein.lst.de ([213.95.11.211]:41966 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753006AbeEONjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:39:19 -0400
Date: Tue, 15 May 2018 15:43:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: hch@lst.de, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] afs: Rearrange fs/afs/proc.c
Message-ID: <20180515134337.GA31066@lst.de>
References: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk> <152513042709.13808.18264656656070061524.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152513042709.13808.18264656656070061524.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I generally like this a lot, but this will conflict like mad with
my procfs series if done right now :(
