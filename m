Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeA3Oow (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbeA3Oou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:44:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACD12178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x22531ZOuHL3AkqSvg6lMJiaP+v+V0MAJPkWyMzVCD646IuPXQ5+SDzqavpgMSW8YKu+5rM+uYd200oXcH2cNHDY=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKEXtL0hvEgFALKaCgW2Go==wj14_dDomdK_hPU23oXLQ@mail.gmail.com>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de> <20180129234146.73hvclxohhme5i2w@rob-hp-laptop>
 <1517302582.5307.16.camel@diehl.com> <CAL_JsqKEXtL0hvEgFALKaCgW2Go==wj14_dDomdK_hPU23oXLQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jan 2018 08:44:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLqDGeY6o4wJV6wkr+=W0_cMf5motA1RWwDtCKjYJ51CQ@mail.gmail.com>
Message-ID: <CAL_JsqLqDGeY6o4wJV6wkr+=W0_cMf5motA1RWwDtCKjYJ51CQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 8:41 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jan 30, 2018 at 2:56 AM, Denis OSTERLAND
> <denis.osterland@diehl.com> wrote:
>> Am Montag, den 29.01.2018, 17:41 -0600 schrieb Rob Herring:
>>> On Tue, Jan 23, 2018 at 01:18:01PM +0100, Michael Grzeschik wrote:
>>> >
>>> > We add support for the ISL1219 chip that got an integrated tamper
>>> > detection function. This patch implements the feature by using an hwmon
>>> > interface.

[...]

>>> There's not much point in having an example for every compatible. This
>>> binding is simple enough, one should be enough.
>> Shell we remove the example without an interrupt?
>
> The existing example has a single interrupt, right? That should be
> enough. You just need to document for the interrupts property which
> devices have 2 interrupts and what the order is.

Looking at the first patch now, yes you can drop the 1st example and
just keep the 2nd example.

Rob
