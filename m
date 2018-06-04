Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeFDPkI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:40:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35616 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeFDPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:40:04 -0400
X-Google-Smtp-Source: ADUXVKLuyizioNOyNZq7p2Ae0KpTpBQf644OIAUE6shS67k7hrxI4ZCuXf5kO3VwHmaBG2fBQ9FtYg==
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <20180529181740.195362-3-evgreen@chromium.org>
 <aa1a00fa24f982051af496d527b626049185edca.camel@wdc.com>
In-Reply-To: <aa1a00fa24f982051af496d527b626049185edca.camel@wdc.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 4 Jun 2018 08:39:25 -0700
X-Gmail-Original-Message-ID: <CAE=gft5UkiFAHfVWtqsdQ5=WqPkg0z5KETX2+wnFJrzdHZbZsQ@mail.gmail.com>
Message-ID: <CAE=gft5UkiFAHfVWtqsdQ5=WqPkg0z5KETX2+wnFJrzdHZbZsQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] scsi: ufs: Add config descriptor documentation
To: Bart.VanAssche@wdc.com
Cc: jejb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        Vinayak Holikatti <vinholikatti@gmail.com>, Stanislav.Nijnikov@wdc.com,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 1:35 AM Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>
> On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
> > This change adds the documentation for the new sysfs files plumbed out
> > for the UFS configuration descriptor.
>
> Shouldn't these changes be merged into the patch that adds these attributes?
>
> Bart.

Will do.
