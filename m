Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbeFDEEu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:04:50 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39308 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeFDEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:04:48 -0400
X-Google-Smtp-Source: ADUXVKI4DbB4z+8Sl645eLjTpqg367ZjVFTOflWqb0Cbt+r3JWycdqxwAuBU0QjCy5gHIo5hZHIdpnN/xocX7iE0BFo=
MIME-Version: 1.0
In-Reply-To: <20180516045518.6876-1-ganapatrao.kulkarni@cavium.com>
References: <20180516045518.6876-1-ganapatrao.kulkarni@cavium.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Mon, 4 Jun 2018 09:34:47 +0530
Message-ID: <CAKTKpr4NycrojxFFZ+SvP0YYHrhTMyDfLi9qHG9i8ekkbUjZoA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

can you please share your review comments?

On Wed, May 16, 2018 at 10:25 AM, Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> The SoC has PMU support in L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
>
> v5:
>      -Incroporated review comments from Mark Rutland[2]
> v4:
>      -Incroporated review comments from Mark Rutland[1]
>
> [1] https://www.spinics.net/lists/arm-kernel/msg588563.html
> [2] https://lkml.org/lkml/2018/4/26/376
>
> v3:
>      - fixed warning reported by kbuild robot
>
> v2:
>      - rebased to 4.12-rc1
>      - Removed Arch VULCAN dependency.
>      - update SMC call parameters as per latest firmware.
>
> v1:
>      -Initial patch
>
> Ganapatrao Kulkarni (2):
>   perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
>   ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
>
>  Documentation/perf/thunderx2-pmu.txt |  66 +++
>  drivers/perf/Kconfig                 |   8 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/thunderx2_pmu.c         | 965 +++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h           |   1 +
>  5 files changed, 1041 insertions(+)
>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>  create mode 100644 drivers/perf/thunderx2_pmu.c
>
> --
> 2.9.4
>

thanks
Ganapat
