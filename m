Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeDLQzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:55:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51228 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbeDLQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:55:21 -0400
X-Google-Smtp-Source: AIpwx4/OIjlGYQRmEB5D9/UvID0IHH8+u2BfdII2N6t4OtKQldfJM3I1DBucUZbtPFm9yctZyYefC+cFPXXHPXoiePI=
MIME-Version: 1.0
In-Reply-To: <1523509711.16235.25.camel@intel.com>
References: <1523436077.16235.5.camel@intel.com> <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
 <1523509711.16235.25.camel@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 09:55:19 -0700
X-Google-Sender-Auth: cCzhApYp0QY0P3hcJwKBnDNI5Uc
Message-ID: <CA+55aFw0C-S0L-cnk0oROG=Khqy9s36O+g3_BxqPfewKGQ9_EQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Li, Philip" <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> could you please illustrate me what the kconfig & warning is?

Just "make allmodconfig" and the warning is about a uninitialized variable.

Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell history
is to be believed.

                Linus
