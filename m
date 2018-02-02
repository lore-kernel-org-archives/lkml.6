Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeBBKHv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:07:51 -0500
Received: from namei.org ([65.99.196.166]:47250 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeBBKHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:07:46 -0500
Date: Fri, 2 Feb 2018 21:07:37 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [GIT PULL] IMA bug fixes for 4.16
In-Reply-To: <1517510282.6675.13.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1802022106130.2739@namei.org>
References: <1517510282.6675.13.camel@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018, Mimi Zohar wrote:

> Hi James,
> 
> Included in this pull request are three bug fixes, assuming the 2 FUSE
> patches are considered bugs and not new features, and a maintainer update.
> I'd appreciate your sending them to Linus for 4.16.

I'd like to see an acked-by or reviewed-by from the FUSE maintainer 
(cc'd), on the FUSE patches.



> 
> Mimi
> 
> The following changes since commit 36447456e1cca853188505f2a964dbbeacfc7a7a:
> 
>   ima/policy: fix parsing of fsuuid (2018-01-18 16:52:49 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> 
> for you to fetch changes up to d56f30ac85c067d0d3a6c4f293f655dc298cb5ce:
> 
>   ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE (2018-02-01 12:38:31 -0500)
> 
> ----------------------------------------------------------------
> Alban Crequy (2):
>       fuse: introduce new fs_type flag FS_IMA_NO_CACHE
>       ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE
> 
> Mimi Zohar (2):
>       ima: re-initialize iint->atomic_flags
>       maintainers: update trusted keys
> 
>  MAINTAINERS                       |  1 +
>  fs/fuse/inode.c                   |  2 +-
>  include/linux/fs.h                |  1 +
>  security/integrity/iint.c         |  1 +
>  security/integrity/ima/ima_main.c | 15 +++++++++++++--
>  5 files changed, 17 insertions(+), 3 deletions(-)
> 

-- 
James Morris
<jmorris@namei.org>
