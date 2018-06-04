Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeFDPmJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:42:09 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35113 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeFDPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:42:06 -0400
X-Google-Smtp-Source: ADUXVKLBp0wJ8yfQFH02Dwo6f0IvYvtPWXSVUMSvaJqoPOr1RzsDM8opO4QL33A8oS8qfbtc8fhbtg==
MIME-Version: 1.0
References: <1527849774-7623-1-git-send-email-sayalil@codeaurora.org>
 <1527849774-7623-4-git-send-email-sayalil@codeaurora.org> <000f01d3f996$2c16d1e0$844475a0$@codeaurora.org>
In-Reply-To: <000f01d3f996$2c16d1e0$844475a0$@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 4 Jun 2018 08:41:27 -0700
X-Gmail-Original-Message-ID: <CAE=gft5Lf+ydpVF6gxC0Umhs40VESJxKB4j8fNTybyzgwmTonA@mail.gmail.com>
Message-ID: <CAE=gft5Lf+ydpVF6gxC0Umhs40VESJxKB4j8fNTybyzgwmTonA@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] scsi: ufs: Add sysfs support for ufs provision
To: sayalil@codeaurora.org
Cc: linux-scsi@vger.kernel.org, stanislav.nijnikov@wdc.com,
        gregkh@linuxfoundation.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 3:49 AM sayali <sayalil@codeaurora.org> wrote:
>
> Hi Evan,
>
> I am working on upstreaming runtime UFS provisioning patches and have posted
> my latest (V1) patches for review.
> I have noticed that you are also working on the same and would appreciate if
> you could also review my patches.
> I believe it will save us all some time and duplicate effort. Let me know if
> you have any concern or comments on this.
>
> Thanks,
> Sayali
>

Hi Sayali,
I am currently travelling for work, but will make an effort to review
your patches soon. It looks like we did a bit of duplicate work. Maybe
the maintainers or community at large could let us know which approach
they prefer, or if they want both.
-Evan
