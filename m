Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeDIQN5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:13:57 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:44479 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDIQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:13:55 -0400
X-Google-Smtp-Source: AIpwx49U2NAJECIqwGU19JlayxZ6/ewK/6lhMy0jvYLzZs2HRHi86gvAJWPhwPCc+aEbHx/RAB8QbHdsKBhpedJQ86I=
MIME-Version: 1.0
In-Reply-To: <20180408184409.GA27396@ivybridge.mattst88.com>
References: <20180408184409.GA27396@ivybridge.mattst88.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 09:13:53 -0700
X-Google-Sender-Auth: H0dG2SlkbNXDS_-HDltzjfroiNU
Message-ID: <CA+55aFxthoBs7HiPBPDrJy-uw8MM+bM-=CZYz4Tdtn8GALUNdQ@mail.gmail.com>
Subject: Re: [PULL] alpha.git
To: Matt Turner <mattst88@gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 11:44 AM, Matt Turner <mattst88@gmail.com> wrote:
>
> are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git
> for you to fetch changes up to cd0e00c106722eca40b38ebf11cf134c01901086:

They aren't actually where you claimed.

They are in the completely unmentioned "for-linus" branch.

Yes, yes, I can figure that out on my own (particularly since you gave
me the commit for the branch head, so I can verify using "git
ls-remote" even before pulling), but I really would like to see it in
the pull request.

              Linus
