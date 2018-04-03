Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeDCWpU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:45:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46333 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDCWpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:45:19 -0400
X-Google-Smtp-Source: AIpwx4/aIqMk+MZM+RHC02oH+Du0Apu8VDkHgUV3ONKc91FRlaRY54Y7Xpgryyt9+N5qsEPvaBIyPA==
Date: Tue, 03 Apr 2018 15:45:18 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 15:44:57 PDT (-0700)
Subject: Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
In-Reply-To: <20180403144544.GA3275@saruman>
CC: matt.redfearn@mips.com, antonynpavlov@gmail.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: jhogan@kernel.org
Message-ID: <mhng-0ca80fed-0881-48ef-8d61-3b104f48ecae@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018 07:45:45 PDT (-0700), jhogan@kernel.org wrote:
> On Tue, Apr 03, 2018 at 02:51:06PM +0100, Matt Redfearn wrote:
>> On 29/03/18 22:59, Palmer Dabbelt wrote:
>> > Ah, thanks, I think I must have forgotten about this.  I assume these 
>> > three are going through your tree?
>> 
>> Yeah I think that's the plan - James will need your ack to patch 2 if 
>> that's ok.
>
> Yeh, I've applied v5 for 4.17 with Palmer's reviewed-by, but I'll change
> to an ack if thats okay with Palmer.
>

Either way is OK for me.
