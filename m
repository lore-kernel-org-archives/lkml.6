Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBVTOf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:14:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeBVTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:14:30 -0500
Date: Thu, 22 Feb 2018 20:14:28 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jforbes@redhat.com
Subject: Re: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
 locked down
Message-ID: <20180222191428.mam3w3n3flc63jn2@dwarf.suse.cz>
References: <8846.1519309243@warthog.procyon.org.uk>
 <151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
 <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
 <8887.1519309313@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8887.1519309313@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:21:53PM +0000, David Howells wrote:
> commit ed0424c531d7dd25adebdec0ee6a78a5784f207a
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Feb 22 14:01:49 2018 +0000
> 
>     kexec_file: Restrict at runtime if the kernel is locked down
>     
>     When KEXEC_VERIFY_SIG is not enabled, kernel should not load images through

s/KEXEC_VERIFY_SIG/KEXEC_SIG/
Again, my mistake :/

Other than that, looks OK. Much cleaner than my version. Thanks!

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia
