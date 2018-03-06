Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeCFXZ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:25:58 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37454 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbeCFXZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:25:56 -0500
X-Google-Smtp-Source: AG47ELuo6XK0zEriMEouGviyz2k2KaH3EvfBLbG9/8dcC8LUM0rjcW7O540n35FcE3n5MDB2CbLNbMILbS5PjXlZbWo=
MIME-Version: 1.0
In-Reply-To: <7b724d51-52b8-6cbf-2a9d-f44f3de28dc8@ti.com>
References: <5a8c6a34.8880a70a.2a9a1.afc7@mx.google.com> <CAK8P3a0OaN6QjPdTXXXzMeYQt+WnMfvVuhza5Rb2wqdq_iEFVA@mail.gmail.com>
 <7b724d51-52b8-6cbf-2a9d-f44f3de28dc8@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 00:25:55 +0100
X-Google-Sender-Auth: A4Xu33jqVOuuCsIk7vht5pADuyY
Message-ID: <CAK8P3a2-zq95wnNYDSeTubkhr4Oc_YTSHX-NjvbD35iVNk+fWg@mail.gmail.com>
Subject: Re: mainline build: 15 warnings 0 failures (mainline/v4.16-rc2-64-gaf3e79d)
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "Olof's autobuilder" <build@lixom.net>,
        Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 3:42 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Wednesday 21 February 2018 06:12 PM, Arnd Bergmann wrote:
>> On Tue, Feb 20, 2018 at 7:34 PM, Olof's autobuilder <build@lixom.net> wrote:
>>> Here are the build results from automated periodic testing.
>>>
>>> The tree being built was mainline, found at:
>>>
>>> URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>>
>>> Warnings:
>>>
>>>         arm64.allmodconfig:
>>> include/uapi/linux/byteorder/big_endian.h:31:52: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [-Wint-conversion]
>>
>> I sent two patches to the bnxt_re maintainers yesterday. I expect them
>> to get applied
>> soon, but haven't heard back yet.
>>
>>> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o
>>
>> Still waiting for Kishon to apply an older patch I sent for this.
>
> I had merged it locally. Now pushed everything.

Hi Kishon,

kernelci still reports it as one of the remaining warnings for v4.16-rc,
any chance you can send this as a bugfix for the current release?

       Arnd
