Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeDLABZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 20:01:25 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:40138 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDLABX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 20:01:23 -0400
X-Google-Smtp-Source: AIpwx48QDP6VJbMb6tiWVESwi86uW8gqzv0WKYA0lUtFDTBJ+2CuE4/CtaUA5H3twg0iSABTnwH2xRDR7Wgb+Cc8vDI=
MIME-Version: 1.0
In-Reply-To: <1523436077.16235.5.camel@intel.com>
References: <1523436077.16235.5.camel@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 17:01:21 -0700
X-Google-Sender-Auth: FYYtDovJzpGeHqTo3mL_h9HEYEU
Message-ID: <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 1:41 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Please pull from
>   git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

Pulled, and then immediately unpulled again.

The code causes new compiler warnings, and the warnings are valid.

If people don't care enough about their code to even check the
warnings, I'm not going to waste one second pulling the resulting
garbage. It's that simple.

                    Linus
