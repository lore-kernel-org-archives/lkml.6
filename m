Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbeAaAAL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:00:11 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35664 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbeAaAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:00:09 -0500
X-Google-Smtp-Source: AH8x226pMMyYpHWz5gfYWmu5H9py3Q9DjDcWcMaS6/EbsrG6aVWOMXZnTWNtZPC070+uOonFTIjRcA==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-axg: add RMII pins for ethernet controller
Organization: BayLibre
References: <20180111030411.197054-1-yixun.lan@amlogic.com>
        <1515659863.5048.112.camel@baylibre.com>
        <2fa28259-cce9-37fc-3bcd-6017a35a052a@amlogic.com>
        <593cbb66-7040-b27d-5109-702fb43dc18e@baylibre.com>
Date: Tue, 30 Jan 2018 16:00:06 -0800
In-Reply-To: <593cbb66-7040-b27d-5109-702fb43dc18e@baylibre.com> (Neil
        Armstrong's message of "Thu, 11 Jan 2018 10:33:27 +0100")
Message-ID: <7hvafic2yh.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0V00EtX000662

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 11/01/2018 10:11, Yixun Lan wrote:
>> Hi Jerome：
>> 
>> On 01/11/18 16:37, Jerome Brunet wrote:
>>> On Thu, 2018-01-11 at 11:04 +0800, Yixun Lan wrote:
>>>> Comparing to RGMII interface, the RMII interface require few pins.
>>>> So it's worth describing them here.
>>>>
>>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>
>>> The only axg platform we have upstream is the s400 and is using rgmii.
>>> May I ask how this was tested ?
>>>
>> It's true that S400 using RGMII interface.
>> 
>> but, we have customer using RTL8201FR-VB/VD which is a RMII PHY,
>> 
>> This is actually tested with the 'eth_rmii_x_pins' group.
>> 
>> Yixun
>> 
>
> I pushed the same for GXBB,
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64 with Neil's ack.

Kevin
