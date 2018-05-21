Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeEUWzF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:55:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52836 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeEUWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:55:04 -0400
X-Google-Smtp-Source: AB8JxZqCZusUr+cpDFrGACU0PkF5UYHXcG2wUchc7fOjXwxmcs1c+cNlUEeExftDi4hqsAIUpDnUtg==
Date: Mon, 21 May 2018 16:55:00 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v2 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180521225500.GE14770@smitten>
References: <20180517151218.12850-2-tycho@tycho.ws>
 <201805191041.sVHKG1E9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805191041.sVHKG1E9%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 01:01:15PM +0800, kbuild test robot wrote:
> Hi Tycho,
> 
> I love your patch! Yet something to improve:

Whoops, seems I forgot to compile the
!CONFIG_SECCOMP_USER_NOTIFICATION case. Anyways, I've fixed this for
v3.

Tycho
