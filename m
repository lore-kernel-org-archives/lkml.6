Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDGWYx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 18:24:53 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:51188 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeDGWYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 18:24:51 -0400
X-Google-Smtp-Source: AIpwx4+MkLA3owU8fL5UTJDAZIgJmG1uvB/D9Xu4oHtEHjCyDY7h+foMsEtWaDDNRYKpcAW1WFDrpjR3lV69mxUx/Vk=
MIME-Version: 1.0
In-Reply-To: <20180213191205.7057-1-mattst88@gmail.com>
References: <20180213191205.7057-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 7 Apr 2018 15:24:30 -0700
Message-ID: <CAEdQ38FyyphUpQdfO_Jc4RAo4noVeQ+mXo5XBY04wJSAOkoAWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/power turbostat: Correct SNB_C1/C3_AUTO_UNDEMOTE
 defines
To: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:12 AM, Matt Turner <mattst88@gmail.com> wrote:
> According to the Intel Software Developers' Manual, Vol. 4, Order No.
> 335592, these macros have been reversed since they were added.
>
> Fixes: 889facbee3e6 ("tools/power turbostat: v3.0: monitor Watts and Temperature")
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Is there something I need to do to ensure these two trivial patches
get picked up?
