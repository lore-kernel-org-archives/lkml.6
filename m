Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965760AbeBMUSO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:18:14 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39274 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965648AbeBMUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:18:12 -0500
X-Google-Smtp-Source: AH8x226pEfL35hH9rzlRD4t57y9nAkIpU7IoC9/OR/Id0O9pDuEvLiKSlDO9xjdImu0jqKbZOJcfGQ==
Subject: Re: [PATCH v10 0/3] arm: npcm: add basic support for Nuvoton BMCs
To: Brendan Higgins <brendanhiggins@google.com>, robh+dt@kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, tmaimon77@gmail.com,
        avifishman70@gmail.com, julien.thierry@arm.com, pombredanne@nexb.com,
        arnd@arndb.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180213200959.160157-1-brendanhiggins@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b33b48ba-35ef-d98e-fa52-f70ed0953dcc@gmail.com>
Date: Tue, 13 Feb 2018 12:18:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213200959.160157-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 12:09 PM, Brendan Higgins wrote:
> Addressed comments from:
>  - Joel: https://www.spinics.net/lists/arm-kernel/msg634074.html
>  - Arnd: https://www.spinics.net/lists/arm-kernel/msg634091.html
> 
> Summary of changes since previous update:
>  - Replaced "nuvoton,npcm7xx-smp" compatibility string with
>    "nuvoton,npcm750-smp".
>  - Fixed some whitespace issues.
>  - Added EVB DTS to Makefile.
> 
> All changes tested on Nuvoton NPCM750 EVB.
> 

Thanks for keeping me CC, FWIW: Reviewed-by: Florian Fainelli
<f.fainelli@gmail.com>

FWIW, I don't have a vested interest in BMCs in general, just happened
to do a drive by review of your SMP code, no need to CC me on future
submissions (e.g: boards, drivers etc.). Cheers
-- 
Florian
