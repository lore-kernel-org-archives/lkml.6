Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEBVLp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:11:45 -0400
Received: from namei.org ([65.99.196.166]:59182 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEBVLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:11:43 -0400
Date: Thu, 3 May 2018 07:11:36 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Tyler Hicks <tyhicks@canonical.com>
cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] seccomp: Configurable separator for the actions_logged
 string
In-Reply-To: <1525276400-7161-3-git-send-email-tyhicks@canonical.com>
Message-ID: <alpine.LRH.2.21.1805030711200.30206@namei.org>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com> <1525276400-7161-3-git-send-email-tyhicks@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018, Tyler Hicks wrote:

> The function that converts a bitmask of seccomp actions that are
> allowed to be logged is currently only used for constructing the display
> string for the kernel.seccomp.actions_logged sysctl. That string wants a
> space character to be used for the separator between actions.
> 
> A future patch will make use of the same function for building a string
> that will be sent to the audit subsystem for tracking modifications to
> the kernel.seccomp.actions_logged sysctl. That string will need to use a
> comma as a separator. This patch allows the separator character to be
> configurable to meet both needs.
> 
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
