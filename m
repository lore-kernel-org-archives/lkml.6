Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeCEJ1W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:27:22 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:45688 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933089AbeCEJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:27:20 -0500
X-Google-Smtp-Source: AG47ELsg9sp5vvC/j2RunkHox2W3bLii7B9BfIriWlNd5rym+//v1xFkScWHSaGyEZn39/JbVUuDVA==
Date: Mon, 5 Mar 2018 18:27:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: yangwen <wen.yang99@zte.com.cn>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sergey.senozhatsky@gmail.com, bugzilla-daemon@bugzilla.kernel.org
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180305092715.GA784@jagdpanzerIV>
References: <bug-199003-14532@https.bugzilla.kernel.org/>
 <bug-199003-14532-lzL5ySZS5x@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-199003-14532-lzL5ySZS5x@https.bugzilla.kernel.org/>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Let's switch to email.

Cc-ing Petr and Steven


On (03/05/18 07:50), bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=199003
> 
> yangwen (wen.yang99@zte.com.cn) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |sergey.senozhatsky@gmail.com

Thanks, will take a look.

In the meantime, could you check this message:
  https://marc.info/?l=linux-kernel&m=152016852803716

It lists several commit IDs that you might backport and try out.
Thanks in advance!

	-ss
