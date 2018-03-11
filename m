Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeCKLRx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:17:53 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58546 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeCKLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 07:17:52 -0400
From: Richard Weinberger <richard@nod.at>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        Jeff Dike <jdike@addtoit.com>,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH 25/35] hostfs: rename do_rmdir() to hostfs_do_rmdir()
Date: Sun, 11 Mar 2018 12:19:21 +0100
Message-ID: <3779476.NRYLIFElLR@blindfold>
In-Reply-To: <20180311105557.20807-26-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net> <20180311105557.20807-26-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 11. März 2018, 11:55:47 CET schrieb Dominik Brodowski:
> do_rmdir() is used in the VFS layer at fs/namei.c, so use a different
> name in hostfs.
> 
> CC: Jeff Dike <jdike@addtoit.com>
> CC: Richard Weinberger <richard@nod.at>
> CC: user-mode-linux-devel@lists.sourceforge.net
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
