Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeEFMwP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:52:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44701 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeEFMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:52:12 -0400
X-Google-Smtp-Source: AB8JxZpIjXo2xisuqKCu/+SqACjWuaPqvxJC6i+dGmlVaYI/0LQn5Pv+yAL+r2LB1SK2aYq0RHNH9w==
Date: Sun, 6 May 2018 15:52:08 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jonathan de Boyne Pollard
        <J.deBoynePollard-newsgroups@NTLWorld.COM>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] prctl: (Please do not!) Deprecate non PR_SET_MM_MAP
 operations
Message-ID: <20180506125208.GO31735@uranus>
References: <c8d4aa19-1bb4-3f72-4600-8d20fdad98d9@NTLWorld.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d4aa19-1bb4-3f72-4600-8d20fdad98d9@NTLWorld.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 12:01:44PM +0100, Jonathan de Boyne Pollard wrote:
...
> 
> Incidentally, it is a welcome change to see the idea that unprivileged
> processes may alter these things being introduced, as is already the case on
> (say) FreeBSD.
> 
> (I am not subscribed to linux-kernel.)

First of all, thank a lot for the feedback, Jonathan!
I'm out of office at the moment, will reply with more
details once I back.
