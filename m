Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69FD2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69FD2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeIZXGd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:06:33 -0400
Received: from mout.perfora.net ([74.208.4.194]:45717 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIZXGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:06:32 -0400
Received: from [10.173.6.6] ([178.197.234.253]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MK2aJ-1g62Oi3f65-001Ok3;
 Wed, 26 Sep 2018 18:52:34 +0200
Received: from [10.173.6.6] ([178.197.234.253]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MK2aJ-1g62Oi3f65-001Ok3;
 Wed, 26 Sep 2018 18:52:34 +0200
Date:   Wed, 26 Sep 2018 18:52:27 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180926145646.GG12980@ulmo>
References: <20180902100906.25792-1-marcel@ziswiler.com> <20180926145646.GG12980@ulmo>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 00/37] ARM: dts: tegra: colibri_t20: major revamp incl. eval board support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
From:   Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <8DE81AAE-BF2A-45F5-B638-CAAA9AA5AFCF@ziswiler.com>
X-Provags-ID: V03:K1:3AdCd3PDS3fGsIUoKpKxveVBSAnRMPlj8b+JoOjSpopCeMjIndz
 duIByh4N6iQ3RmO178fWHrGZHa5zwSU0bMojoFMwfOLqiNPiqZYQSW3CSXSsRyDkYGtxpE5
 tRpmxf8oxbX4ZZObLsg05JprKy6SIVuAK8HhHJqhQF1U9I/sfDX4AEVjuuWzGAH9uTq0xSs
 8BVdosI1zfDjDDT5CRz7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jpqGQUyH8kU=:EyswNM09V/BzMhHVDsBT7v
 7WM7zukUYN2eL27AQAdMxRkiDHdbm3J4gnlGXjm9Sx36WGL5eWnHr8qmeF/xSJIIiqt3atNT8
 w8f/4fY9/Nsr4wwPw8u9khsqd1kNLYZ+RiqCSATYq7caT84ceIjBuKMesqbztxYkJqPdmTvk7
 mvpZKmw0WAhSi2ZmbtQEJBuGQNcnueIzGfQ6MsNm9RRS7EsQSrmE4I7sBs9WEMkPxPXigddLI
 LaHNfXdzVxTCwCYbTcj3RqmGrpfx9keAOuITsAaXaqADABfAkjDtTx6PV2cfsN37pwwh+E1ho
 j9N19qvKdYPRkmJwFittqw9TxJD82rdb2cMbJRhONl42XZdX7yOv6uBJWVk9vESShvQTpIBMK
 WA38gc+9FPdAHtyxVGONOrdoTPKRLoOwzOvK795yZu34+iiu9O6atz6a/IcTeaQVVIGHrHE8N
 Qag3R4YpdSDz8hPUsHOjNjvySI9+d1gI6hxlLNNW88SGDyPCQ9B8pDLR90Dfz5ASTYQzYgo4W
 fKZ7rn5PdepKwRoJQTAZTSwS/QJnebs9PsUaJMAsJ3MteBzXeUcL/z9gzNnaK2wM5rtm6AwTc
 SRwfTOfTkfhKw1KV+Bp851Ny2U7Qn5ECgbh3XsUH8H6lmBgU86NTEmDswXUIDQeWdspKUDSdp
 OlgqJImDkPl34yeLEaEl7K6J+E9my2/pyl+2sO44SpfTqSnayr0/UqzssdgEJ8ly71k82Tp88
 M82WkF0xkh/sMoDn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry


On September 26, 2018 4:56:46 PM GMT+02:00, Thierry Reding <thierry.reding@gmail.com> wrote:
>On Sun, Sep 02, 2018 at 12:08:29PM +0200, Marcel Ziswiler wrote:
>> This series is a major overhaul and adds support for the Colibri
>> Evaluation Board device tree.
>> 
>> Changes in v2:
>> - Fix commit message which was mixed up between "[PATCH 03/31] ARM:
>>   tegra: colibri_t20: iris: annotate i2c busses" and "[PATCH 04/31]
>ARM:
>>   tegra: colibri_t20: iris: add missing aliases".
>> - Also replace underscores in node names with dashes.
>> - Also reflect this change in the Iris device tree.
>> - Also reflect this change in the device tree bindings documentation.
>> - New patch as suggested by Rob.
>> - New patch.
>> - Get rid of fake clocks simple bus as suggested by Rob.
>> - Updated evaluation board device tree with all applicable previous
>>   fixes.
>> - Also reflect this addition in the device tree bindings
>documentation.
>> 
>> Marcel Ziswiler (37):
>>   ARM: tegra: colibri_t20: move aliases from module to carrier board
>>   ARM: tegra: colibri_t20: iris: integrate i2c real time clock
>support
>>   ARM: tegra: colibri_t20: iris: add missing aliases
>>   ARM: tegra: colibri_t20: iris: annotate i2c busses
>>   ARM: tegra: colibri_t20: add local-mac-address property
>>   ARM: tegra: colibri_t20: reorder host1x/hdmi properties
>>   ARM: tegra: colibri_t20: iris: use no-1-8-v
>>   ARM: tegra: colibri_t20: regulator clean-up
>>   ARM: tegra: colibri_t20: add missing regulators
>>   ARM: tegra: colibri_t20: annotate usb ehci instances
>>   ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
>>   ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
>>   ARM: tegra: colibri_t20: update sound nvidia,model
>>   ARM: tegra: colibri_t20: pinmux clean-up
>>   ARM: tegra: colibri_t20: add missing pinmux
>>   ARM: tegra: colibri_t20: iris: display controller rgb panel support
>>   ARM: tegra: colibri_t20: iris: annotate uarts
>>   ARM: tegra: colibri_t20: iris: add uart-c
>>   ARM: tegra: colibri_t20: use high speed uart driver
>>   ARM: tegra: colibri_t20: iris: add gpio wakeup key
>>   ARM: tegra: colibri_t20: iris: add dr_mode property
>>   ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
>>   ARM: tegra: colibri_t20: add i2c-thermtrip
>>   ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
>>   ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
>>   ARM: tegra: colibri_t20: annotate/move sd card detect
>>   ARM: tegra: colibri_t20: add compatibility comment
>>   ARM: tegra: colibri_t20: simplify model and compatible properties
>>   ARM: tegra: colibri_t20: iris: simplify model and compatible
>>     properties
>>   ARM: tegra: colibri_t20: iris: add colibri ssp support
>>   ARM: tegra: colibri_t20: drop module level model and compatible
>>   ARM: tegra: colibri_t20: rename i2c_ddc to hdmi_ddc
>>   ARM: tegra: colibri_t20: iris: drop unused i2c_ddc label
>>   ARM: tegra: colibri_t20: rename tps6586x@34 and drop unused pmic
>label
>>   ARM: tegra: colibri_t20: get rid of fake clocks simple bus
>>   ARM: tegra: colibri_t20: rename ac97 label to tegra_ac97
>>   ARM: tegra: colibri_t20: add eval board device tree
>> 
>>  Documentation/devicetree/bindings/arm/tegra.txt |   5 +-
>>  arch/arm/boot/dts/Makefile                      |   1 +
>>  arch/arm/boot/dts/tegra20-colibri-eval-v3.dts   | 262 ++++++++++
>>  arch/arm/boot/dts/tegra20-colibri-iris.dts      | 200 ++++++--
>>  arch/arm/boot/dts/tegra20-colibri.dtsi          | 655
>++++++++++++++++--------
>>  5 files changed, 866 insertions(+), 257 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
>
>Applied, thanks. All of these series together have got to be some kind
>of a record.

Thank you very much!

Yeah, sorry about that. With the downstream L4T R16.5 based stuff with its 3.1.10 kernel definitely becoming obsolete, more and more of our customers switch to using mainline based stuff. After all we are still selling hundred thousands of those modules every year and hope to continue to do so many more years.

BTW: Rob's latest feedback will make it into another few patches I guess. Keep tuned...

>Thierry

Cheers

Marcel
