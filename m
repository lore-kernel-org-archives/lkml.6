Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeCFORZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:17:25 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:37071 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeCFORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:17:23 -0500
X-Google-Smtp-Source: AG47ELuF4CEwMJReD1X1JXoxnzz3SuPq84pyX49WVkX8UGRT5kS7L8K3NNyRVmYlsl6+JGER1ujO5YXl3wI18RRsb8s=
MIME-Version: 1.0
In-Reply-To: <20180301165527.22274-2-andrew.smirnov@gmail.com>
References: <20180301165527.22274-1-andrew.smirnov@gmail.com> <20180301165527.22274-2-andrew.smirnov@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Mar 2018 11:17:21 -0300
Message-ID: <CAOMZO5DTWrMS-RrDwqMg5CTjH_dCdkiyvDJ+zgje49yzbbNUhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: input: Add binding for RAVE SP input driver
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Mar 1, 2018 at 1:55 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
l
> +++ b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> @@ -0,0 +1,24 @@
> +Zodiac Inflight Innovations RAVE Supervisory Processor Power Button Bindings
> +
> +RAVE SP input device is a "MFD cell" device corresponding to power
> +button functionality of RAVE Supervisory Processor. It is expected
> +that its Device Tree node is specified as a child of the node
> +corresponding to the parent RAVE SP device (as documented in
> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> +
> +Required properties:
> +
> +- compatible: Should be "zii,rave-sp-pwrbutton"
> +
> +Example:
> +
> +       rave-sp {
> +               compatible = "zii,rave-sp-rdu1";
> +               current-speed = <38400>;
> +
> +               pwrbutton {
> +                       compatible = "zii,rave-sp-pwrbutton";
> +                       status = "okay";

In the dts patch review Shawn said:

"The okay status is to flip the state of devices that are initially
disabled.  I think it's unnecessary for the case here."

so please remove the status line.
