Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CADC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488BE218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbeLTVFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:05:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56196 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbeLTVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:05:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1ga5Vo-0008Ca-8L; Thu, 20 Dec 2018 21:05:44 +0000
Date:   Thu, 20 Dec 2018 21:05:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the vfs tree
Message-ID: <20181220210543.GX2217@ZenIV.linux.org.uk>
References: <20181221074522.0b0c986c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221074522.0b0c986c@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 07:45:22AM +1100, Stephen Rothwell wrote:
> Hi Al,
> 
> Commits
> 
>   e6cf4b0ddae8 ("teach vfs_get_tree() to handle subtype, switch do_new_mount() to it")
>   a5df92eef26f ("new helper: vfs_create_mount()")
>   84b9446c0cb2 ("mount_fs: suppress MAC on MS_SUBMOUNT as well as MS_KERNMOUNT")
>   6df9e604628d ("smack: rewrite smack_sb_eat_lsm_opts()")
>   a4fdf6490284 ("smack: get rid of match_token()")
>   b2130173efae ("smack: take the guts of smack_parse_opts_str() into a new helper")
>   324240b27f48 ("LSM: new method: ->sb_add_mnt_opt()")
>   8a2bfb0f835a ("selinux: rewrite selinux_sb_eat_lsm_opts()")
>   3cec2907c913 ("selinux: regularize Opt_... names a bit")
>   b0ab2db616c0 ("selinux: switch away from match_token()")
>   cbe9d96f42ba ("selinux: new helper - selinux_add_opt()")
>   2790a639b456 ("LSM: bury struct security_mnt_opts")
>   205b9b7a392a ("smack: switch to private smack_mnt_opts")
>   179a64d445e2 ("selinux: switch to private struct selinux_mnt_opts")
>   cb662518822e ("LSM: hide struct security_mnt_opts from any generic code")
>   6c63bb2d5323 ("selinux: kill selinux_sb_get_mnt_opts()")
>   e03db7f5411c ("LSM: turn sb_eat_lsm_opts() into a method")
>   dc0dadb3c3d7 ("nfs_remount(): don't leak, don't ignore LSM options quietly")
>   363540f775fb ("btrfs: sanitize security_mnt_opts use")
>   8f08fcb05ba6 ("selinux; don't open-code a loop in sb_finish_set_opts()")
>   144da0858c5e ("LSM: split ->sb_set_mnt_opts() out of ->sb_kern_mount()")
>   be917e5b8736 ("new helper: security_sb_eat_lsm_opts()")
>   580a8bcb268b ("LSM: lift extracting and parsing LSM options into the caller of ->sb_remount()")
>   cf891373b60a ("LSM: lift parsing LSM options into the caller of ->sb_kern_mount()")
>   d02fc3452738 ("smack: make smack_parse_opts_str() clean up on failure")
>   17f3b556a3e3 ("selinux: expand superblock_doinit() calls")
> 
> are missing a Signed-off-by from their committers.

What the...  Oh, I see - that's David adding his reviewed-by and somehow
losing my S-o-b in process...  *grumble*

Will be fixed in tomorrow push.
