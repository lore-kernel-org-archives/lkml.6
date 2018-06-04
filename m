Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeFDPk3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:40:29 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33361 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeFDPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:40:27 -0400
X-Google-Smtp-Source: ADUXVKI7p+8rNnFZXQTh+uz94mJsZ075QPdcuGg6l0aIRt6HI5CMolsXVDRV52GJRDAKcFgmaPQ5Dg==
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <20180529181740.195362-5-evgreen@chromium.org>
 <c16dbf5a23c32a090cc84544f7a83f7dd0283d73.camel@wdc.com>
In-Reply-To: <c16dbf5a23c32a090cc84544f7a83f7dd0283d73.camel@wdc.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 4 Jun 2018 08:39:48 -0700
X-Gmail-Original-Message-ID: <CAE=gft78ikHjaZXELHS=HiLdzoCcQx=oNs_P=7=HsY1j+o8UjQ@mail.gmail.com>
Message-ID: <CAE=gft78ikHjaZXELHS=HiLdzoCcQx=oNs_P=7=HsY1j+o8UjQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] scsi: ufs: sysfs: Document attribute writability
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
> > This change removes the read-only clauses from the documentation
> > for UFS attributes, which are now writable.
>
> Also for this patch, why is this a separate patch instead of having merged
> these changes into the patch that makes the attributes writable?
>
> Bart.

I'll squash it in.
