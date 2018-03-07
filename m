Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934924AbeCGUb2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:31:28 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35843 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934457AbeCGTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:42:22 -0500
X-Google-Smtp-Source: AG47ELsn889Cg3JKRfTRZSKAcUdVPobdWjZYEbVQhEr1i0zGOYa/xuo7kpBCZrLZz/ihRwriRo3JFtxJdLzKUUzV8/g=
MIME-Version: 1.0
In-Reply-To: <20180307193438.fogti4jodn2jgsb5@rob-hp-laptop>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-3-enric.balletbo@collabora.com> <20180307193438.fogti4jodn2jgsb5@rob-hp-laptop>
From: Alexandru Stan <amstan@google.com>
Date: Wed, 7 Mar 2018 11:42:00 -0800
Message-ID: <CAHNYxRx2kHvefaroNH_fhLcToXCH8q1TBfp-A8b0BNZ00jGL9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: phy-rockchip-typec: move extcon
 property to be optional.
To: Rob Herring <robh@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        vicencb@gmail.com, kishon@ti.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        groeck@chromium.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 11:34 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Mar 01, 2018 at 04:25:11PM +0100, Enric Balletbo i Serra wrote:
>> The extcon property is used to detect the cable-state but some boards
>> just connect the type-c phy to a regular USB-A connector without any
>> power-delivery and thus no controller reporting the cable-state.
>> So the extcon property is not really a required property, move it to be
>> optional instead.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>
>> Changes in v2:
>> - [2/6] Rewrite the justification as suggested by Heiko Stuebner.
>>
>>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>
> And extcon should be deprecated IMO.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hello Rob,

I'm currently learning a bit about USB and extcon.

Could you provide some background on why you think extcon should be
deprecated? What do you propose we replace it with?
