Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162053AbeCAV0Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:26:24 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39455 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161816AbeCAV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:26:22 -0500
X-Google-Smtp-Source: AG47ELuQ1Sv8imFBT2PNAmPrGeiM9r8WvoYzPMoGQ/OTKc/3iN4Iq90V60xYSpEz/10Mfq4J4QEd1Q==
Date: Thu, 1 Mar 2018 15:26:20 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com,
        dianders@google.com, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/3] Input: gpio-keys - allow setting wakeup event
 action in DT
Message-ID: <20180301212620.bfrz6qjqsg4xkdaa@rob-hp-laptop>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-3-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210110907.5504-3-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 07:09:06PM +0800, Jeffy Chen wrote:
> Allow specifying event actions to trigger wakeup when using the
> gpio-keys input device as a wakeup source.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
