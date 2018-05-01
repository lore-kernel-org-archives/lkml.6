Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756108AbeEAQcq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:32:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46809 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755328AbeEAQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:32:44 -0400
X-Google-Smtp-Source: AB8JxZrvaH/zBxy9NC87UPpJz2sDZVonVHIRyEULn3+YqV81JK/TRkRxkEhxnUtro1NVqpGUl1YVQw==
Date: Tue, 01 May 2018 09:32:43 -0700 (PDT)
X-Google-Original-Date: Tue, 01 May 2018 09:31:56 PDT (-0700)
Subject: Re: [PATCH 2/3] dt-bindings: Add "sifive" vendor prefix
In-Reply-To: <20180501161439.GA28644@rob-hp-laptop>
CC: Wesley Terpstra <wesley@sifive.com>, afaerber@suse.de,
        thierry.reding@gmail.com, mark.rutland@arm.com, noralf@tronnes.org,
        david@lechnology.com, alexandre.belloni@free-electrons.com,
        sz.lin@moxa.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: robh@kernel.org
Message-ID: <mhng-4b69ea58-ea7d-458d-888d-de39bf0bd58b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2018 09:14:39 PDT (-0700), robh@kernel.org wrote:
> On Sat, Apr 28, 2018 at 10:37:56PM +0000, Wesley Terpstra wrote:
>> Will do, thanks!
>
> Don't top post to lists.
>
> I've applied this. I assume you'll have things other than the PWM...

Thanks!

We have a handful of out-of-tree drivers for our current SOC (UART, GPIO, two 
clocks, SPI, I2C) that we plan on submitting upstream as time permits.
