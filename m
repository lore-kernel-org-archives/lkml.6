Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933092AbeE2KqD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:46:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35590 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbeE2KqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:46:02 -0400
X-Google-Smtp-Source: ADUXVKIE7B22BpWxLUkCFv/pG6diGOQQ4UIG2vaCpxjNBvAh8ZThaQ1qsdt/yJp+ZniCIYudvHPIk+GrRsn1W95z+ik=
MIME-Version: 1.0
In-Reply-To: <20180529102502.GH17671@n2100.armlinux.org.uk>
References: <20180529102301.1145470-1-arnd@arndb.de> <20180529102502.GH17671@n2100.armlinux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 May 2018 12:46:00 +0200
X-Google-Sender-Auth: Ro_Lui4eE0154bep_O6v_GKgcyk
Message-ID: <CAK8P3a2TSQAdT94KMLiQF0ZvxEM_m+nVfgcY516EDoK4mQuTvw@mail.gmail.com>
Subject: Re: [PATCH] ARM; fix cpu_v7_bugs_init reference
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:25 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Please revalidate against the latest patches, this area has changed.

Ok. I assume they will be in tomorrow's linux-next kernel?
I'll just wait for that then. Unfortunately there was no linux-next
release yesterday, so I'm still testing on last Friday's code.

      Arnd
