Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934795AbeBMQwE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:52:04 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:45776 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934060AbeBMQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:52:03 -0500
X-Google-Smtp-Source: AH8x224mZqdV08egXBbQ/waBC8RJZ1q1ST/Gq+p57VuDJsIcK8hQPEz0pBskJKZbDVoIvfH9ofX1WQ==
Date: Tue, 13 Feb 2018 08:51:59 -0800
From: Tejun Heo <tj@kernel.org>
To: whiteheadm@acm.org
Cc: jeremy@xensource.com, rusty@rustcorp.com.au, mingo@elte.hu,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: x86/stack protector: X86_32_LAZY_GS=n hangs kernel on old
 processors
Message-ID: <20180213165159.GR695913@devbig577.frc2.facebook.com>
References: <CAP8WD_bdbmAp=bYAXp--36SME5Cgn42ovz+YpjEt94fzaVt4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_bdbmAp=bYAXp--36SME5Cgn42ovz+YpjEt94fzaVt4Ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(cc'ing lkml as requested)

On Tue, Feb 13, 2018 at 11:40:17AM -0500, tedheadster wrote:
>   in your patch "x86: make lazy %gs optional on x86_32" were you able
> to test it on really old processors? In 4.16.0-rc1, X86_32_LAZY_GS got
> toggled from 'y' to 'n' in my default config because of changes to the
> stack protector code. It hangs my ancient i486 test machine right
> after 'Booting the kernel'.

I didn't have access to an i486 at the time or ever since, so it
wasn't tested there.  If this is specific to i486, flagging it so in
the config probably isn't the end of the world at this point.

Thanks.

-- 
tejun
