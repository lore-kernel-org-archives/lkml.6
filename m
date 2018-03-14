Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeCNUBC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:01:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36961 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNUBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:01:01 -0400
X-Google-Smtp-Source: AG47ELthGwQRKMpM4gJesRjTNyGSSBXLStucR+hswutDdQSyoJw8btAbXqru4L+f9aMa6aNgT3DVyp1qE+FphMRnT7c=
MIME-Version: 1.0
In-Reply-To: <5aa9792f.wV2Hkl94T1JHtkuH%fengguang.wu@intel.com>
References: <5aa9792f.wV2Hkl94T1JHtkuH%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:00:59 +0100
X-Google-Sender-Auth: wHWJYq5e-YcsAS0-E5lR4fHV20o
Message-ID: <CAK8P3a2cKhf9iM1DSYDAwz4m94tLA8PQxmH-87O59Ayzo5tj1w@mail.gmail.com>
Subject: Re: [asm-generic:asm-generic] BUILD SUCCESS 18fd258e74835b40a4f89f11ae933267866cc7af
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 8:34 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  asm-generic
> branch HEAD: 18fd258e74835b40a4f89f11ae933267866cc7af  staging: iio: remove iio-trig-bfin-timer driver
>
> elapsed time: 192m
>
> configs tested: 176
>
> The following configs have been built successfully.
> More configs may be tested in the coming days.
>
> blackfin                BF526-EZBRD_defconfig
> blackfin                BF533-EZKIT_defconfig
> blackfin            BF561-EZKIT-SMP_defconfig
> blackfin                  TCM-BF537_defconfig
> cris                 etrax-100lx_v2_defconfig
> mn10300                     asb2364_defconfig
> frv                                 defconfig
> tile                         tilegx_defconfig
> m32r                       m32104ut_defconfig
> m32r                     mappi3.smp_defconfig
> m32r                         opsput_defconfig
> m32r                           usrv_defconfig
> score                      spct6600_defconfig

Hi Fengguang,

Something odd is going in with the reporting here. I got individual reports for
a number of the above that they failed, but the summary for the branch
reports the builds as successful.

This branch contains the removal of blackfin, cris, mn10300, frv, tile, score,
m32r, and metag, so none of the above should be marked as successful.

You may want to prevent them from being built in the future, but it also
seems the reporting needs to be checked.

       Arnd
