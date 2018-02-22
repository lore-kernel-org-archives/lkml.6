Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeBVTIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:08:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57933 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeBVTIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:08:16 -0500
Date: Thu, 22 Feb 2018 20:08:14 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jforbes@redhat.com
Subject: Re: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
 locked down
Message-ID: <20180222190814.a5mavnqvii5i6ptf@dwarf.suse.cz>
References: <151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
 <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
 <8846.1519309243@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8846.1519309243@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:20:43PM +0000, David Howells wrote:
> commit 87a39b258eca2e15884ee90c3fcd5758d6057b17
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Feb 22 13:42:04 2018 +0000
> 
>     kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
>     
>     This is a preparatory patch for kexec_file_load() lockdown.  A locked down
>     kernel needs to prevent unsigned kernel images to be loaded with

s/to be loaded/from being loaded/
(my own mistake :-))

Otherwise looks good. Thanks for improving my idea.

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia
