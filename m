Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbeDDA7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 20:59:08 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:40782 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754059AbeDDA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 20:59:06 -0400
X-Google-Smtp-Source: AIpwx4+Qrrt3AMzwgdL5nrHr2vlSYhL00HmnDj3zry+RCxk08CuxDrwlrMnS9ThxvxoTvnc6TvXq5YXK+93rnH06vac=
MIME-Version: 1.0
In-Reply-To: <20180403143257.GN388343@devbig577.frc2.facebook.com>
References: <20180403143257.GN388343@devbig577.frc2.facebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:59:04 -0700
X-Google-Sender-Auth: qU92CT_uHphQzM0-ILv2702feg4
Message-ID: <CA+55aFyU+MnzfTfkvCgNJp+QZJdyfYrJmdzy0Z_PbxOcBTfByA@mail.gmail.com>
Subject: Re: [GIT PULL] libata changes for v4.17-rc1
To: Tejun Heo <tj@kernel.org>
Cc: IDE-ML <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 7:32 AM, Tejun Heo <tj@kernel.org> wrote:
>
> The biggest change is refcnting fix for
> ata_host - the bug is recent and can only be triggered on controller
> hotplug, so very few are hitting it.

People hotplug ATA _controllers_?   :-O

As opposed to just the disks a'la eSATA?

I knew of pcmcia ata cards ("People still do pcmcia?"), but didn't
realize it really happened elsewhere.

Regardless, pulled.

              Linus
