Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEEIt3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:49:29 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33692 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:49:27 -0400
X-Google-Smtp-Source: AB8JxZoA0TFo8EAqMJlZCw7DIrGkv19eu/I/oYPTGXWf85lElSn/9n1kzzPgUfxjRL5LnD6UPP22ug==
Subject: Re: [PATCH v9 01/12] ARM: Allow this header to be included by
 assembly files
To: =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: f.fainelli@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180504190545.5114-2-mylene.josserand@bootlin.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <60ba513e-d865-d4c0-7956-7d6302020165@cogentembedded.com>
Date: Sat, 5 May 2018 11:49:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504190545.5114-2-mylene.josserand@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/4/2018 10:05 PM, Mylène Josserand wrote:

> From: Doug Berger <opendmb@gmail.com>
> 
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds

    One "this" is enough. :-)

> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
[...]

MBR, Sergei
