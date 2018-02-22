Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBVSwm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:52:42 -0500
Received: from namei.org ([65.99.196.166]:49850 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeBVSwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:52:41 -0500
Date: Fri, 23 Feb 2018 05:52:25 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Kees Cook <keescook@chromium.org>
cc: linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [GIT PULL] seccomp updates for v4.16-rc3
In-Reply-To: <20180222010411.GA34870@beast>
Message-ID: <alpine.LRH.2.21.1802230551180.2589@namei.org>
References: <20180222010411.GA34870@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Kees Cook wrote:

> Hi James,
> 
> Please pull these seccomp changes for v4.16-rc3. These are fixes for the
> get_metadata interface that landed during -rc1. While the new selftest
> is strictly not a bug fix, I think it's in the same spirit of avoiding
> bugs.

Thanks, applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc3



-- 
James Morris
<jmorris@namei.org>
