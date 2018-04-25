Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbeDYO4O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:56:14 -0400
Received: from mfb01-md.ns.itscom.net ([175.177.155.109]:55053 "EHLO
        mfb01-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754697AbeDYO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:56:01 -0400
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [RFC PATCH 00/35] overlayfs: stack file operations
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Date: Wed, 25 Apr 2018 23:49:49 +0900
Message-ID: <5342.1524667789@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi:
> This patch series reverts the VFS hacks (with the exception of d_path) and

I totally agree with removing d_real things.
It must be good to the world.

If I understand correctly, this series affects file_inode() too.
So there may exist more commits to revert such as
	fea6d2a6 2017-02-14 vfs: Use upper filesystem inode in bprm_fill_uid()

Here is another question.
Does overlayfs support atomic_open?
I remember implementing atomic_open on aufs was rather tricky many years
ago, and I am interested in how overlayfs addresses it.


J. R. Okajima
