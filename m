Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeBFCsl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeBFCsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:48:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1C821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 21:48:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] apparent bogosity in
 unregister_ftrace_function_probe_func()
Message-ID: <20180205214832.62e83cbd@vmware.local.home>
In-Reply-To: <CAJwJo6aYu2qAHcrYD8mTn43+4Z5ikJ6qoM7SxPtG=NuVcYtauQ@mail.gmail.com>
References: <20180127031706.GE13338@ZenIV.linux.org.uk>
        <CAJwJo6YD4ds-AHZRm-zEyGCnu+PS-6g_FFeAmHDfaKQxQAUr=A@mail.gmail.com>
        <20180127170748.GF13338@ZenIV.linux.org.uk>
        <20180129225942.f2aec926e2ea223c52c34169@kernel.org>
        <20180205175433.6cd369db@gandalf.local.home>
        <20180206112614.80e2a9cbfc55954ab904c3e3@kernel.org>
        <20180205214011.2d55866e@vmware.local.home>
        <CAJwJo6aYu2qAHcrYD8mTn43+4Z5ikJ6qoM7SxPtG=NuVcYtauQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018 02:44:03 +0000
Dmitry Safonov <0x7f454c46@gmail.com> wrote:


> Yes, I've planned to do this..
> As it's merge-window now I thought doing this a week later.
> So, it's up to you - just let me know so we will not end doing the same fix :)
> 

If you haven't done it already, I'll just do it. As it will not be much
more work with the tests I'll add for Al's updates.

Note, these are bug fixes (and will mark them for stable), and I plan to
send to Linus as soon as they are ready. They don't need to wait for the
merge window.

Thanks!

-- Steve
