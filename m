Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeFDPDy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:03:54 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46680 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeFDPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:03:46 -0400
X-Google-Smtp-Source: ADUXVKITjvq9pQZ0xiAwIAQ9IwvAGCA/Tk7BNWggJXZy0qMJW52xwjrEORcAFMdcuIKAhHNr8jjsBQ==
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <CAP2JTQJaYKoYANe6C68HnkVzT6eYUq9wJQxuy71LqQ72dacv_w@mail.gmail.com>
In-Reply-To: <CAP2JTQJaYKoYANe6C68HnkVzT6eYUq9wJQxuy71LqQ72dacv_w@mail.gmail.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 4 Jun 2018 08:03:07 -0700
X-Gmail-Original-Message-ID: <CAE=gft65BVSFUm-tPEw+pGKS2Y_jbLMwUX=f8PR4aw=QF_sOMg@mail.gmail.com>
Message-ID: <CAE=gft65BVSFUm-tPEw+pGKS2Y_jbLMwUX=f8PR4aw=QF_sOMg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
To: chlrbgh0@gmail.com
Cc: Vinayak Holikatti <vinholikatti@gmail.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, stanislav.nijnikov@wdc.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyuho,

On Mon, Jun 4, 2018 at 4:11 AM Kyuho Choi <chlrbgh0@gmail.com> wrote:
>
> Hi Evan,
>
> I've some question about end user's provisioning.
>
> On 5/30/18, Evan Green <evgreen@chromium.org> wrote:
> > This series enables provisioning UFS devices using the existing sysfs
> > interface. This functionality is primarily useful along the assembly
> > line, but might also be useful for end users that receive devices that
> > aren't locked down.
>
> As we knew, ufs are mainly adopted to boot device like mobile phone.
> Usally after  provisioning operation, every data in ufs (eg. Android :
> system, userdata, boot info and etc) would be removed. How end user
> download and flash all data to ufs?. dd or another download tools?.
>

You're right, the user would need to be booted into a RAM disk, or off
of removable media like micro SD, and use dd or custom tools to set up
data inside the new provisioning scheme. So yes, on a mobile phone, it
would be a fairly advanced end user.
-Evan
