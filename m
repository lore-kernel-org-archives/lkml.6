Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934750AbeEWWSO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:18:14 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34654 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934147AbeEWWSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:18:12 -0400
X-Google-Smtp-Source: AB8JxZon1KB1qcmdYAX7huxKCj8Cn/frOnMUjoI7V3qS658TwZM1tzcv0AZOL8C8eSRWfS/+KQhj1hCrmq73oONskuk=
MIME-Version: 1.0
In-Reply-To: <20180523164931.GA3635@rob-hp-laptop>
References: <20180517130628.2770-1-andrea.greco.gapmilano@gmail.com> <20180523164931.GA3635@rob-hp-laptop>
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Date: Thu, 24 May 2018 00:17:30 +0200
Message-ID: <CAPoXtQJYmfk+-4qOpbEetUAdVwTgVPmk=mQaFv7yLF2V2dO=4A@mail.gmail.com>
Subject: Re: [PATCH 2/4] arcnet: com20020: bindings for smsc com20020
To: Rob Herring <robh@kernel.org>
Cc: "Tobin C. Harding" <tobin@apporbit.com>,
        Andrea Greco <a.greco@4sigma.it>, Mark Rutland <mark.rutland@arm.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 06:49 PM, Rob Herring wrote:
> One typo, otherwise:
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Yes typo, Fixed over my branch, sorry for that...
I expect a comment about bps, Bit per Second, used in `bus-speed-bps`
You will add it by your self in property-units.txt, or required my patch?
If your confirm that, ready for: Reviewed-by

Regards, Andrea
