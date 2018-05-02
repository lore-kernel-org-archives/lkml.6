Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEBVRo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:17:44 -0400
Received: from namei.org ([65.99.196.166]:59200 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEBVRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:17:42 -0400
Date: Thu, 3 May 2018 07:17:37 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Tyler Hicks <tyhicks@canonical.com>
cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] seccomp: Audit attempts to modify the actions_logged
 sysctl
In-Reply-To: <1525276400-7161-4-git-send-email-tyhicks@canonical.com>
Message-ID: <alpine.LRH.2.21.1805030717090.30206@namei.org>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com> <1525276400-7161-4-git-send-email-tyhicks@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018, Tyler Hicks wrote:

>  type=CONFIG_CHANGE msg=audit(1525275325.613:142): op=seccomp-logging
>  actions=kill_process,kill_thread,errno,trace,log
>  old-actions=kill_process,kill_thread,errno,trace,log res=1
> 
> No audit records are generated when reading the actions_logged sysctl.
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>
