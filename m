Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbeDCItF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:49:05 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38469 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754961AbeDCItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:49:04 -0400
X-Google-Smtp-Source: AIpwx4/SFAI8jCacak4/keIRciKQDETNF7lCEU8pVGbL7i9rChdL+IBkYD40XINSUA/scCgNrAKNLQ==
MIME-Version: 1.0
In-Reply-To: <20180403084655.x6u7s4jzqdvq2eey@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-12-mylene.josserand@bootlin.com> <20180403084655.x6u7s4jzqdvq2eey@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Apr 2018 16:48:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v67EzOHd5_Xj9K3ZuAKVZhA4WrwfTM0gE_eR+H4mF1J4eA@mail.gmail.com>
Message-ID: <CAGb2v67EzOHd5_Xj9K3ZuAKVZhA4WrwfTM0gE_eR+H4mF1J4eA@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] ARM: sun9i: smp: Add is_sun9i field
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>, quentin.schulz@bootlin.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 4:46 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Apr 03, 2018 at 08:18:34AM +0200, Mylène Josserand wrote:
>> To prepare the support of sun8i-a83t, add a field in the smp_data
>> structure to enable the case of sun9i.
>>
>> Start to handle the differences between sun9i-a80 and sun8i-a83t
>> by using this variable.
>>
>> Add an index to retrieve which structures we are using.
>
> This should have been in a separate commit, but maybe we can store a
> pointer to the array cell we're using instead of always using the
> index?

Using a pointer would also avoid some of the code movement from the
previous patch.

ChenYu
