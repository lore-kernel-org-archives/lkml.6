Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeBFCob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:44:31 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:39775 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBFCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:44:24 -0500
X-Google-Smtp-Source: AH8x226ZpJBIVHlTLc66OtGarRko3QQIF17pDADz0M/c0AWyp0skV4kFsi4V58LZlY63Q0kYLF1E8GRoFjLj9hgRxxg=
MIME-Version: 1.0
In-Reply-To: <20180205214011.2d55866e@vmware.local.home>
References: <20180127031706.GE13338@ZenIV.linux.org.uk> <CAJwJo6YD4ds-AHZRm-zEyGCnu+PS-6g_FFeAmHDfaKQxQAUr=A@mail.gmail.com>
 <20180127170748.GF13338@ZenIV.linux.org.uk> <20180129225942.f2aec926e2ea223c52c34169@kernel.org>
 <20180205175433.6cd369db@gandalf.local.home> <20180206112614.80e2a9cbfc55954ab904c3e3@kernel.org>
 <20180205214011.2d55866e@vmware.local.home>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 6 Feb 2018 02:44:03 +0000
Message-ID: <CAJwJo6aYu2qAHcrYD8mTn43+4Z5ikJ6qoM7SxPtG=NuVcYtauQ@mail.gmail.com>
Subject: Re: [RFC] apparent bogosity in unregister_ftrace_function_probe_func()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-06 2:40 GMT+00:00 Steven Rostedt <rostedt@goodmis.org>:
> On Tue, 6 Feb 2018 11:26:14 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>> No, that code looks good to me. :)
>>
>> BTW, did you also remove "search = buff;" line in
>> unregister_ftrace_function_probe_func() too?
>
> That's a separate bug, and should be a separate patch. Dmitry mentioned
> that he was preparing a patch to fix that.
>
> Dmitry did you have a patch and added selftests to check it? If not,
> I'll whip one up.

Yes, I've planned to do this..
As it's merge-window now I thought doing this a week later.
So, it's up to you - just let me know so we will not end doing the same fix :)

-- 
             Dmitry
